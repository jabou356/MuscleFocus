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
%_____________________________________________________________________________

clear ; close all; clc

%% Chargement des fonctions

GenericPath

Path.OpensimGenericModel=[Path.OpensimSetupJB,'StandfordVACoRAnatoJB.osim'];

%% Nom des sujets
Alias.sujet = sujets_validesJB(Path.ServerAddressE);

for isujet = length(Alias.sujet)   : -1 : 1
    
    disp(['Traitement de ' cell2mat(Alias.sujet(isujet)) ' (' num2str(length(Alias.sujet) - isujet+1) ' sur ' num2str(length(Alias.sujet)) ')'])
%     %% Chemin des fichiers
SubjectPath
    % Import reconstruction

    setupAndRunScaleStandfordVA
 
end