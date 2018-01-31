close all
clearvars -except ANOVA
figure('Units', 'centimeters','Position', [1.5, 1, 16.5, 17.6]);

Muscles={'DeltA', 'DeltM', 'DeltP', 'Pect', 'Lat','Supra', 'Infra', 'SubScap', 'BB', 'TB'};


for imuscle=1:length(Muscles)
    toplot.muscle((imuscle*3)-2:(imuscle*3))=deal(Muscles(imuscle));
    toplot.p((imuscle*3)-2:(imuscle*3),1:4000)=0;
    toplot.effect{imuscle*3-2}='MainA';
    toplot.y(imuscle*3-2,1:4000) = 1;
    toplot.effect{imuscle*3- 1}='MainB';
    toplot.y(imuscle*3-1,1:4000) = 2;
    toplot.effect{imuscle*3}='IntAB';
    toplot.y(imuscle*3,1:4000) = 3;

    
    MainA = ANOVA.(Muscles{imuscle}).MainA;
    MainB = ANOVA.(Muscles{imuscle}).MainB;
    IntAB = ANOVA.(Muscles{imuscle}).IntAB;
    
    if MainA.nClusters > 0
        for icluster = 1:length(MainA.clusters)
            endpoints = round(MainA.clusters{1,icluster}.endpoints)+1;
            toplot.p(imuscle*3-2,endpoints(1):endpoints(2)) = 1-MainA.clusters{1,icluster}.P;
            
        end
    end
    
    if MainB.nClusters > 0
        for icluster = 1:length(MainB.clusters)
            endpoints = round(MainB.clusters{1,icluster}.endpoints)+1;
            toplot.p(imuscle*3-1,endpoints(1):endpoints(2)) = 1-MainB.clusters{1,icluster}.P;
        end
    end
    
    if IntAB.nClusters > 0
        for icluster = 1:length(IntAB.clusters)
            endpoints = round(IntAB.clusters{1,icluster}.endpoints)+1;
            toplot.p(imuscle*3,endpoints(1):endpoints(2)) = 1-IntAB.clusters{1,icluster}.P;
        end
    end
end

Muscles1={'DeltA', 'DeltM', 'DeltP', 'Pect', 'Lat'};
Muscles2={'Supra', 'Infra', 'SubScap', 'BB', 'TB'};

for imuscle = 1:length(Muscles)
    
    subplot(5,2,imuscle)
    x = repmat(1:4000,1,5);
    y = repmat([1;2;3;4;5],4000,1);
    c = [toplot.p(strcmp(toplot.muscle,Muscles{imuscle}) & toplot.y(:,1)' == 1,:); 
        zeros(1,4000); ...
        toplot.p(strcmp(toplot.muscle,Muscles{imuscle}) & toplot.y(:,1)' == 2,:);
        zeros(1,4000); 
        toplot.p(strcmp(toplot.muscle,Muscles{imuscle}) & toplot.y(:,1)' == 3,:)]
    h=image(x,y,c);
    hold on
    h.CDataMapping='scaled';
    caxis = [0.95 1];
    axis([0 4000 0 6]) 
    colormap(flipud(gray))
    ylabel(Muscles{imuscle})
    
end

   

