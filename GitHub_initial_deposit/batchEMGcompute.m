clear variables; close all; clc
%% load functions

GenericPath
% if isempty(strfind(path, [Path.ServerAddressE '\Librairies\S2M_Lib\']))
% 	% S2M library
% 	loadS2MLib;
% end

%% Path
path.Datapath = [Path.ServerAddressE '\Projet_IRSST_LeverCaisse\ElaboratedData\matrices\EMG\'];
path.exportpath = [Path.ServerAddressE '\Projet_IRSST_LeverCaisse\ElaboratedData\MuscleFocus\GroupData\EMG\'];
alias.matname = dir([path.Datapath '*mat']);

for imat = length(alias.matname)-41 : -1 : 1
	% load emg data
	load([path.Datapath alias.matname(imat).name]);
	
	disp(['Traitement de ' data(1).name ' (' num2str(length(alias.matname) - imat+1) ' sur ' num2str(length(alias.matname)) ')'])
	
	
	data = emg_compute(MVC, data, freq);
	
	for imuscle = 13:-1:1
		for itrial =length(data):-1:1
			comp(:,itrial)=data(itrial).emg(:,imuscle);
		end
		%spmEMG.comp = data.emg(:,imuscle); % by muscle
		
		% replace each NaN columns (muscle not recorded) by the means of other participants (same sex)
		[idx1,comp]=clean_data(comp,imuscle,data(1).name);
		%[idx2,comp]=clean_dataSmallEMG(comp);
		
		for itrial =length(data):-1:1
			data(itrial).emg(:,imuscle)=comp(:,itrial);
		end
		data(imuscle).novalidemg=[idx1]%;idx2];
		
		clear comp
		
	end
	
	%     % NaN remover
	%     [spm,deleted(imuscle)] = NaN_remover(spm,imuscle);
	%
	%     % SPM
	%     [result(imuscle).anova,result(imuscle).interaction,result(imuscle).mainA,result(imuscle).mainB] = ...
	%         SPM_EMG(spm.comp',spm.sex,spm.height,spm.nsubject,imuscle,spm.time,correctbonf);
Path.rbiEMG=[Path.ServerAddressE '\Projet_IRSST_LeverCaisse\ElaboratedData\matrices\rbiEMG\' alias.matname(imat).name];
    save(Path.rbiEMG,'data')

 clearvars data freq MVC
end

%spmEMG = isintraJB(spmEMG);