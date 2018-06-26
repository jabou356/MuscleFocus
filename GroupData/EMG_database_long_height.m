%   Description: Used to generate a group structure with EMG data: 
%Women 6kg, Men 12 kg. To shoulder vs to eye level
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
        GroupData.sex((imat-1)*26+1:imat*26) = deal(data(1).sex)';
        GroupData.name((imat-1)*26+1:imat*26) = deal({data(1).name})';
        GroupData.muscle((imat-1)*26+1:imat*26) = repmat(Muscles,1,2);
        GroupData.SID((imat-1)*26+1:imat*26) = imat;
        
        %% for each weight, average all 3 trials from hip to eye (height 2)
        height =[1, 2];
        for ihauteur = 1:2
            GroupData.height((imat-1)*26 + (ihauteur-1)*13 + 1:(imat-1)*26 + (ihauteur-1)*13 + 13) = height(ihauteur);
         
            if data(1).sex == 2 % if women, use 6 kg
                trials = find(arrayfun(@(x)(x.poids == 6),data) & arrayfun(@(x)(x.hauteur == height(ihauteur)),data));
                
            elseif data(1).sex == 1 % if men, use 12 kg
                
                trials = find(arrayfun(@(x)(x.poids == 12),data) & arrayfun(@(x)(x.hauteur == height(ihauteur)),data));
            end
                           
            temp = [data(trials).emg];
                
            for imuscle = 13:-1:1
                emgdata = temp(:,imuscle:13:end)';
                GroupData.emg((imat-1)*26 + (ihauteur-1)*13 + imuscle,:) = nanmean(emgdata);
            end
      
        end
        
        
        clearvars data freq MVC
    end
end