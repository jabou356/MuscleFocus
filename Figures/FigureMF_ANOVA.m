close all
clearvars -except ANOVA
figure('Units', 'centimeters','Position', [1.5, 1, 16.5, 17.6]);

Variables={'MFBlache', 'DENOMINATORBlache'};


for ivar=1:length(Variables)
    toplot.variable((ivar*3)-2:(ivar*3))=deal(Variables(ivar));
    toplot.p((ivar*3)-2:(ivar*3),1:4000)=0;
    toplot.effect{ivar*3-2}='MainA';
    toplot.y(ivar*3-2,1:4000) = 1;
    toplot.effect{ivar*3- 1}='MainB';
    toplot.y(ivar*3-1,1:4000) = 2;
    toplot.effect{ivar*3}='IntAB';
    toplot.y(ivar*3,1:4000) = 3;

    
    MainA = ANOVA.(Variables{ivar}).MainA;
    MainB = ANOVA.(Variables{ivar}).MainB;
    IntAB = ANOVA.(Variables{ivar}).IntAB;
    
    if MainA.nClusters > 0
        for icluster = 1:length(MainA.clusters)
            endpoints = round(MainA.clusters{1,icluster}.endpoints)+1;
            toplot.p(ivar*3-2,endpoints(1):endpoints(2)) = 1-MainA.clusters{1,icluster}.P;
            
        end
    end
    
    if MainB.nClusters > 0
        for icluster = 1:length(MainB.clusters)
            endpoints = round(MainB.clusters{1,icluster}.endpoints)+1;
            toplot.p(ivar*3-1,endpoints(1):endpoints(2)) = 1-MainB.clusters{1,icluster}.P;
        end
    end
    
    if IntAB.nClusters > 0
        for icluster = 1:length(IntAB.clusters)
            endpoints = round(IntAB.clusters{1,icluster}.endpoints)+1;
            toplot.p(ivar*3,endpoints(1):endpoints(2)) = 1-IntAB.clusters{1,icluster}.P;
        end
    end
end

Muscles1={'DeltA', 'DeltM', 'DeltP', 'Pect', 'Lat'};
Muscles2={'Supra', 'Infra', 'SubScap', 'BB', 'TB'};

for ivar = 1:length(Variables)
    
    subplot(2,1,ivar)
    x = repmat(1:4000,1,5);
    y = repmat([1;2;3;4;5],4000,1);
    c = [toplot.p(strcmp(toplot.variable,Variables{ivar}) & toplot.y(:,1)' == 1,:); 
        zeros(1,4000); ...
        toplot.p(strcmp(toplot.variable,Variables{ivar}) & toplot.y(:,1)' == 2,:);
        zeros(1,4000); 
        toplot.p(strcmp(toplot.variable,Variables{ivar}) & toplot.y(:,1)' == 3,:)]
    h=image(x,y,c);
    hold on
    h.CDataMapping='scaled';
    caxis = [0.95 1];
    axis([0 4000 0 6]) 
    colormap(flipud(gray))
    ylabel(Variables{ivar})
    
end

   

