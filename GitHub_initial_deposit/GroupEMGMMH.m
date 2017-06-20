clear variables; close all; clc

%% Conditions tested for men and women and muscle names

CondH={'H6H1', 'H6H2', 'H6H3', 'H6H4', 'H6H5', 'H6H6',...
    'H12H1', 'H12H2', 'H12H3', 'H12H4', 'H12H5', 'H12H6',...
    'H18H1', 'H18H2', 'H18H3', 'H18H4', 'H18H5', 'H18H6'};

CondF={'F6H1', 'F6H2', 'F6H3', 'F6H4', 'F6H5', 'F6H6',...
    'F12H1', 'F12H2', 'F12H3', 'F12H4', 'F12H5', 'F12H6'};

Muscles={'DeltA', 'DeltM', 'DeltP', 'BB', 'TB', 'UpTrap', 

%% load functions

GenericPath
% if isempty(strfind(path, [Path.ServerAddressE '\Librairies\S2M_Lib\']))
% 	% S2M library
% 	loadS2MLib;
% end

%% Path

alias.matname = dir([path.Datapath '*mat']);

kh=1;
kf=1;
EMG.Hname=[];
EMG.Fname=[];

for isubject= 1: length(alias.matname)
    
    load([Path.RBIEMG, alias.matname(isubject)]);
      
    if data(1).sex == 1 %if man
        
        if kh==1 || strcmp(data(1).name, EMG.Hname{kh-1})==0 %if it is first trial, update EMG.name
            EMG.Hname{kh}=data(1).name;
            kh=kh+1;
        end      
        
    elseif data(1).sex == 2 % if woman
        
        if kf==1 || strcmp(data(1).name, EMG.Fname{kf-1})==0 %if it is first trial, update EMG.name
            EMG.Fname{kf}=data(1).name;
            kf=kf+1;
        end        
    end             
end

kh=1;
kf=1;

for isubject= 1: length(alias.matname)
   
    if data(1).sex == 1 %if man
        
        for icond = 1 : length(CondH)
            
trials=arrayfun((x)(strncmp(x.name, CondH{icond}, length({icond}))), data);
trials=find(trials);
     
for itrial= 1: length(trials)
    
    for imuscles= 1:length(muscles)
    
    
end


    