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
%% Interrupteurs
saveresults = 1;
writeopensim = 1;

%% Nom des sujets
Alias.sujet = sujets_validesJB(Path.ServerAddressE);

for isujet = 18
    
    disp(['Traitement de ' cell2mat(Alias.sujet(isujet)) ' (' num2str(length(Alias.sujet) - isujet+1) ' sur ' num2str(length(Alias.sujet)) ')'])
%     %% Chemin des fichiers
SubjectPath
 
Path.IKpath=[Path.exportPath,'IKOSIM\StandfordVA2\'];
    Path.IKresultpath=[Path.IKpath,'result\'];
    Path.IKsetuppath=[Path.IKpath,'setup\'];
    if isdir(Path.IKpath)==0
        mkdir(Ptah.IKpath);
        mkdir(Path.IKresultpath);
        mkdir(Path.IKsetuppath);
    end


 Path.OpensimGenericMD=[Path.OpensimSetupJB,'Conf_MDAnato.xml'];

Path.MDpath=[Path.exportPath,'MuscleDirection\StandfordVA2\Anato'];
    Path.MDresultpath=[Path.MDpath,'\result\'];
    Path.MDsetuppath=[Path.MDpath,'\setup\'];
    if isdir(Path.MDpath)==0
        mkdir(Path.MDpath);
        mkdir(Path.MDresultpath);
        mkdir(Path.MDsetuppath);
    end
   
    setupAndRunMuscleDirectionGenModel
   
end