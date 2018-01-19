% Script used to compute muscle focus based on OpenSim output for the
%BodyKinematic analysis function (Local coordinates, velocity, NOT degrees)
%and from the muscle force direction toolbox: Muscle Force direction
%vectors, local coordinates, NOT degrees
clear all; clc;


%% Define variables
% Body and muscles of interest. As in Blache 2015, I targeted the lines of
% action of muscles best matching the position of the electrodes
Body={'humerus'};
Muscle={'DELT3','DELT2','DELT1','INFSP','SUPSP', 'SUBSC',...
    'LAT1','PECM1' };
param.nbframe = 4000; % number frame needed (interpolation)
param.GHJntNameOSIM={'preshoulder1'};

%% Interupteurs
saveresult=1;


%% Chargement des Path génériques
GenericPath

%% Chargement des fonctions Opensim 
import org.opensim.modeling.*

%% Nom des sujets
Alias.sujet = sujets_validesJB(Path.ServerAddressE);

for isujet=length(Alias.sujet):-1:1
    SubjectPath
    name=Alias.sujet{isujet};
    name=name(end-3:end);
	
	Path.MDpath=[Path.exportPath,'MuscleDirection\StandfordVA2'];
    Path.MDresultpath=[Path.MDpath,'\result\'];
    Path.MDsetuppath=[Path.MDpath,'\setup\'];
    
    %% Get location of the GH Joint center
    MyModel=Model([Path.ServerAddressE 'Projet_IRSST_LeverCaisse\Jason\StandfordVACoRAnatoJB.osim']);
    MyJointSet=MyModel.getJointSet;
    MyGHJoint=MyJointSet.get(param.GHJntNameOSIM);
    GHJoint=MyGHJoint.get_location;    GHJoint=[GHJoint.get(0) GHJoint.get(1) GHJoint.get(2)];
    
    %% Load analyzed data by RM (to get trialname, condition, start and end time, Qs,
    %etc.
    load(Path.importPath);
    data=temp; clear temp
    
    %% For each trial...
    for itrial=1:length(data)
		disp(['Analysing subject #' num2str(isujet) ': ' name '/ trial #' num2str(itrial)])
        
        %% Load muscle path data
        if exist([Path.MDresultpath data(itrial).trialname '.mot_MuscleForceDirection_vectors.sto'],'file')==2
            
            LineOfAction = importdata([Path.MDresultpath data(itrial).trialname '.mot_MuscleForceDirection_vectors.sto']);
            MuscleAttachment = importdata([Path.MDresultpath data(itrial).trialname '.mot_MuscleForceDirection_attachments.sto']);
            MuscleAttachmentAnato = importdata([Path.MDpath 'Anato\result\' data(itrial).trialname '.mot_MuscleForceDirection_attachments.sto']);
            LineOfActionAnato = importdata([Path.MDpath 'Anato\result\' data(itrial).trialname '.mot_MuscleForceDirection_vectors.sto']);
            
            %% Compute leverArm
            for imuscle = 1:length(Muscle) % for each muscle
                
                               
                ischan=regexp(MuscleAttachment.colheaders,[Muscle{imuscle} '\w*' Body{1}]);
                ichan=1;
                while isempty(ischan{ichan})
                    ichan=ichan+1;
                end
                
                dataColumn(:,imuscle)=ichan+(0:2);
                
                % for DELT2 use anatomical Attachment as in Blache's code
                if strcmp(Muscle(imuscle),'DELT2')==1;
                    
                    MuscleAttachment.data(:,dataColumn(:,imuscle))=MuscleAttachmentAnato.data(:,dataColumn(:,imuscle));
                    LineOfAction.data(:,dataColumn(:,imuscle))=LineOfActionAnato.data(:,dataColumn(:,imuscle));
                    
                end
                
                           
                % Write Line of action, Muscle attachment and GH joint rotation center into the
                % struct
                data(itrial).vecDir(:,:,imuscle) = LineOfAction.data(:,dataColumn(:,imuscle));
                data(itrial).attach(:,:,imuscle) = MuscleAttachment.data(:,dataColumn(:,imuscle));
                data(itrial).GHjrc(:,:) = repmat(GHJoint,size(MuscleAttachment.data,1),1); 
                
                % Calculate the vector parallel to muscle attachment and
                % Joint rotation center (lever arm)              
                parallel = data(itrial).attach(:,:,imuscle)-data(itrial).GHjrc(:,:); 
                
                % Compute the effective force dir (Joint axis around which
                % muscle has an action)
                EffForceDir(:,:,imuscle) = cross(data(itrial).vecDir(:,:,imuscle),parallel);
                
                % Get the norm of the vector at each time point. More efficient then
                % using the norm function inside a FOR loop
                temp = sqrt(sum(EffForceDir(:,:,imuscle).^2,2));
                temp = repmat(temp,1,3);
                
                %Gives the unit vector indicating the direction of the moment arm of
                %the muscle. Used in the equation in Blache 2015 (dm in equation 1)
                
                data(itrial).d(:,:,imuscle) = EffForceDir(:,:,imuscle)./temp;
                
            end
            
            %% Interpolate the moment arms to param.nbframe from onset and offset of force on handle
            startKine = floor(data(itrial).start);
            stopKine = floor(data(itrial).end);
            MVTdurationKine = stopKine-startKine;
            x = 1:MVTdurationKine+1; y = data(itrial).d(startKine:stopKine,:,:);
            data(itrial).dInt(:,:,:) = interp1(x,y,1:(length(x)-1)/(param.nbframe-1):length(x));
            
            data(itrial).dIntMuscle = Muscle;
            
            clear LineOfAction MuscleAttachment EffForceDir verDir parallel temp dataColumn MVTdurationKine
        end
    end

    MyModel.disownAllComponents();
   
    if saveresult == 1
    save([Path.ServerAddressE '\Projet_IRSST_LeverCaisse\Elaborateddata\matrices\MuscleForceDir\' Alias.sujet{1,isujet} '.mat'],'data')
    end
    
    clear MyModel MyJointSet MyGHJoint GHJoint data 
end
%% EMG
%
% [filename, pathname]=uigetfile('*.mat','Go get you EMGdata file');
% EMGdata = load([pathname,filename]);
%
% [filename, pathname]=uigetfile('*.mat','Go get you EMGlabel file');
% EMGlabel = load([pathname,filename]);
%
% trial=4;
%
% for i=1:length(EMGlabel.Col_assign)
% emglabel(i)=EMGlabel.Col_assign{1,i}(1,1); %Je n'arrive pas à utiliser cette organisation des données de façon efficace...
% end
%
% EMGmuscle={'Delt_post','Delt_med','Delt_ant','Infra','Supra','Subscap','Gd_dors_IM','Pec_IM'};
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
% %% Animation
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
%
