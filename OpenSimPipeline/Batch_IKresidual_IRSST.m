clear; clc;

GenericPath

Alias.sujet = sujets_validesJB(Path.ServerAddressE);

for isujet=length(Alias.sujet):-1:1
    disp(['Processing subject #' num2str(length(Alias.sujet)- isujet) ' out of ' num2str(length(Alias.sujet)), '(' Alias.sujet{isujet} ')' ])
    
    SubjectPath;
    
    Logfiles=dir([Path.IKsetuppath '*.log']);

    
    for itrial = 1: length(Logfiles)
        %Import .klo file
        LogName=Logfiles(itrial).name;
                
        IKresidual=Scan_IKresidual([Path.IKsetuppath LogName]);
        
        save([Path.IKsetuppath LogName(1:end-4) '.err'],'IKresidual')
        
        if median(IKresidual.rmsvalue)>0.05 || median(IKresidual.maxvalue)>0.1
            
            fid=fopen([Path.IKresultpath, LogName 'BIGflagIK.txt'], 'w');
            fclose(fid)
            
        elseif median(IKresidual.rmsvalue)>0.03 || median(IKresidual.maxvalue)>0.05
            
            fid=fopen([Path.IKresultpath, LogName 'flagIK.txt'], 'w');
            fclose(fid)
            
        end
        
        clear IKresidual
        end
        
    end
    