close all
clear g
%clear 
figure('Units', 'centimeters','Position', [1.5, 1, 16.5, 8.8]);

Variables={'DELT3xDELT2', 'DELT3xDELT1', 'DELT3xINFSP', 'DELT3xSUPSP',...
    'DELT3xSUBSC', 'DELT3xLAT', 'DELT3xPECM1','DELT2xDELT1', 'DELT2xINFSP',...
    'DELT2xSUPSP', 'DELT2xSUBSC', 'DELT2xLAT', 'DELT2xPECM1',...
    'DELT1xINFSP', 'DELT1xSUPSP', 'DELT1xSUBSC', 'DELT1xLAT', 'DELT1xPECM1',...
    'INFSPxSUPSP', 'INFSPxSUBSC', 'INFSPxLAT', 'INFSPxPECM1',...
    'SUPSPxSUBSC', 'SUPSPxLAT', 'SUPSPxPECM1',...
    'SUBSCxLAT', 'SUBSCxPECM1','LATxPECM1'};

BadSubj={'YosC', 'VicJ', 'MarA', 'GatB' };


%%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{1}) ...
    & ~ismember(Groupdata.name,BadSubj);
g(1,1)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(1,1).set_color_options('map',[0 0 1; 1 0 0]);
g(1,1).stat_summary('type','sem','geom','area','setylim','true');
g(1,1).set_names('y','', 'x', '% of movement duration', 'row','');
g(1,1).set_text_options('font','Arial');
g(1,1).no_legend();
g(1,1).axe_property('XLim',[0 4000]); 
g(1,1).set_title('Lateral deltoid')


%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{2}) & ~ismember(Groupdata.name,BadSubj);
g(1,2)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(1,2).set_color_options('map',[0 0 1; 1 0 0]);
g(1,2).stat_summary('type','sem','geom','area','setylim','true');
g(1,2).set_names('y','', 'x', '% of movement duration', 'row','');
g(1,2).set_text_options('font','Arial');
g(1,2).no_legend();
g(1,2).axe_property('XLim',[0 4000]); 
g(1,2).set_title('Anterior deltoid')

%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{3}) & ~ismember(Groupdata.name,BadSubj);
g(1,3)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(1,3).set_color_options('map',[0 0 1; 1 0 0]);
g(1,3).stat_summary('type','sem','geom','area','setylim','true');
g(1,3).set_names('y','', 'x', '% of movement duration', 'row','');
g(1,3).set_text_options('font','Arial');
g(1,3).no_legend();
g(1,3).axe_property('XLim',[0 4000]); 
g(1,3).set_title('Infraspinatus')


%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{4}) & ~ismember(Groupdata.name,BadSubj);
g(1,4)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(1,4).set_color_options('map',[0 0 1; 1 0 0]);
g(1,4).stat_summary('type','sem','geom','area','setylim','true');
g(1,4).set_names('y','', 'x', '% of movement duration', 'row','');
g(1,4).set_text_options('font','Arial');
g(1,4).no_legend();
g(1,4).axe_property('XLim',[0 4000]); g(1,2).set_title('Lateral deltoid')
g(1,4).set_title('Supraspinatus')


%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{5}) & ~ismember(Groupdata.name,BadSubj);
g(1,5)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(1,5).set_color_options('map',[0 0 1; 1 0 0]);
g(1,5).stat_summary('type','sem','geom','area','setylim','true');
g(1,5).set_names('y','', 'x', '% of movement duration', 'row','');
g(1,5).set_text_options('font','Arial');
g(1,5).no_legend();
g(1,5).axe_property('XLim',[0 4000]);
g(1,5).set_title('Subscapularis')

%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{6}) & ~ismember(Groupdata.name,BadSubj);
g(1,6)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(1,6).set_color_options('map',[0 0 1; 1 0 0]);
g(1,6).stat_summary('type','sem','geom','area','setylim','true');
g(1,6).set_names('y','', 'x', '% of movement duration', 'row','');
g(1,6).set_text_options('font','Arial');
g(1,6).no_legend();
g(1,6).axe_property('XLim',[0 4000]); 
g(1,6).set_title('Latissimus dorsi')

%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{7}) & ~ismember(Groupdata.name,BadSubj);
g(1,7)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(1,7).set_color_options('map',[0 0 1; 1 0 0]);
g(1,7).stat_summary('type','sem','geom','area','setylim','true');
g(1,7).set_names('y','', 'x', '% of movement duration', 'row','');
g(1,7).set_text_options('font','Arial');
g(1,7).no_legend();
g(1,7).axe_property('XLim',[0 4000]); 
g(1,7).set_title('Pectoralis major')

 %%
 flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{8}) & ~ismember(Groupdata.name,BadSubj);
