clear; close all; clc

%% Conditions tested for men and women and muscle names

CondH={'H6H1', 'H6H2', 'H6H3', 'H6H4', 'H6H5', 'H6H6',...
    'H12H1', 'H12H2', 'H12H3', 'H12H4', 'H12H5', 'H12H6',...
    'H18H1', 'H18H2', 'H18H3', 'H18H4', 'H18H5', 'H18H6'};

CondF={'F6H1', 'F6H2', 'F6H3', 'F6H4', 'F6H5', 'F6H6',...
    'F12H1', 'F12H2', 'F12H3', 'F12H4', 'F12H5', 'F12H6'};

Variables={'DENOMINATORallmuscles','DENOMINATORBlache','NUMERATORallmuscles','NUMERATORBlache', 'MFBlache', 'MFallmuscles'};
    
%% load functions

GenericPath
% if isempty(strfind(path, [Path.ServerAddressE '\Librairies\S2M_Lib\']))
% 	% S2M library
% 	loadS2MLib;
% end

%% Path

alias.matname = dir([Path.ServerAddressE '\Projet_IRSST_LeverCaisse\ElaboratedData\matrices\MuscleFocus\COR\']);
alias.matname=arrayfun(@(x)(x.name),alias.matname,'UniformOutput',false);
alias.matname=alias.matname(strncmp(alias.matname,'IRSST',5));

kh=1;
kf=1;
MuscleFocus.Hname=[];
MuscleFocus.Fname=[];

for isubject= 1: length(alias.matname)

load([Path.ServerAddressE '\Projet_IRSST_LeverCaisse\ElaboratedData\matrices\MuscleFocus\COR\' alias.matname{isubject}]);

if strcmp(Data(1).sexe,'H') %if man
    
    if kh==1 || strcmp(alias.matname{isubject}, MuscleFocus.Hname{kh-1})==0 %if it is first trial, update MuscleFocus.name
        MuscleFocus.Hname{kh}=alias.matname{isubject};
        kh=kh+1;
    end
    
elseif strcmp(Data(1).sexe,'F') % if woman
    
    if kf==1 || strcmp(alias.matname{isubject}, MuscleFocus.Fname{kf-1})==0 %if it is first trial, update MuscleFocus.name
        MuscleFocus.Fname{kf}=alias.matname{isubject};
        kf=kf+1;
    end
end
clear Data
end

kh=1;
kf=1;

for isubject= 1: length(alias.matname)
    disp(num2str(isubject))
load([Path.ServerAddressE '\Projet_IRSST_LeverCaisse\ElaboratedData\matrices\MuscleFocus\COR\' alias.matname{isubject}]);
    
    if strcmp(Data(1).sexe,'H') %if man
        
        for icond = 1 : length(CondH)
            
            trials=arrayfun(@(x)(strncmp(x.trialname, CondH{icond}, length(CondH{icond}))), Data);
            trials=find(trials);
            
            for itrial= 1: length(trials)
                
                for ivariable= 1:length(Variables)
                    MuscleFocus.(Variables{ivariable}).(CondH{icond})(:,itrial,kh)=Data(trials(itrial)).(Variables{ivariable});
                end
                
            end
            
        end
        kh=kh+1;
        
    elseif strcmp(Data(1).sexe,'F') %if woman
        
        for icond = 1 : length(CondF)
            
            trials=arrayfun(@(x)(strncmp(x.trialname, CondF{icond}, length(CondF{icond}))), Data);
            trials=find(trials);
            
            for itrial= 1: length(trials)
                
                for ivariable= 1:length(Variables)
                    MuscleFocus.(Variables{ivariable}).(CondF{icond})(:,itrial,kf)=Data(trials(itrial)).(Variables{ivariable});
                end
                
            end
            
        end
        kf=kf+1;
        
    end
    
    clear Data
end


