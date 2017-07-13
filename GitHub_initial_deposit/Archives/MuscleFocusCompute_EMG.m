% EMG

clear all; clc;

%% Chargement des fonctions
if isempty(strfind(path, 'E:\Librairies\S2M_Lib\'))
    % Librairie S2M
    cd('E:\Librairies\S2M_Lib\');
    S2MLibPicker;
end

% Fonctions locales
addpath('E:\Projet_IRSST_LeverCaisse\Codes\Jason');
import org.opensim.modeling.*

GenericPath

%% Nom des sujets
Alias.sujet = sujets_validesJB(Path.ServerAddressE);


% load([Path.ServerAddressE '\Projet_IRSST_LeverCaisse\Jason\data\GroupData\dataEMG.mat']);
for isujet=length(Alias.sujet):-1:1
    SubjectPath
    
    Path.EMG=[Path.ServerAddressE '\Projet_IRSST_LeverCaisse\ElaboratedData\matrices\EMG\' Alias.sujet{isujet} '.mat'];
    load(Path.EMG)
    
     data(1).mfEMGmuscle={'Delt_post','Delt_med','Delt_ant','Infra','Supra','Subscap','Gd_dors_IM','Pec_IM'};
data(1).mfEMGchan=[3 2 1 10 9 11 13 12];
    
    binlength=250*freq.emg/1000;
    
    if mod(binlength,2)==0 %if bin length is an even number
        binlength=binlength+1;
    end
    for itrial=1:length(data)
        
        startEMG=floor(data(itrial).start)*freq.emg/freq.camera;
        stopEMG=floor(data(itrial).end)*freq.emg/freq.camera;
        MVTdurationEMG=stopEMG-startEMG;
        
        %EMG preprocessing 1: remove DC 
        data(itrial).emg=data(itrial).emg-repmat(mean(data(itrial).emg,1),size(data(itrial).emg,1),1);
 
        
        %EMG preprocessing 2: Bandpass filter
        [b, a]=butter(2, [10/(freq.emg/2) 425/(freq.emg/2)]);
        for imuscle=1:size(data(itrial).emg,2)
        data(itrial).emg(:,imuscle)=filtfilt(b,a,data(itrial).emg(:,imuscle));
        end
        
        %EMG preprocessing 3: Rectify and smooth with a zero lag 250 ms rectify bin
        %averaging
        data(itrial).normemg=abs(data(itrial).emg)./repmat(MVC,size(data(itrial).emg,1),1);
        temp=mean(data(itrial).normemg(1:binlength,:),1);
        data(itrial).normRBIemg(1:floor(binlength/2),:)=repmat(temp,floor(binlength/2),1);
        temp=mean(data(itrial).normemg(end-binlength+1:end,:),1);
        data(itrial).normRBIemg(ceil(length(data(itrial).normemg)-binlength/2)+1:length(data(itrial).normemg),:)=repmat(temp,floor(binlength/2),1);
              
        for i=ceil(binlength/2):ceil(length(data(itrial).normemg)-binlength/2)
            data(itrial).normRBIemg(i,:)=mean(data(itrial).normemg(ceil(i-binlength/2):floor(i+binlength/2),:),1);
        end
        
        %Interpolate so the lifting phase is 1000 data point as kinematics
        data(itrial).normRBIemgInt(:,:)=interp1(1:MVTdurationEMG+1,data(itrial).normRBIemg(startEMG:stopEMG,:),1:(MVTdurationEMG)/999:MVTdurationEMG+1);
        
        
    end
    
     Path.rbiEMG=[Path.ServerAddressE '\Projet_IRSST_LeverCaisse\ElaboratedData\matrices\rbiEMG\' Alias.sujet{isujet} '.mat'];
    save(Path.rbiEMG,'data')
    clear data
end


%
%
%
% for i=1:length(EMGmuscle)
%     EMGchan(i)=find(contains(emglabel,EMGmuscle(i)));
%     EMGofInterest(:,i)=EMGdata.data(trial).EMGinterp(:,EMGchan(i));
%     numerator(:,:,i)=repmat(EMGofInterest(:,i),1,3).*EffForceDirinterp(:,:,i);
%     denominator(:,i)=EMGofInterest(:,i);
% end
%
% temp=sum(numerator,3);
% NUMERATOR=sqrt(sum(temp.^2,2));
% DENOMINATOR=sum(denominator,2);
% MuscleFocus=NUMERATOR./DENOMINATOR;
%
%% Animation
%
%
% %
% for i=1:583
% clf
% plot3([0 0],[0 5], [0 0],'k','linewidth',3)
% hold on
% plot3([0 data(itrial).d(i,1,1)],[0 data(itrial).d(i,2,1)], [0 data(itrial).d(i,3,1)],'r')
% plot3([0 vecDir(i,1,1)],[0 vecDir(i,2,1)], [0 vecDir(i,3,1)],'k:','linewidth',2)
% plot3([0 data(itrial).d(i,1,2)],[0 data(itrial).d(i,2,2)], [0 data(itrial).d(i,3,2)],'b')
% plot3([0 vecDir(i,1,2)],[0 vecDir(i,2,2)], [0 vecDir(i,3,2)],'k:','linewidth',2)
% plot3([0 data(itrial).d(i,1,3)],[0 data(itrial).d(i,2,3)], [0 data(itrial).d(i,3,3)],'g')
% plot3([0 vecDir(i,1,3)],[0 vecDir(i,2,3)], [0 vecDir(i,3,3)],'k:','linewidth',2)
% plot3([0 data(itrial).d(i,1,4)],[0 data(itrial).d(i,2,4)], [0 data(itrial).d(i,3,4)],'m')
% plot3([0 vecDir(i,1,4)],[0 vecDir(i,2,4)], [0 vecDir(i,3,4)],'k:','linewidth',2)
% plot3([0 data(itrial).d(i,1,5)],[0 data(itrial).d(i,2,5)], [0 data(itrial).d(i,3,5)],'c')
% plot3([0 vecDir(i,1,5)],[0 vecDir(i,2,5)], [0 vecDir(i,3,5)],'k:','linewidth',2)
%
% view([0,5,0])
% drawnow
% end
% %