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
load(['E:\Projet_IRSST_LeverCaisse\ElaboratedData\matrices\rbiEMG\' Alias.sujet{isujet} '.mat']);
if isujet==1
    GroupData.mfEMGmuscle=data.mfEMGmuscle;
    GroupData.mfEMGchan=data.mfEMGchan;
end

    for itrial=1:length(data);
    condname{:,itrial}=data(itrial).trialname(1:end-2);
    temp=condname{1,itrial};
    if strcmp(temp(1),'M')==1
        temp(1)='H';
        condname{1,itrial}=temp;
    end
    ncond=sum(strcmp(condname,condname{:,itrial}));
    if data(1).sex==2
     s=['GroupData.' condname{:,itrial}, '.normRBIemgInt(:,:,ncond,nbF)=data(itrial).normRBIemgInt'];eval(s);
     
    elseif data(1).sex==1
         s=['GroupData.' condname{:,itrial}, '.normRBIemgInt(:,:,ncond,nbH)=data(itrial).normRBIemgInt'];eval(s);

    end
    
    end
    
    if data(1).sex==2
        nbF=nbF+1;
    elseif data(1).sex==1
         nbH=nbH+1;
    end
    clear Data condname
end
    
