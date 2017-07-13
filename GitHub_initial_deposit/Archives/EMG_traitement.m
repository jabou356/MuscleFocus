%   Description: used to compute the EMG
%   Output:  gives emg struct
%   Functions: uses functions present in \\10.89.24.15\e\Project_IRSST_LeverCaisse\Codes\Functions_Matlab
%
%   Author:  Romain Martinez
%   email:   martinez.staps@gmail.com
%   Website: https://github.com/romainmartinez
%_____________________________________________________________________________
clear variables; close all; clc
%% load functions

GenericPath 
if isempty(strfind(path, [Path.ServerAddressE '\Librairies\S2M_Lib\']))
    % S2M library
    loadS2MLib;
end


%% Switch
comparaison =  '=';  % '=' (absolute) ou '%' (relative)
correctbonf =   1;   % 0 ou 1
useoldemg   =   0;   % 0 ou 1
export      =   1;   % o ou 1

%% Path
path.Datapath = [Path.ServerAddressE '\Projet_IRSST_LeverCaisse\ElaboratedData\matrices\EMG\'];
path.exportpath = [Path.ServerAddressE '\Projet_IRSST_LeverCaisse\ElaboratedData\MuscleFocus\GroupData\EMG\'];
alias.matname = dir([path.Datapath '*mat']);

%% load data
if useoldemg == 0
    for imat = length(alias.matname)-29 : -1 : 1
        % load emg data
        load([path.Datapath alias.matname(imat).name]);
        
        disp(['Traitement de ' data(1).name ' (' num2str(length(alias.matname) - imat+1) ' sur ' num2str(length(alias.matname)) ')'])
        
        % Choice of comparison (absolute or relative)
        [data] = comparison_weight(data, comparaison);
        
        [data.nsujet] = deal(imat); % subject ID
        
        % compute EMG
        bigstruct(imat).raw = emg_compute(MVC, data, freq);
       
        clearvars data freq MVC
    end
    
bigstruct = [bigstruct.raw];
% spmEMG.sex = [bigstruct.sex]';
% spmEMG.height = [bigstruct.hauteur]';
% spmEMG.weight = [bigstruct.poids]';
% spmEMG.nsubject = [bigstruct.nsujet]';
% spmEMG.time  = linspace(0,100,4000);
% spmEMG.muscle = repmat(1:13,1,length(bigstruct))';
% spmEMG.emg = [bigstruct.emg]';

for i=1:length(bigstruct)
	disp(['Now treating i=' num2str(i)])
	spmEMG.sex(13*i-12:13*i) = deal(bigstruct(i).sex)';
	spmEMG.height(13*i-12:13*i) = deal(bigstruct(i).hauteur)';
	spmEMG.weight(13*i-12:13*i) = deal(bigstruct(i).poids)';
	spmEMG.nsubject(13*i-12:13*i) = deal(bigstruct(i).nsujet)';
	spmEMG.emg(:,13*i-12:13*i) = bigstruct(i).emg;
	spmEMG.imuscle(13*i-12:13*i) = 1:13;
		
	for j=13*i-12:13*i
	spmEMG.name{j} = deal(bigstruct(i).name);
	spmEMG.trialname{j} = bigstruct(i).trialname;
	end
end


    spmEMG = isintraJB(spmEMG); % NaN on intra muscles for participants without intra

    for imuscle = 13:-1:1
    spmEMG.comp = spmEMG.emg(:,spmEMG.imuscle == imuscle); % by muscle
    
    % replace each NaN columns (muscle not recorded) by the means of other participants (same sex)
    spmEMG.comp=clean_data(spmEMG.comp);
    
    spmEMG.emg(:,spmEMG.imuscle == imuscle)=spmEMG.comp;
%     % NaN remover
%     [spm,deleted(imuscle)] = NaN_remover(spm,imuscle);
%     
%     % SPM
%     [result(imuscle).anova,result(imuscle).interaction,result(imuscle).mainA,result(imuscle).mainB] = ...
%         SPM_EMG(spm.comp',spm.sex,spm.height,spm.nsubject,imuscle,spm.time,correctbonf);
    end

    for imuscle = 13:-1:1
    spmEMG.comp = spmEMG.emg(:,spmEMG.imuscle == imuscle); % by muscle
    
    % replace each NaN columns (muscle not recorded) by the means of other participants (same sex)
    spmEMG.comp=clean_dataSmallEMG(spmEMG.comp);
    
    spmEMG.emg(:,spmEMG.imuscle == imuscle)=spmEMG.comp;
%     % NaN remover
%     [spm,deleted(imuscle)] = NaN_remover(spm,imuscle);
%     
%     % SPM
%     [result(imuscle).anova,result(imuscle).interaction,result(imuscle).mainA,result(imuscle).mainB] = ...
%         SPM_EMG(spm.comp',spm.sex,spm.height,spm.nsubject,imuscle,spm.time,correctbonf);
end
    save('\\10.89.24.15\e\Projet_IRSST_LeverCaisse\ElaboratedData\MuscleFocus\GroupData\EMG\spmEMG.mat','spmEMG')
else
    disp('Loading, please wait.')
    load('\\10.89.24.15\e\Projet_IRSST_LeverCaisse\ElaboratedData\MuscleFocus\GroupData\bigstructEMG.mat')
end

