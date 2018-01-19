clear all; clc;


% Fonctions locales
%addpath('E:\Projet_IRSST_LeverCaisse\Codes\Jason');

GenericPath

%% Nom des sujets
Alias.sujet = sujets_validesJB(Path.ServerAddressE);

for isujet=18%length(Alias.sujet):-1:1
    SubjectPath
    
    Path.rbiEMG=[Path.ServerAddressE '/Projet_IRSST_LeverCaisse/ElaboratedData/matrices/rbiEMG/' Alias.sujet{isujet} '.mat'];
    load(Path.rbiEMG)
    emgdata=data;
	emgdata(1).mfEMGchan=([3,2,1,10,9,11,13,12]);
   
    clear data
        
    load([Path.ServerAddressE '/Projet_IRSST_LeverCaisse/ElaboratedData/matrices/MuscleForceDir/StandfordVA2/COR/' Alias.sujet{isujet} '.mat'])
    kindata=data;
    clear data
    
    for itrial=1:length(emgdata)
    disp(['Analysing subject #' num2str(isujet) ': ' Alias.sujet{isujet} '/ trial #' num2str(itrial)])

   if length(kindata(itrial).dInt)>0 && length(emgdata(itrial).emg)>0
    
       for imuscle=1:length(emgdata(1).mfEMGchan)
       
        chan=emgdata(1).mfEMGchan(imuscle);
		
		if emgdata(itrial).emg(1,chan)==0
		emgdata(itrial).emg(:,chan)=nan;
		end
	
    Data(itrial).numerator(:,:,imuscle)=repmat(emgdata(itrial).emg(:,chan),1,3).*kindata(itrial).dInt(:,:,imuscle);
	
    Data(itrial).denominator(:,imuscle)=emgdata(itrial).emg(:,chan);
    end
    
    temp=sum(Data(itrial).numerator,3);
    Data(itrial).NUMERATORallmuscles=sqrt(sum(temp.^2,2));
    Data(itrial).DENOMINATORallmuscles=sum(Data(itrial).denominator,2);
    Data(itrial).MFallmuscles=Data(itrial).NUMERATORallmuscles./Data(itrial).DENOMINATORallmuscles;
    
    temp=sum(Data(itrial).numerator(:,:,[1,2,3,7,8]),3);
    Data(itrial).NUMERATORBlache=sqrt(sum(temp.^2,2));
    Data(itrial).DENOMINATORBlache=sum(Data(itrial).denominator(:,[1,2,3,7,8]),2);
    Data(itrial).MFBlache=Data(itrial).NUMERATORBlache./Data(itrial).DENOMINATORBlache;
    Data(itrial).sexe=kindata(itrial).sexe;
    Data(itrial).trialname=kindata(itrial).trialname;
    
   end
   end
    
   
     Path.MuscleFocus=[Path.ServerAddressE '/Projet_IRSST_LeverCaisse/ElaboratedData/matrices/MuscleFocus/COR/' Alias.sujet{isujet} '.mat'];
     save(Path.MuscleFocus, 'Data', 'Alias');
end

    
    
