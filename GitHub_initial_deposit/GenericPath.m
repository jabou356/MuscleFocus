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
Path.machinetype=menu('Are you working on a MAC or a PC?', 'PC','MAC');

if Path.machinetype == 1 %If PC Backslashes
    
    if isempty(strfind(path, [Path.ServerAddressE, '\Librairies\S2M_Lib\']))
        % Librairie S2M
        cd([Path.ServerAddressE '\Librairies\S2M_Lib\']);
        S2MLibPicker;
    end
    
    
    %% Setup common paths
    Path.OpensimSetupJB=[Path.ServerAddressE '\Projet_IRSST_LeverCaisse\Jason\OpenSimSetUpFiles\'];
    Path.OpensimGenericModel=[Path.OpensimSetupJB,'GenericShoulderCoRAnatoJB.osim'];
    Path.OpensimGenericScale=[Path.OpensimSetupJB,'Conf_scaling.xml'];
    Path.OpensimGenericIK=[Path.OpensimSetupJB,'Conf_IK.xml'];
    Path.OpensimGenericMD=[Path.OpensimSetupJB,'Conf_MD.xml'];
    
    %% Path Elaborated data
    Path.RBIEMG = [Path.ServerAddressE '\Projet_IRSST_LeverCaisse\ElaboratedData\matrices\rbiEMG\'];
    Path.GroupEMG = [Path.ServerAddressE '\Projet_IRSST_LeverCaisse\ElaboratedData\MuscleFocus\GroupData\EMG\'];
    
elseif Path.machinetype == 2 %If MAC Forward slashes
    
    if isempty(strfind(path, [Path.ServerAddressE, '/Librairies/S2M_Lib/']))
        % Librairie S2M
        cd([Path.ServerAddressE '/Librairies/S2M_Lib/']);
        S2MLibPicker;
    end
    
    
    %% Setup common paths
    Path.OpensimSetupJB=[Path.ServerAddressE '/Projet_IRSST_LeverCaisse/Jason/OpenSimSetUpFiles/'];
    Path.OpensimGenericModel=[Path.OpensimSetupJB,'GenericShoulderCoRAnatoJB.osim'];
    Path.OpensimGenericScale=[Path.OpensimSetupJB,'Conf_scaling.xml'];
    Path.OpensimGenericIK=[Path.OpensimSetupJB,'Conf_IK.xml'];
    Path.OpensimGenericMD=[Path.OpensimSetupJB,'Conf_MD.xml'];
    
    %% Path Elaborated data
    Path.RBIEMG = [Path.ServerAddressE '/Projet_IRSST_LeverCaisse/ElaboratedData/matrices/rbiEMG/'];
    Path.GroupEMG = [Path.ServerAddressE '/Projet_IRSST_LeverCaisse/ElaboratedData/MuscleFocus/GroupData/EMG/'];
    
end