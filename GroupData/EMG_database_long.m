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
        
        %% for each weight, average all 3 trials from hip to eye (height 2)
        poids =[6, 12 ,18];
        for ipoids = 1:3
         
            if ipoids ~=3 || data(1).sex == 1 % si c'est 6 kg ou 12 kg, ou 18kg man
                
                trials = find(arrayfun(@(x)(x.poids == poids(ipoids)),data) & arrayfun(@(x)(x.hauteur == 2),data));
                temp = [data(trials).emg];
                
                for imuscle = 13:-1:1
                    emgdata = temp(:,imuscle:13:end)';
                    GroupData.emg((imat-1)*39 + (ipoids-1)*13 + imuscle,:) = nanmean(emgdata);
                end
            else % women 18 kg doesn't exist
                
                GroupData.emg((imat-1)*39+1:imat*39,:) = nan;
            end
            
        end
        
        
        clearvars data freq MVC
    end
end
%
% bigstruct = [bigstruct.raw];
% % spmEMG.sex = [bigstruct.sex]';
% % spmEMG.height = [bigstruct.hauteur]';
% % spmEMG.weight = [bigstruct.poids]';
% % spmEMG.nsubject = [bigstruct.nsujet]';
% % spmEMG.time  = linspace(0,100,4000);
% % spmEMG.muscle = repmat(1:13,1,length(bigstruct))';
% % spmEMG.emg = [bigstruct.emg]';
%
% for i=1:length(bigstruct)
% 	disp(['Now treating i=' num2str(i)])
% 	spmEMG.sex(13*i-12:13*i) = deal(bigstruct(i).sex)';
% 	spmEMG.height(13*i-12:13*i) = deal(bigstruct(i).hauteur)';
% 	spmEMG.weight(13*i-12:13*i) = deal(bigstruct(i).poids)';
% 	spmEMG.nsubject(13*i-12:13*i) = deal(bigstruct(i).nsujet)';
% 	spmEMG.emg(:,13*i-12:13*i) = bigstruct(i).emg;
% 	spmEMG.imuscle(13*i-12:13*i) = 1:13;
%
% 	for j=13*i-12:13*i
% 	spmEMG.name{j} = deal(bigstruct(i).name);
% 	spmEMG.trialname{j} = bigstruct(i).trialname;
% 	end
% end
%
%
%     spmEMG = isintraJB(spmEMG); % NaN on intra muscles for participants without intra
%
%     for imuscle = 13:-1:1
%     spmEMG.comp = spmEMG.emg(:,spmEMG.imuscle == imuscle); % by muscle
%
%     % replace each NaN columns (muscle not recorded) by the means of other participants (same sex)
%     spmEMG.comp=clean_data(spmEMG.comp);
%
%     spmEMG.emg(:,spmEMG.imuscle == imuscle)=spmEMG.comp;
% %     % NaN remover
% %     [spm,deleted(imuscle)] = NaN_remover(spm,imuscle);
% %
% %     % SPM
% %     [result(imuscle).anova,result(imuscle).interaction,result(imuscle).mainA,result(imuscle).mainB] = ...
% %         SPM_EMG(spm.comp',spm.sex,spm.height,spm.nsubject,imuscle,spm.time,correctbonf);
%     end
%
%     for imuscle = 13:-1:1
%     spmEMG.comp = spmEMG.emg(:,spmEMG.imuscle == imuscle); % by muscle
%
%     % replace each NaN columns (muscle not recorded) by the means of other participants (same sex)
%     spmEMG.comp=clean_dataSmallEMG(spmEMG.comp);
%
%     spmEMG.emg(:,spmEMG.imuscle == imuscle)=spmEMG.comp;
% %     % NaN remover
% %     [spm,deleted(imuscle)] = NaN_remover(spm,imuscle);
% %
% %     % SPM
% %     [result(imuscle).anova,result(imuscle).interaction,result(imuscle).mainA,result(imuscle).mainB] = ...
% %         SPM_EMG(spm.comp',spm.sex,spm.height,spm.nsubject,imuscle,spm.time,correctbonf);
% end
%     save('\\10.89.24.15\e\Projet_IRSST_LeverCaisse\ElaboratedData\MuscleFocus\GroupData\EMG\spmEMG.mat','spmEMG')
% else
%     disp('Loading, please wait.')
%     load('\\10.89.24.15\e\Projet_IRSST_LeverCaisse\ElaboratedData\MuscleFocus\GroupData\bigstructEMG.mat')
% end
%
