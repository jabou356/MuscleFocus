clear variables; close all; clc
%% load functions

GenericPath
% if isempty(strfind(path, [Path.ServerAddressE '\Librairies\S2M_Lib\']))
% 	% S2M library
% 	loadS2MLib;
% end

%% Path
path.Datapath = [Path.ServerAddressE '\Projet_IRSST_LeverCaisse\ElaboratedData\matrices\EMG\'];
alias.matname = dir([path.Datapath '*mat']);

for imat = 28
	% load emg data
	load([path.Datapath alias.matname(imat).name]);
    load([path.Datapath 'mvc_2\mvc\' alias.matname(imat).name]); 
	
	disp(['Traitement de ' data(1).name ' (' num2str(length(alias.matname) - imat+1) ' sur ' num2str(length(alias.matname)) ')'])
	
	% Filter and normalize EMG
	data = emg_compute(mvc, data, freq);
	
    %Clean EMG
	for imuscle = 13:-1:1
        
		for itrial =length(data):-1:1
			comp(:,itrial)=data(itrial).Normemg(:,imuscle);
        end
		
        % Select bad trials and change with Nan
		[idx1,comp]=clean_data(comp,imuscle,data(1).name);
		
		for itrial =length(data):-1:1
			data(itrial).Normemg(:,imuscle)=comp(:,itrial);
            if max(data(itrial).Normemg(1,imuscle))<1
            data(itrial).Normemg(:,imuscle)=nan;
            end
        end
        % Record bad cycles
		data(imuscle).novalidemg=[idx1];%;idx2];
        
        %If max dynamic EMG > MVC, normalize to overall Max
        data(imuscle).DynMax = max(arrayfun(@(x)(max(x.Normemg(:,imuscle),[],'omitnan')),data));
        if data(imuscle).DynMax > 100
            
            for itrial = length(data):-1:1
                data(itrial).Normemg(:,imuscle) = data(itrial).Normemg(:,imuscle)/data(imuscle).DynMax*100;
            end
                
        end
		
		clear comp
		
	end
	
Path.rbiEMG=[Path.ServerAddressE '\Projet_IRSST_LeverCaisse\ElaboratedData\matrices\rbiEMG\' alias.matname(imat).name];
    save(Path.rbiEMG,'data')

 clearvars data freq MVC mvc
end
