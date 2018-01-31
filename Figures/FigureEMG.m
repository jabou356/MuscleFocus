close all
%clear 
figure('Units', 'centimeters','Position', [1.5, 1, 16.5, 17.6]);

Muscles1={'DeltA', 'DeltM', 'DeltP', 'Pect', 'Lat'};
Muscles2={'Supra', 'Infra', 'SubScap', 'BB', 'TB'};

flag1 = (GroupData.poids == 6 | GroupData.poids ==12) &...
    ~isnan(GroupData.emg(:,1))' & ismember(GroupData.muscle,Muscles1);
flag2 = (GroupData.poids == 6 | GroupData.poids ==12) &...
    ~isnan(GroupData.emg(:,1))' & ismember(GroupData.muscle,Muscles2);
   
% Generate figure for SRM with Confidence interval
% X value: DoF, Y value SRM +- IC, Women Red, Men Blue
g(1,1)=gramm('x',repmat([1:4000]',1,length(GroupData.poids))','y',GroupData.emg, 'color',GroupData.sex,'linestyle',GroupData.poids,'subset', flag1);
g(1,1).set_color_options('map',[0 0 1; 1 0 0]);

g(1,1).facet_grid(GroupData.muscle,[],'scale', 'free_y', 'column_labels', false, ...
    'row_labels',true);
g(1,1).stat_summary('type','sem','geom','area','setylim','true');
g(1,1).set_names('y','', 'x', '% of movement duration', 'row','');
g(1,1).set_text_options('font','Arial');
g(1,1).axe_property('XLim',[0 4000]); 


g(1,2)=gramm('x',repmat([1:4000]',1,length(GroupData.poids))','y',GroupData.emg, 'color',GroupData.sex,'linestyle',GroupData.poids,'subset', flag2);
g(1,2).set_color_options('map',[0 0 1; 1 0 0]);

g(1,2).facet_grid(GroupData.muscle,[],'scale', 'free_y', 'column_labels', false, ...
    'row_labels',true);
g(1,2).stat_summary('type','sem','geom','area','setylim','true');
g(1,2).set_names('y','', 'x', '% of movement duration', 'row','');
g(1,2).set_text_options('font','Arial');
g(1,2).axe_property('XLim',[0 4000]); 



g.draw;
g.export('file_name','EMGplots','export_path','C:\Users\jaybo\Desktop','file_type','pdf');
