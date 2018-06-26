close all
clear g

signal = {'DeltA','DeltM','DeltP', 'Lat', 'Pect','Infra', 'Supra','SubScap','BB','TB','MFdelt','MFrotator','MFBlache','DENOMINATORdelt','DENOMINATORrotator','DENOMINATORBlache'};

% Generate figure for SRM with Confidence interval
% X value: DoF, Y value SRM +- IC, Women Red, Men Blue
g=gramm('x',ES.variable,'y',ES.cohenD,'size',ES.duration/40);%, 'label', round(data.proportion))
g.set_color_options('map',[0 0 0])
g.set_order_options('x',signal)

% Set X Tick Label at 45 deg (names of DoF) and SRM limits between -.2.5
% and 2.5
g.axe_property('XTickLabelRotation',45) 

% Create 2x2 figure, colume are Statistics (Mean or SD) and Rows are
% Variables (Average position or Range of Motion)
g.facet_grid(ES.effect,[],'column_labels',false)

%Plot data as points surrounded by errorbars
g.geom_point()
%g.geom_label('VerticalAlignment','middle','HorizontalAlignment','right')
%g.geom_interval('geom','errorbar')

% Set text properties;
g.set_names('column','','row','','x','','y','Cohen''s D','color','');
g.set_text_options('Font','Arial','label_scaling',1.2);
g.set_point_options('base_size',1,'use_input',true,'input_fun',@(s)1+s/5);


figure('Position',[100 100 800 600])
g.draw()

g.update('x',ES.variable,'y',ES.cohenD,'size',ES.tohide/40);%, 'label', round(data.proportion))
g.set_color_options('map',[.8 .8 .8])
g.geom_point()
%g.facet_grid(ES.effect,[])
g.set_point_options('base_size',1,'use_input',true,'input_fun',@(s)1+s/5);

g.draw()

g.update('x',ES.variable,'y',ES.cohenD6,'size',ES.durationD6/40);%, 'label', round(data.proportion))
g.set_color_options('map',[0 1 0])
g.geom_point()
%g.facet_grid(ES.effect,[])
g.set_point_options('base_size',1,'use_input',true,'input_fun',@(s)1+s/5);

g.draw()

g.update('x',ES.variable,'y',ES.cohenD12,'size',ES.durationD12/40);%, 'label', round(data.proportion))
g.set_color_options('map',[1 0 1])
g.geom_point()
%g.facet_grid(ES.effect,[])
g.set_point_options('base_size',1,'use_input',true,'input_fun',@(s)1+s/5);

g.draw()

g.update('x',ES.variable,'y',ES.cohenDM,'size',ES.durationDM/40);%, 'label', round(data.proportion))
g.set_color_options('map',[0 0 1])
g.geom_point()
%g.facet_grid(ES.effect,[])
g.set_point_options('base_size',1,'use_input',true,'input_fun',@(s)1+s/5);

g.draw()

g.update('x',ES.variable,'y',ES.cohenDF,'size',ES.durationDF/40);%, 'label', round(data.proportion))
g.set_color_options('map',[1 0 0])
g.geom_point()
%g.facet_grid(ES.effect,[])
g.set_point_options('base_size',1,'use_input',true,'input_fun',@(s)1+s/5);
%g.axe_property('YLim',[0 2]) 


g.draw()



g.export('file_name','Figure_effectsize_posthoc2','file_type','pdf');
% g.update('x',data.Signal,'y',(data.proportion-50)/100*4,'color',data.Sex)
% g.set_color_options('map',[0 0 1; 1 0 0])
% 
% g.geom_point('alpha',0.5)
% g.set_point_options('markers',{'>'})
% % g.axe_property('XTickLabelRotation',45,'YLim',[-2 2])
%  g.draw