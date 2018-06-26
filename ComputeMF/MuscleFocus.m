clear all; clc;


% Fonctions locales
%addpath('E:\Projet_IRSST_LeverCaisse\Codes\Jason');

GenericPath

%% Nom des sujets
Alias.sujet = sujets_validesJB(Path.ServerAddressE);

for isujet=length(Alias.sujet):-1:1
    SubjectPath
    
    Path.rbiEMG=[Path.ServerAddressE '/Projet_IRSST_LeverCaisse/ElaboratedData/matrices/rbiEMG/' Alias.sujet{isujet} '.mat'];
    load(Path.rbiEMG)
    emgdata=data;
	emgdata(1).mfEMGchan=([3,2,1,10,9,11,13,12]);
   
    clear data
        
    load([Path.ServerAddressE '/Projet_IRSST_LeverCaisse/ElaboratedData/matrices/MuscleForceDir/Wu/' Alias.sujet{isujet} '.mat'])
    kindata=data;
    clear data
    
    for itrial=1:length(emgdata)
    disp(['Analysing subject #' num2str(isujet) ': ' Alias.sujet{isujet} '/ trial #' num2str(itrial)])

   if length(kindata(itrial).dInt)>0 && length(emgdata(itrial).Normemg)>0
    
       for imuscle=1:length(emgdata(1).mfEMGchan)
       
        chan=emgdata(1).mfEMGchan(imuscle);
		
		if emgdata(itrial).Normemg(1,chan)==0
		emgdata(itrial).Normemg(:,chan)=nan;
		end
	
    Data(itrial).numerator(:,:,imuscle)=repmat(emgdata(itrial).Normemg(:,chan),1,3).*kindata(itrial).dInt(:,:,imuscle);
	
    Data(itrial).denominator(:,imuscle)=emgdata(itrial).Normemg(:,chan);
    end
    
    temp=sum(Data(itrial).numerator,3);
    Data(itrial).NUMERATORallmuscles=sqrt(sum(temp.^2,2));
    Data(itrial).DENOMINATORallmuscles=sum(Data(itrial).denominator,2);
    Data(itrial).MFallmuscles=Data(itrial).NUMERATORallmuscles./Data(itrial).DENOMINATORallmuscles;
	
	temp=sum(Data(itrial).numerator(:,:,[1,2,3,4,5,6]),3);
    Data(itrial).NUMERATORrotator=sqrt(sum(temp.^2,2));
    Data(itrial).DENOMINATORrotator=sum(Data(itrial).denominator(:,[1,2,3,4,5,6]),2);
    Data(itrial).MFrotator=Data(itrial).NUMERATORrotator./Data(itrial).DENOMINATORrotator;
    
    temp=sum(Data(itrial).numerator(:,:,[1,2,3,7,8]),3);
    Data(itrial).NUMERATORBlache=sqrt(sum(temp.^2,2));
    Data(itrial).DENOMINATORBlache=sum(Data(itrial).denominator(:,[1,2,3,7,8]),2);
    Data(itrial).MFBlache=Data(itrial).NUMERATORBlache./Data(itrial).DENOMINATORBlache;
    
    temp=sum(Data(itrial).numerator(:,:,[1,2,3]),3);
    Data(itrial).NUMERATORdelt=sqrt(sum(temp.^2,2));
    Data(itrial).DENOMINATORdelt=sum(Data(itrial).denominator(:,[1,2,3]),2);
    Data(itrial).MFdelt=Data(itrial).NUMERATORdelt./Data(itrial).DENOMINATORdelt;
    
    Data(itrial).sex=emgdata(itrial).sex;
    Data(itrial).poids=emgdata(itrial).poids;
    Data(itrial).hauteur=emgdata(itrial).hauteur;
    Data(itrial).name = emgdata(itrial).name;

    Data(itrial).trialname=kindata(itrial).trialname;
    
   end
   end
    
   
    save([Path.MF, Alias.sujet{isujet}, '.mat'], 'Data', 'Alias');
end

    
    
