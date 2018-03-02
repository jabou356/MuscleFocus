Variables={'MFBlache', 'DENOMINATORBlache', 'MFrotator', 'DENOMINATORrotator'};
BadSubj={'YosC', 'VicJ'};


for ivar=1:length(Variables)
flag = strcmp(GroupData.variable,Variables{ivar}) & ...
    (GroupData.poids == 6 | GroupData.poids ==12) &...
    ~isnan(GroupData.MFdata(:,1))' &  ~ismember(GroupData.name,BadSubj);

Y = GroupData.MFdata(flag,:);
A = GroupData.sex(flag);
B = GroupData.poids(flag);
SUBJ = GroupData.SID(flag);

uniqueSUBJ = unique(SUBJ);
for isubj=1:length(uniqueSUBJ)
    ID = find(SUBJ == uniqueSUBJ(isubj));
    if length(ID) ~= 2
        SUBJ(ID)=nan;
    end
end

Y = Y(~isnan(SUBJ),:);
A = A(~isnan(SUBJ));
B = B(~isnan(SUBJ));
SUBJ = SUBJ(~isnan(SUBJ));
    


%(1) Conduct non-parametric test:
rng(0)     %set the random number generator seed
alpha      = 0.05;
iterations = 10000;
FFn        = spm1d.stats.nonparam.anova2onerm(Y, A, B, SUBJ);
FFni = FFn.inference(alpha, 'iterations', iterations);
disp_summ(FFni)

ANOVA.(Variables{ivar}).Y=Y;
ANOVA.(Variables{ivar}).A=A;
ANOVA.(Variables{ivar}).B=B;
ANOVA.(Variables{ivar}).SUBJ=SUBJ;
ANOVA.(Variables{ivar}).iterations = iterations;
ANOVA.(Variables{ivar}).alpha = alpha;

ANOVA.(Variables{ivar}).MainA.nClusters = FFni.SPMs{1, 1}.nClusters;
ANOVA.(Variables{ivar}).MainA.clusters = FFni.SPMs{1, 1}.clusters;
ANOVA.(Variables{ivar}).MainA.z = FFni.SPMs{1, 1}.z;
ANOVA.(Variables{ivar}).MainA.zstar = FFni.SPMs{1, 1}.zstar;
ANOVA.(Variables{ivar}).MainA.Stat = FFni.SPMs{1, 1}.STAT;

ANOVA.(Variables{ivar}).MainB.nClusters = FFni.SPMs{1, 2}.nClusters;
ANOVA.(Variables{ivar}).MainB.clusters = FFni.SPMs{1, 2}.clusters;
ANOVA.(Variables{ivar}).MainB.z = FFni.SPMs{1, 2}.z;
ANOVA.(Variables{ivar}).MainB.zstar = FFni.SPMs{1, 2}.zstar;
ANOVA.(Variables{ivar}).MainB.Stat = FFni.SPMs{1, 2}.STAT;

ANOVA.(Variables{ivar}).IntAB.nClusters = FFni.SPMs{1, 3}.nClusters;
ANOVA.(Variables{ivar}).IntAB.clusters = FFni.SPMs{1, 3}.clusters;
ANOVA.(Variables{ivar}).IntAB.z = FFni.SPMs{1, 3}.z;
ANOVA.(Variables{ivar}).IntAB.zstar = FFni.SPMs{1, 3}.zstar;
ANOVA.(Variables{ivar}).IntAB.Stat = FFni.SPMs{1, 3}.STAT;


clearvars -except Variables GroupData ANOVA BadSubj


end
