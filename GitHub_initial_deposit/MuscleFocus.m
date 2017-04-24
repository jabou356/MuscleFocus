clear all; clc;

%% Chargement des fonctions
if isempty(strfind(path, 'E:\Librairies\S2M_Lib\'))
    % Librairie S2M
    cd('E:\Librairies\S2M_Lib\');
    S2MLibPicker;
end

% Fonctions locales
addpath('E:\Projet_IRSST_LeverCaisse\Codes\Jason');

GenericPath

%% Nom des sujets
Alias.sujet = sujets_validesJB(Path.ServerAddressE);

for isujet=length(Alias.sujet):-1:1
    SubjectPath
    
    Path.rbiEMG=[Path.ServerAddressE '\Projet_IRSST_LeverCaisse\ElaboratedData\matrices\rbiEMG\' Alias.sujet{isujet} '.mat'];
    load(Path.rbiEMG)
    emgdata=data;
   
    clear data
        
    load([Path.ServerAddressE '\Projet_IRSST_LeverCaisse\ElaboratedData\matrices\MuscleForceDir\' Alias.sujet{isujet} '.mat'])
    kindata=Data;
    clear Data
    
    for itrial=1:length(emgdata)
    
    j=0;
    for imuscle=1:length(emgdata(1).mfEMGchan)
        j=j+1;
        chan=emgdata(1).mfEMGchan(imuscle);
    Data(itrial).numerator(:,:,j)=repmat(emgdata(itrial).normRBIemgInt(:,chan),1,3).*kindata(itrial).dInt(:,:,j);
    Data(itrial).denominator(:,j)=emgdata(itrial).normRBIemgInt(:,chan);
    end
    
    temp=sum(Data(itrial).numerator,3);
    NUMERATOR=sqrt(sum(temp.^2,2));
    DENOMINATOR=sum(Data(itrial).denominator,2);
    Data(itrial).MFallmuscles=NUMERATOR./DENOMINATOR;
    
    temp=sum(Data(itrial).numerator(:,[1,2,3,7,8]),3);
    NUMERATOR=sqrt(sum(temp.^2,2));
    DENOMINATOR=sum(Data(itrial).denominator,2);
    Data(itrial).MFBlache=NUMERATOR./DENOMINATOR;
    Data(itrial).sexe=kindata(itrial).sexe;
    Data(itrial).trialname=kindata(itrial).trialname;
    end
    
   
     Path.MuscleFocus=[Path.ServerAddressE '\Projet_IRSST_LeverCaisse\ElaboratedData\matrices\MuscleFocus\' Alias.sujet{isujet} '.mat'];
     save(Path.MuscleFocus, 'Data', 'Alias');
end

    
    
