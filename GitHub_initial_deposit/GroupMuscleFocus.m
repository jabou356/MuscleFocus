clear ; close all; clc

%% Chargement des fonctions

GenericPath
%% Interrupteurs
saveresults = 1;
writeopensim = 1;

%% Nom des sujets
Alias.sujet = sujets_validesJB(Path.ServerAddressE);
nbF=1;
nbH=1;

for isujet = length(Alias.sujet)   : -1 : 1
    disp(isujet)
load(['E:\Projet_IRSST_LeverCaisse\ElaboratedData\matrices\MuscleFocus\' Alias.sujet{isujet} '.mat']);

    for itrial=1:length(Data);
    condname{:,itrial}=Data(itrial).trialname(1:end-2);
    ncond=sum(strcmp(condname,condname{:,itrial}));
    if strcmp(Data(1).sexe,'F')==1
     s=['GroupData.' condname{:,itrial}, '.MFallmuscle(:,ncond,nbF)=Data(itrial).MFallmuscles'];eval(s);
     s=['GroupData.' condname{:,itrial}, '.MFBlache(:,ncond,nbF)=Data(itrial).MFBlache'];eval(s);
     s=['GroupData.' condname{:,itrial}, '.numerator(:,:,:,ncond,nbF)=Data(itrial).numerator'];eval(s);
     s=['GroupData.' condname{:,itrial}, '.denominator(:,:,ncond,nbF)=Data(itrial).denominator'];eval(s);
     
    elseif strcmp(Data(1).sexe,'H')==1
    s=['GroupData.' condname{:,itrial}, '.MFallmuscle(:,ncond,nbH)=Data(itrial).MFallmuscles'];eval(s);
    s=['GroupData.' condname{:,itrial}, '.MFBlache(:,ncond,nbH)=Data(itrial).MFBlache'];eval(s);
    s=['GroupData.' condname{:,itrial}, '.numerator(:,:,:,ncond,nbH)=Data(itrial).numerator'];eval(s);
    s=['GroupData.' condname{:,itrial}, '.denominator(:,:,ncond,nbH)=Data(itrial).denominator'];eval(s);

    end
    
    end
    
    if strcmp(Data(1).sexe,'F')==1
        nbF=nbF+1;
    elseif strcmp(Data(1).sexe,'H')==1
         nbH=nbH+1;
    end
    clear Data condname
end
    
