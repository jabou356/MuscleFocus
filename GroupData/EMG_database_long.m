%   Description: Used to generate a group structure with EMG data
%_____________________________________________________________________________
clear; close all; clc

Muscles={'DeltA', 'DeltM', 'DeltP', 'BB', 'TB', 'UpTrap',...
    'LowTrap', 'SerrAnt', 'Supra', 'Infra', 'SubScap',...
    'Pect', 'Lat'};
%% Switch
useold = 0;
%% load Path and subjects

GenericPath

alias.matname = dir([Path.RBIEMG '*mat']);

%% load data
if useold == 0 
    
    for imat = length(alias.matname) : -1 : 1
        
        % load emg data
        load([Path.RBIEMG alias.matname(imat).name]);
        
        disp(['Traitement de ' data(1).name ' (' num2str(length(alias.matname) - imat+1) ' sur ' num2str(length(alias.matname)) ')'])
        
        %% Build the group  matrix: 39 lines per subject: 3 weight (18kg = nan for women) * 13 muscles)
        GroupData.sex((imat-1)*39+1:imat*39) = deal(data(1).sex)';
        GroupData.name((imat-1)*39+1:imat*39) = deal({data(1).name})';
        GroupData.muscle((imat-1)*39+1:imat*39) = repmat(Muscles,1,3);
        GroupData.SID((imat-1)*39+1:imat*39) = imat;
        
        %% for each weight, average all 3 trials from hip to eye (height 2)
        poids =[6, 12 ,18];
        for ipoids = 1:3
            GroupData.poids((imat-1)*39 + (ipoids-1)*13 + 1:(imat-1)*39 + (ipoids-1)*13 + 13) = poids(ipoids);
         
            if ipoids == 3 && data(1).sex == 2 % women 18 kg doesn't exist
                
                GroupData.emg((imat-1)*39+(ipoids-1)*13 +1:(imat-1)*39+(ipoids-1)*13 +13,1:4000) = nan;
                
            else% si c'est 6 kg ou 12 kg, ou 18kg man
                
                trials = find(arrayfun(@(x)(x.poids == poids(ipoids)),data) & arrayfun(@(x)(x.hauteur == 2),data));
                temp = [data(trials).Normemg];
                
                for imuscle = 13:-1:1
                    emgdata = temp(:,imuscle:13:end)';
                    GroupData.emg((imat-1)*39 + (ipoids-1)*13 + imuscle,:) = nanmean(emgdata);
                end
           
            end
            
        end
        
        
        clearvars data freq MVC
    end
end