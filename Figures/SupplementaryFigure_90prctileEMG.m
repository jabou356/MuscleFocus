%Script to generate Supplementary Figures for paper Sex differences on
%Muscle focus during Box lifting.
%
%Figure content: EMG percentile 12 kg. SumEMG, and each muscles
clear g
close all

% Muscles in ascending order of activity 
muscles = {'DeltA', 'DeltM', 'Infra', 'BB', 'Pect', 'Supra', 'TB', 'SubScap', 'DeltP', 'Lat'};


%% Histogram
% flag = GroupData.poids ==12 & ~isnan(GroupData.emg(:,1))' & strcmp(GroupData.muscle,'DeltA');
% g=gramm('x',prctile(GroupData.emg,90,2),'subset',flag,'color',GroupData.sex);
% g.stat_bin('nbins',10,'geom','overlaid_bar','normalization','probability');
% g.set_color_options('map',[0 0 1; 1 0 0]);
% % Sort in ascending order
% 
% g.set_names('x','% of MVC', 'y', 'Probability');
% g.set_text_options('font','Arial');
% 
% g.draw
% g.export('file_name','DeltA12_histogram','file_type','pdf');
% clear g
% close all
% keep only 12kg, valid and selected muscles
flag =  ~isnan(GroupData.emg(:,1))' & ismember(GroupData.muscle,muscles);

% X: muscles, Y: 90th percentile, flag: only selected trials, color: sex
g=gramm('x',GroupData.muscle,'y',prctile(GroupData.emg,90,2),'subset',flag,'color',GroupData.sex);%, 'label', round(data.proportion))
g.facet_grid(GroupData.poids,[]);
% red: women, blue: women
g.set_color_options('map',[0 0 1; 1 0 0]);
% Sort in ascending order
g.set_order_options('x',muscles)

% Plot error bars
g.stat_summary('type','sem','geom','errorbar','setylim','true');
g.set_names('y','% of MVC', 'x', 'Muscle');
g.set_text_options('font','Arial');
g.axe_property('YLim',[0 100]); 
g.draw



%% plot points (mean)
g.update('x',GroupData.muscle,'y',prctile(GroupData.emg,90,2),'subset',flag,'color',GroupData.sex);

g.facet_grid(GroupData.poids,[],'row_labels',false);

g.stat_summary('type','sem','geom','point','setylim','true');
g.set_color_options('map',[0 0 1; 1 0 0]);
g.set_order_options('x',muscles);

g.draw
% Export to cd
g.export('file_name','SupFigure_90prcileEMG','file_type','pdf');

clear g
close all
%% geom_point
figure('Units','inches','Position',[0 0 6.5 6])
flag =  (GroupData.poids == 6  | GroupData.poids ==12) & ~isnan(GroupData.emg(:,1))' & ismember(GroupData.muscle,muscles);


g=gramm('x',GroupData.muscle,'y',prctile(GroupData.emg,90,2),'subset',flag,'color',GroupData.sex);
g.facet_grid(GroupData.poids,[], 'row_labels', false);

g.stat_summary('geom','point','setylim','true');
g.set_color_options('map',[0 0 1; 1 0 0]);
g.set_order_options('x',muscles);
g.set_point_options('base_size',10)
g.no_legend();

g.draw;
% X: muscles, Y: 90th percentile, flag: only selected trials, color: sex
g.update('x',GroupData.muscle,'y',prctile(GroupData.emg,90,2),'subset',flag,'color',GroupData.sex);%, 'label', round(data.proportion))

% red: women, blue: women
g.set_color_options('map',[0 0 1; 1 0 0]);
% Sort in ascending order
g.set_order_options('x',muscles);
g.no_legend();



% Plot error bars
g.geom_point();
g.set_names('y','% of MVC', 'x', 'Muscle');
g.set_text_options('font','Arial');
g.axe_property('YLim',[0 100]); 
g.set_point_options('base_size',2)

g.draw;

%%

% Export to cd
%g.export('file_name','SupFigure_90prcileEMG','file_type','pdf');

g.export('file_name','SupFigure_90prcileEMG_point612','file_type','pdf');



