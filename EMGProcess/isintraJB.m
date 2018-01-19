function [spm] = isintra(spm)
blacklist = [];
blacklist.name = {'aimq' 'alef' 'ameg' 'daml' 'danf' 'emmb' 'fabg' 'naus' 'nicl' 'noel' 'marm' 'adrc' 'amia' 'anns' 'arst' 'carb' 'chac' 'damg' 'doca' 'emyc' 'fabd' 'geoa' 'jawr' 'laug' 'matr' 'nemk' 'phil' 'romr' 'roxd' 'steb' 'vivs' 'yoab'};

blacklist.column=[];
for i = length(blacklist.name):-1:1
	blacklist.column=[blacklist.column, find(strcmpi(spm.name,blacklist.name{i}) & (spm.imuscle==9 | spm.imuscle==10 | spm.imuscle==11))];
end



spm.emg(:,blacklist.column)=NaN;
   
end

% 1. trouve les index des sujets blacklister
% 2. remplacer spm.emg des intras par NaN ici pour les sujets blacklister