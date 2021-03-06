%   Description:
%       contribution_hauteur_preparation is used to compute the contribution of each
%       articulation to the height
%   Output:
%       contribution_hauteur_preparation gives matrix for input in SPM1D and GRAMM
%   Functions:
%       contribution_hauteur_preparation uses functions present in \\10.89.24.15\e\Project_IRSST_LeverCaisse\Codes\Functions_Matlab
%
%   Author:  Romain Martinez
%   email:   martinez.staps@gmail.com
%   Website: https://github.com/romainmartinez
%___________________________
%__________________________________________________

clear ; close all; clc


GenericPath
%% Interrupteurs
saveresults = 1;
writeopensim = 1;

%% Nom des sujets
Alias.sujet = sujets_validesJB(Path.ServerAddressE);

for isujet = [6,10,11,12,13] %length(Alias.sujet):-1:1
     
    disp(['Traitement de ' cell2mat(Alias.sujet(isujet)) ' (' num2str(length(Alias.sujet) - isujet+1) ' sur ' num2str(length(Alias.sujet)) ')'])
% chemin des fichiers
        
SubjectPath

%Adapt the default IK path
% Path.IKpath=[Path.exportPath,'IKOSIM\StandFordVA2\'];
%     Path.IKresultpath=[Path.IKpath,'result\'];
%     Path.IKsetuppath=[Path.IKpath,'setup\'];
%     if isdir(Path.IKpath)==0
%         mkdir(Path.IKpath);
%         mkdir(Path.IKresultpath);
%         mkdir(Path.IKsetuppath);
% 	end
% 	
% %     % Import reconstruction
%     load(Path.importPath);
%     Data=temp;
% % %     
%     Path.importStaticPath = [Path.ServerAddressE '\Projet_Reconstructions\DATA\Romain\' Alias.sujet{isujet} 'd\MODEL2\' ...
%         Alias.sujet{isujet} 'd1_MOD2.1_rightHanded_Gender' Data(1).sexe '_' Alias.sujet{isujet} 'd_.Q2'];
% % %     
%    Alias.Qnames    = dir([Path.importPath '*.Q*']);
% % %     
% % %     %% Ouverture et information du mod�le
% % %     % Ouverture du mod�le
%     Alias.model    = S2M_rbdl('new',Path.pathModel);
% % %     % Noms et nombre de DoF
%     Alias.nameDof  = S2M_rbdl('nameDof', Alias.model);
%     %Alias.nDof     = S2M_rbdl('nDof', Alias.model);
% % %     % Noms et nombre de marqueurs
%     Alias.nameTags = S2M_rbdl('nameTags', Alias.model);
%     Alias.nTags    = S2M_rbdl('nTags', Alias.model);
% % %     % Nom des segments
%     Alias.nameBody = S2M_rbdl('nameBody', Alias.model);
% %     [Alias.segmentMarkers, Alias.segmentDoF] = segment_RBDL(2);
% % %     %Frequence d'�chantillonage
%     Alias.frequency=100.00;
% % %     
% % %     %% Obtenir les onset et offset de force
% % %     
%     for trial = length(Data) : -1 : 1
% %         %% Caract�ristique de l'essai
% %         % Sexe du sujet
%         if     length(Data) == 54
%             Data(trial).sexe = 'H';
%         elseif length(Data) == 36
%             Data(trial).sexe = 'F';
%         end
% % %         
% % % 
% % %               
% % %        % Initialisation des Q
%         q = Data(trial).Qdata.Q2;
% 		
% 		  for chan=1:size(q,1)
%         NanQ=find(isnan(q(chan,:)));
%         NoNanQ=find(isnan(q(chan,:))==0);
%         if ~isempty(NanQ) && ~isempty(NoNanQ)
%             for i=1:length(NanQ)
%                 nextvalid=find(NoNanQ>NanQ(i),1,'first');
%         q(chan,NanQ(i))=q(chan,NoNanQ(nextvalid));
%             end
%         end
%       end
% % %         
% % %         %% Filtre passe-bas 15Hz
%         q = transpose(lpfilter(q', 15, 100));
% % %         
% % %         
% % %         %% Get the global coodinates of the markers for input in OpenSim
%         Data(trial).T = S2M_rbdl('Tags', Alias.model, q);
% % %         
% % %         %% Rotate all T (minus pi/2 around X) so global reference fit with OpenSim (X: forward, Y: Up, Z: Right)
% % %         Rx=[1 0 0; 0 0 -1; 0 1 0];
% % %         rotT(1,:,:)=sum([Data(trial).T(1,:,:)*Rx(1,1); Data(trial).T(2,:,:)*Rx(1,2); Data(trial).T(3,:,:)*Rx(1,3)],1);
% % %         rotT(2,:,:)=sum([Data(trial).T(1,:,:)*Rx(2,1); Data(trial).T(2,:,:)*Rx(2,2); Data(trial).T(3,:,:)*Rx(2,3)],1);
% % %         rotT(3,:,:)=sum([Data(trial).T(1,:,:)*Rx(3,1); Data(trial).T(2,:,:)*Rx(3,2); Data(trial).T(3,:,:)*Rx(3,3)],1);
% % %         
% % %         Data(trial).rotT(1,:,:)=Data(trial).T(3,:,:);
% % %         Data(trial).rotT(2,:,:)=Data(trial).T(1,:,:);
% % %         Data(trial).rotT(3,:,:)=Data(trial).T(2,:,:);
%     end
% % %     
% % %     
% % %   %% Static trial
% % %    % Dossier static trial
%    staticidx=length(Data)+1;
%    Data(staticidx).sexe=Data(1).sexe;
%    Data(staticidx).trialname='static';
% % % %    
%     Path.importStaticPath = [Path.ServerAddressE '\Projet_Reconstructions\DATA\Romain\' Alias.sujet{isujet} 'd\MODEL2\' ...
%         Alias.sujet{isujet} 'd1_MOD2.1_rightHanded_Gender' Data(trial).sexe '_' Alias.sujet{isujet} 'd_.Q2'];
%       Data(staticidx).Qdata=load(Path.importStaticPath,'-mat');
%       q = Data(staticidx).Qdata.Q2;
%       q = transpose(lpfilter(q', 15, 100));
% % %       
%       Data(staticidx).T = S2M_rbdl('Tags', Alias.model, q);
% %       Data(staticidx).rotT(1,:,:)=Data(1).T(1,:,:);
% %       Data(staticidx).rotT(2,:,:)=Data(1).T(3,:,:)*-1;
% %       Data(staticidx).rotT(3,:,:)=Data(1).T(2,:,:);
% % %     %% Sauvegarde de la matrice
%     if saveresults == 1
%         save([Path.exportPath Alias.sujet{1,isujet} '.mat'],'Data','Alias')
%     end
%     %clearvars data Data forceindex logical_cells
%     
% %     S2M_rbdl_AnimateModel(Alias.model, Data(19).Qdata.Q2)
    
    %G�n�rer un fichier .trc pour Opensim
    if writeopensim == 1
%    OpenSimTRCgeneratorJB 
    %OpenSimMOTgeneratorJB
     setupAndRunScaleWu
    setupAndRunIK
    setupAndRunMuscleDirectionGenModel
    
    
    
    end
    % Fermeture du model
    % S2M_rbdl('delete', Alias.model);
end
