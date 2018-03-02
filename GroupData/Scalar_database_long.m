%   Description: Used to generate a group structure with EMG data
%_____________________________________________________________________________
clear; close all; clc

Muscle={'DELT3','DELT2','DELT1','INFSP','SUPSP', 'SUBSC',...
    'LAT','PECM1' };%% Switch
useold = 0;
%% load Path and subjects

GenericPath

alias.matname = dir([Path.ServerAddressE '/Projet_IRSST_LeverCaisse/Elaborateddata/matrices/MuscleForceDir/Wu/' '*mat']);

%% load data
if useold == 0
    
    for imat = length(alias.matname)  : -1 : 1
        
        % load emg data
    load([Path.ServerAddressE '/Projet_IRSST_LeverCaisse/Elaborateddata/matrices/MuscleForceDir/Wu/' alias.matname(imat).name])
        
        disp(['Traitement de ' alias.matname(imat).name ' (' num2str(length(alias.matname) - imat+1) ' sur ' num2str(length(alias.matname)) ')'])
        
        %% Build the group  matrix: 12 lines per subject: 3 weight (18kg = nan for women) * 4 variables)
        Groupdata.sexe((imat-1)*84+1:imat*84) = deal({data(1).sexe})';
        Groupdata.name((imat-1)*84+1:imat*84) = deal({alias.matname(imat).name})';
        Groupdata.SID((imat-1)*84+1:imat*84) = imat;
        
        %% for each weight, average all 3 trials from hip to eye (height 2)
        poids =[6, 12 ,18];
        for ipoids = 1:3
            
            for imuscle1=1:length(Muscle)-1
                for imuscle2 = imuscle1+1:length(Muscle)
                    indX = (imat-1)*84 + (ipoids-1)*28 + 28-(length(Muscle)-imuscle1)/2*(length(Muscle)-imuscle1+1)+imuscle2-imuscle1;
                    
            Groupdata.poids(indX) = poids(ipoids);
            Groupdata.variable(indX) = {[Muscle{imuscle1}, 'x', Muscle{imuscle2}]};
         
            if ipoids == 3 && strcmp(data(1).sexe,'F') % women 18 kg doesn't exist
                
                Groupdata.Scalardata(indX,1:4000) = nan;
                
            else% si c'est 6 kg ou 12 kg, ou 18kg man
                
                trials = find(arrayfun(@(x)(x.poids == poids(ipoids)),data) & arrayfun(@(x)(x.hauteur == 2),data) & arrayfun(@(x)(length(x.dInt)>1),data));
                
                if length(trials)>0
                temp = cell2mat(arrayfun(@(x)(dot(x.dInt(:,:,imuscle1),x.dInt(:,:,imuscle2),2)),data(trials),'UniformOutput',false)); % je ne comprends pas pourquoi il me force à dire que le output n'est pas uniforme
                
                Groupdata.Scalardata(indX,:) = nanmean(temp,2)';
                else
                Groupdata.Scalardata(indX,1:4000) = nan;  
                end
                
           
            end
            
        end
        
        
         
        end
        end
        clearvars data 

    end
end

