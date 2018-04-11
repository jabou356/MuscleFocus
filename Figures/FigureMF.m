close all
clear g
%clear 
figure('Units', 'centimeters','Position', [1.5, 1, 16.5, 8.8]);

Variables={'MFrotator', 'DENOMINATORrotator'};
BadSubj={'YosC', 'VicJ', 'MarA', 'GatB' };



flag = (GroupData.poids == 6 | GroupData.poids ==12) &...
    ~isnan(GroupData.MFdata(:,1))' & ismember(GroupData.variable,Variables{1}) ...
    & ~ismember(GroupData.name,BadSubj);

   
% Generate figure for SRM with Confidence interval
% X value: DoF, Y value SRM +- IC, Women Red, Men Blue
g(1,1)=gramm('x',repmat([1:4000]',1,length(GroupData.poids))','y',GroupData.MFdata, 'color',GroupData.sex,'linestyle',GroupData.poids,'subset', flag);
g(1,1).set_color_options('map',[0 0 1; 1 0 0]);

%g(1,1).facet_grid(GroupData.variable,[],'scale', 'free_y', 'column_labels', false, ...
 %   'row_labels',true);
%g(1,1).geom_line();
g(1,1).stat_summary('type','sem','geom','area','setylim','true');
g(1,1).set_names('y','', 'x', '% of movement duration', 'row','');
g(1,1).set_text_options('font','Arial');
g(1,1).axe_property('XLim',[0 4000]); 
g(1,1).axe_property('YLim',[0 1]); 

flag = (GroupData.poids == 6 | GroupData.poids ==12) &...
    ~isnan(GroupData.MFdata(:,1))' & ismember(GroupData.variable,Variables{2});

g(2,1)=gramm('x',repmat([1:4000]',1,length(GroupData.poids))','y',GroupData.MFdata, 'color',GroupData.sex,'linestyle',GroupData.poids,'subset', flag);
g(2,1).set_color_options('map',[0 0 1; 1 0 0]);

%g(1,1).facet_grid(GroupData.variable,[],'scale', 'free_y', 'column_labels', false, ...
 %   'row_labels',true);
%g(1,1).geom_line();
g(2,1).stat_summary('type','sem','geom','area','setylim','true');
g(2,1).set_names('y','', 'x', '% of movement duration', 'row','');
g(2,1).set_text_options('font','Arial');
g(2,1).axe_property('XLim',[0 4000]); 
g(2,1).axe_property('YLim',[0 300]); 

%g.draw;
%g.export('file_name','MFplots032018jb','file_type','pdf');

%figure('Units', 'centimeters','Position', [1.5, 1, 16.5, 4.4]);


flag = (input.poids == 6 | input.poids ==12) &...
    input.hauteur == 2 & ~isnan(input.boite(:,1))';

g(3,1)=gramm('x',repmat([1:100]',1,length(input.poids))','y',input.normboite, 'color',input.sexe,'linestyle',input.poids,'subset', flag);
g(3,1).set_color_options('map',[0 0 1; 1 0 0]);

g(3,1).stat_summary('type','sem','geom','area','setylim','true');
g(3,1).set_names('y','', 'x', '% of movement duration', 'row','');
g(3,1).set_text_options('font','Arial');
g(3,1).axe_property('XLim',[0 100]); 



g.draw;
g.export('file_name','FigureMF1jnt','file_type','pdf');
