function [ sujets_export ] = sujets_validesJB(ServerAddressE)
%% Importer la feuille exce
[~, ~, sujets] = xlsread([ServerAddressE '\Projet_IRSST_LeverCaisse\ElaboratedData\contribution_articulation\IRSST_infos_sujets.xlsx'],...
    'Global','A2:K61');%J au lieu de K

for iline = length(sujets) : -1 : 1
    if sujets{iline,11} == 'x' % 10 au lieu de 11
        sujets_export{iline} = sujets{iline, 1};
        sujets_export{iline} = ['IRSST_' upper(sujets_export{iline}(2)) sujets_export{iline}(3:end-2) upper(sujets_export{iline}(end-1))];
    end
end

sujets_export = sujets_export(~cellfun('isempty',sujets_export));
end

