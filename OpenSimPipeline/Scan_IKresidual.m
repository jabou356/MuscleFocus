 function [ IKresidual ] = Scan_IKresidual( path )
%IKresidual Summary of this function goes here
%   Detailed explanation goes here
%% Extract RMS error and MAX error from logs
fid = fopen(path);
str_doc=fscanf(fid,'%c',inf);

trouverRMS=strfind(str_doc, 'RMS');
trouverMax=strfind(str_doc, 'max');

for isample=1:length(trouverRMS)
    rmsstop=strfind(str_doc(trouverRMS(isample)+4:trouverRMS(isample)+20), ','); 
    maxstop=strfind(str_doc(trouverMax(isample)+4:trouverMax(isample)+20), ' '); 

    IKresidual.rmsvalue(isample) = str2num(str_doc(trouverRMS(isample)+4:trouverRMS(isample)+rmsstop(1)+3));
    IKresidual.maxvalue(isample) = str2num(str_doc(trouverMax(isample)+4:trouverMax(isample)+maxstop(1)+3));
end

fclose(fid);

end