g(2,2)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(2,2).set_color_options('map',[0 0 1; 1 0 0]);
g(2,2).stat_summary('type','sem','geom','area','setylim','true');
g(2,2).set_names('y','', 'x', '% of movement duration', 'row','');
g(2,2).set_text_options('font','Arial');
g(2,2).no_legend();
g(2,2).axe_property('XLim',[0 4000]); 

%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{9}) & ~ismember(Groupdata.name,BadSubj);
g(2,3)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(2,3).set_color_options('map',[0 0 1; 1 0 0]);
g(2,3).stat_summary('type','sem','geom','area','setylim','true');
g(2,3).set_names('y','', 'x', '% of movement duration', 'row','');
g(2,3).set_text_options('font','Arial');
g(2,3).no_legend();
g(2,3).axe_property('XLim',[0 4000]); 

%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{10}) & ~ismember(Groupdata.name,BadSubj);
g(2,4)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(2,4).set_color_options('map',[0 0 1; 1 0 0]);
g(2,4).stat_summary('type','sem','geom','area','setylim','true');
g(2,4).set_names('y','', 'x', '% of movement duration', 'row','');
g(2,4).set_text_options('font','Arial');
g(2,4).no_legend();
g(2,4).axe_property('XLim',[0 4000]); 

%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{11}) & ~ismember(Groupdata.name,BadSubj);
g(2,5)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(2,5).set_color_options('map',[0 0 1; 1 0 0]);
g(2,5).stat_summary('type','sem','geom','area','setylim','true');
g(2,5).set_names('y','', 'x', '% of movement duration', 'row','');
g(2,5).set_text_options('font','Arial');
g(2,5).no_legend();
g(2,5).axe_property('XLim',[0 4000]);

%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{12}) & ~ismember(Groupdata.name,BadSubj);
g(2,6)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(2,6).set_color_options('map',[0 0 1; 1 0 0]);
g(2,6).stat_summary('type','sem','geom','area','setylim','true');
g(2,6).set_names('y','', 'x', '% of movement duration', 'row','');
g(2,6).set_text_options('font','Arial');
g(2,6).no_legend();
g(2,6).axe_property('XLim',[0 4000]); 

%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{13}) & ~ismember(Groupdata.name,BadSubj);
g(2,7)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(2,7).set_color_options('map',[0 0 1; 1 0 0]);
g(2,7).stat_summary('type','sem','geom','area','setylim','true');
g(2,7).set_names('y','', 'x', '% of movement duration', 'row','');
g(2,7).set_text_options('font','Arial');
g(2,7).no_legend();
g(2,7).axe_property('XLim',[0 4000]); 

%%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{14}) & ~ismember(Groupdata.name,BadSubj);
g(3,3)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(3,3).set_color_options('map',[0 0 1; 1 0 0]);
g(3,3).stat_summary('type','sem','geom','area','setylim','true');
g(3,3).set_names('y','', 'x', '% of movement duration', 'row','');
g(3,3).set_text_options('font','Arial');
g(3,3).no_legend();
g(3,3).axe_property('XLim',[0 4000]); 

%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{15}) & ~ismember(Groupdata.name,BadSubj);
g(3,4)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(3,4).set_color_options('map',[0 0 1; 1 0 0]);
g(3,4).stat_summary('type','sem','geom','area','setylim','true');
g(3,4).set_names('y','', 'x', '% of movement duration', 'row','');
g(3,4).set_text_options('font','Arial');
g(3,4).no_legend();
g(3,4).axe_property('XLim',[0 4000]); 

%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{16}) & ~ismember(Groupdata.name,BadSubj);
g(3,5)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(3,5).set_color_options('map',[0 0 1; 1 0 0]);
g(3,5).stat_summary('type','sem','geom','area','setylim','true');
g(3,5).set_names('y','', 'x', '% of movement duration', 'row','');
g(3,5).set_text_options('font','Arial');
g(3,5).no_legend();
g(3,5).axe_property('XLim',[0 4000]);

%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{17}) & ~ismember(Groupdata.name,BadSubj);
g(3,6)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(3,6).set_color_options('map',[0 0 1; 1 0 0]);
g(3,6).stat_summary('type','sem','geom','area','setylim','true');
g(3,6).set_names('y','', 'x', '% of movement duration', 'row','');
g(3,6).set_text_options('font','Arial');
g(3,6).no_legend();
g(3,6).axe_property('XLim',[0 4000]); 

%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{18}) & ~ismember(Groupdata.name,BadSubj);
g(3,7)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(3,7).set_color_options('map',[0 0 1; 1 0 0]);
g(3,7).stat_summary('type','sem','geom','area','setylim','true');
g(3,7).set_names('y','', 'x', '% of movement duration', 'row','');
g(3,7).set_text_options('font','Arial');
g(3,7).no_legend();
g(3,7).axe_property('XLim',[0 4000]); 

