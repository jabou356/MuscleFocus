%% Chargement des fonctions
% WhereRU=menu('Where are you','At Home', 'At the Office');
% if WhereRU ==1
%     Path.ServerAddressE='\\bimec7-kinesio.kinesio.umontreal.ca\e';
%     Path.ServerAddressF='\\bimec7-kinesio.kinesio.umontreal.ca\f';
% elseif WhereRU == 2
%     Path.ServerAddressE='E:';
%     Path.ServerAddressF='F:';
% end

Path.ServerAddressE=uigetdir('C:','Go get the E: path');
Path.ServerAddressF=uigetdir('C:','Go get the F: path');

Path.ServerAddressE(regexp(Path.ServerAddressE,'\'))='/';
Path.ServerAddressF(regexp(Path.ServerAddressF,'\'))='/';


    
    if isempty(strfind(path, [Path.ServerAddressE, '/Librairies/S2M_Lib/']))
        % Librairie S2M
        cd([Path.ServerAddressE '/Librairies/S2M_Lib/']);
        S2MLibPicker;
    end
    
    
    %% Setup common paths
    Path.OpensimSetupJB=[Path.ServerAddressE '/Projet_IRSST_LeverCaisse/Jason/OpenSimSetUpFiles/'];
    Path.OpensimGenericModel=[Path.OpensimSetupJB,'Wu_Shoulder_Model.osim'];
    Path.OpensimGenericScale=[Path.OpensimSetupJB,'Conf_scaling.xml'];
    Path.OpensimGenericIK=[Path.OpensimSetupJB,'Conf_IK.xml'];
    Path.OpensimGenericMD=[Path.OpensimSetupJB,'Conf_MD.xml'];
    
    %% Path Elaborated data
    Path.RBIEMG = [Path.ServerAddressE '/Projet_IRSST_LeverCaisse/ElaboratedData/matrices/rbiEMG/'];
    Path.MF = [Path.ServerAddressE '/Projet_IRSST_LeverCaisse/ElaboratedData/matrices/MuscleFocus/COR/'];
    Path.GroupEMG = [Path.ServerAddressE '/Projet_IRSST_LeverCaisse/ElaboratedData/MuscleFocus/GroupData/EMG/'];
    
