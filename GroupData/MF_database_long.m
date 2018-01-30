%   Description: Used to generate a group structure with EMG data
%_____________________________________________________________________________
clear; close all; clc

Variables={'MFBlache', 'DENOMINATORBlache', 'MFallmuscles', 'DENOMINATORallmuscles'};
%% Switch
useold = 0;
%% load Path and subjects

GenericPath

alias.matname = dir([Path.MF '*mat']);

%% load data
if useold == 0
    
    for imat = length(alias.matname) : -1 : 1
        
        % load emg data
        load([Path.MF alias.matname(imat).name]);
        
        disp(['Traitement de ' Data(1).name ' (' num2str(length(alias.matname) - imat+1) ' sur ' num2str(length(alias.matname)) ')'])
        
        %% Build the group  matrix: 12 lines per subject: 3 weight (18kg = nan for women) * 4 variables)
        GroupData.sex((imat-1)*12+1:imat*12) = deal(Data(1).sex)';
        GroupData.name((imat-1)*12+1:imat*12) = deal({Data(1).name})';
        %GroupData.muscle((imat-1)*12+1:imat*12) = repmat(Muscles,1,3);
        GroupData.SID((imat-1)*12+1:imat*12) = imat;
        
        %% for each weight, average all 3 trials from hip to eye (height 2)
        poids =[6, 12 ,18];
        for ipoids = 1:3
            
            for ivar=1:4
            GroupData.poids((imat-1)*12 + (ipoids-1)*4 +ivar) = poids(ipoids);
            GroupData.variable((imat-1)*12 + (ipoids-1)*4 + ivar) = Variables(ivar);
         
            if ipoids == 3 && Data(1).sex == 2 % women 18 kg doesn't exist
                
                GroupData.MFdata((imat-1)*12+(ipoids-1)*4 +ivar,1:4000) = nan;
                
            else% si c'est 6 kg ou 12 kg, ou 18kg man
                
                trials = find(arrayfun(@(x)(x.poids == poids(ipoids)),Data) & arrayfun(@(x)(x.hauteur == 2),Data));
                temp = [Data(trials).(Variables{ivar})]';
                
                GroupData.MFdata((imat-1)*12 + (ipoids-1)*4 + ivar,:) = nanmean(temp);
                
           
            end
            
        end
        
        
         
        end
    clearvars Data 
    end
end