%%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{19}) & ~ismember(Groupdata.name,BadSubj);
g(4,4)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(4,4).set_color_options('map',[0 0 1; 1 0 0]);
g(4,4).stat_summary('type','sem','geom','area','setylim','true');
g(4,4).set_names('y','', 'x', '% of movement duration', 'row','');
g(4,4).set_text_options('font','Arial');
g(4,4).no_legend();
g(4,4).axe_property('XLim',[0 4000]); 

%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{20}) & ~ismember(Groupdata.name,BadSubj);
g(4,5)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(4,5).set_color_options('map',[0 0 1; 1 0 0]);
g(4,5).stat_summary('type','sem','geom','area','setylim','true');
g(4,5).set_names('y','', 'x', '% of movement duration', 'row','');
g(4,5).set_text_options('font','Arial');
g(4,5).no_legend();
g(4,5).axe_property('XLim',[0 4000]);

%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{21}) & ~ismember(Groupdata.name,BadSubj);
g(4,6)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(4,6).set_color_options('map',[0 0 1; 1 0 0]);
g(4,6).stat_summary('type','sem','geom','area','setylim','true');
g(4,6).set_names('y','', 'x', '% of movement duration', 'row','');
g(4,6).set_text_options('font','Arial');
g(4,6).no_legend();
g(4,6).axe_property('XLim',[0 4000]); 

%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{22}) & ~ismember(Groupdata.name,BadSubj);
g(4,7)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(4,7).set_color_options('map',[0 0 1; 1 0 0]);
g(4,7).stat_summary('type','sem','geom','area','setylim','true');
g(4,7).set_names('y','', 'x', '% of movement duration', 'row','');
g(4,7).set_text_options('font','Arial');
g(4,7).no_legend();
g(4,7).axe_property('XLim',[0 4000]); 

%%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{23}) & ~ismember(Groupdata.name,BadSubj);
g(5,5)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(5,5).set_color_options('map',[0 0 1; 1 0 0]);
g(5,5).stat_summary('type','sem','geom','area','setylim','true');
g(5,5).set_names('y','', 'x', '% of movement duration', 'row','');
g(5,5).set_text_options('font','Arial');
g(5,5).no_legend();
g(5,5).axe_property('XLim',[0 4000]);

%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{24}) & ~ismember(Groupdata.name,BadSubj);
g(5,6)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(5,6).set_color_options('map',[0 0 1; 1 0 0]);
g(5,6).stat_summary('type','sem','geom','area','setylim','true');
g(5,6).set_names('y','', 'x', '% of movement duration', 'row','');
g(5,6).set_text_options('font','Arial');
g(5,6).no_legend();
g(5,6).axe_property('XLim',[0 4000]); 

%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{25}) & ~ismember(Groupdata.name,BadSubj);
g(5,7)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(5,7).set_color_options('map',[0 0 1; 1 0 0]);
g(5,7).stat_summary('type','sem','geom','area','setylim','true');
g(5,7).set_names('y','', 'x', '% of movement duration', 'row','');
g(5,7).set_text_options('font','Arial');
g(5,7).no_legend();
g(5,7).axe_property('XLim',[0 4000]); 

%%
%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{26}) & ~ismember(Groupdata.name,BadSubj);
g(6,6)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(6,6).set_color_options('map',[0 0 1; 1 0 0]);
g(6,6).stat_summary('type','sem','geom','area','setylim','true');
g(6,6).set_names('y','', 'x', '% of movement duration', 'row','');
g(6,6).set_text_options('font','Arial');
g(6,6).no_legend();
g(6,6).axe_property('XLim',[0 4000]); 

%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{27}) & ~ismember(Groupdata.name,BadSubj);
g(6,7)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(6,7).set_color_options('map',[0 0 1; 1 0 0]);
g(6,7).stat_summary('type','sem','geom','area','setylim','true');
g(6,7).set_names('y','', 'x', '% of movement duration', 'row','');
g(6,7).set_text_options('font','Arial');
g(6,7).no_legend();
g(6,7).axe_property('XLim',[0 4000]); 

%%
%
flag = (Groupdata.poids == 6 | Groupdata.poids ==12) &...
    ~isnan(Groupdata.Scalardata(:,1))' & ismember(Groupdata.variable,Variables{28}) & ~ismember(Groupdata.name,BadSubj);
g(7,7)=gramm('x',repmat([1:4000]',1,length(Groupdata.poids))','y',Groupdata.Scalardata, 'color',Groupdata.sexe,'linestyle',Groupdata.poids,'subset', flag);
g(7,7).set_color_options('map',[0 0 1; 1 0 0]);
g(7,7).stat_summary('type','sem','geom','area','setylim','true');
g(7,7).set_names('y','', 'x', '% of movement duration', 'row','');
g(7,7).set_text_options('font','Arial');
g(7,7).no_legend();
g(7,7).axe_property('XLim',[0 4000]); 

g.draw;
%g.export('file_name','BOXplotsjb','file_type','pdf');
