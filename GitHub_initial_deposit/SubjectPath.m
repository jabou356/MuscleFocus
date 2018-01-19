%% Chemin des fichiers

    
    % Dossier du sujet
    Path.DirModels  = [Path.ServerAddressF '/Data/Shoulder/Lib/' Alias.sujet{isujet} 'd/Model_2/'];
    % Dossier du mod�le pour le sujet
    Path.pathModel  = [Path.DirModels 'Model.s2mMod'];
    % Dossier des data
    Path.importPath = [Path.ServerAddressE '/Projet_IRSST_LeverCaisse/ElaboratedData/matrices/cinematique/' Alias.sujet{isujet} '.mat'];
    % Dossier static trial
    Path.importStaticPath = [Path.ServerAddressE '/Projet_Reconstructions/DATA/Romain/' Alias.sujet{isujet} 'd/MODEL2/' Alias.sujet{isujet} 'd1_MOD2.1_rightHanded_GenderH_IRSST_RomMd_.Q2'];
    % Dossiers d'exportation
    Path.exportPath = [Path.ServerAddressE '/Projet_IRSST_LeverCaisse/Jason/data/' Alias.sujet{isujet} '/'];
    
    if isdir(Path.exportPath)==0
        mkdir(Path.exportPath);
    end
    
    Path.TRCpath=[Path.exportPath,'TRC/'];
    if isdir(Path.TRCpath)==0
        mkdir(Path.TRCpath);
    end
    
    Path.IKpath=[Path.exportPath,'IKOSIM/'];
    Path.IKresultpath=[Path.IKpath,'result/'];
    Path.IKsetuppath=[Path.IKpath,'setup/'];
    if isdir(Path.IKpath)==0
        mkdir(Path.IKpath);
        mkdir(Path.IKresultpath);
        mkdir(Path.IKsetuppath);
    end
    
    Path.MDpath=[Path.exportPath,'MuscleDirection/'];
    Path.MDresultpath=[Path.MDpath,'result/'];
    Path.MDsetuppath=[Path.MDpath,'setup/'];
    if isdir(Path.MDpath)==0
        mkdir(Path.MDpath);
        mkdir(Path.MDresultpath);
        mkdir(Path.MDsetuppath);
    end
    


