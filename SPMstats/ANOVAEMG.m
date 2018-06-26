Muscles={'DeltA', 'DeltM', 'DeltP', 'BB', 'TB', 'UpTrap',...
    'LowTrap', 'SerrAnt', 'Supra', 'Infra', 'SubScap',...
    'Pect', 'Lat'};

for imuscle=1:length(Muscles)
flag = strcmp(GroupData.muscle,Muscles{imuscle}) & ...
    (GroupData.poids == 6 | GroupData.poids ==12) &...
    ~isnan(GroupData.emg(:,1))';

Y = GroupData.emg(flag,:);
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

ANOVA.(Muscles{imuscle}).Y=Y;
ANOVA.(Muscles{imuscle}).A=A;
ANOVA.(Muscles{imuscle}).B=B;
ANOVA.(Muscles{imuscle}).SUBJ=SUBJ;
ANOVA.(Muscles{imuscle}).iterations = iterations;
ANOVA.(Muscles{imuscle}).alpha = alpha;

ANOVA.(Muscles{imuscle}).MainA.nClusters = FFni.SPMs{1, 1}.nClusters;
ANOVA.(Muscles{imuscle}).MainA.clusters = FFni.SPMs{1, 1}.clusters;
ANOVA.(Muscles{imuscle}).MainA.z = FFni.SPMs{1, 1}.z;
ANOVA.(Muscles{imuscle}).MainA.zstar = FFni.SPMs{1, 1}.zstar;
ANOVA.(Muscles{imuscle}).MainA.Stat = FFni.SPMs{1, 1}.STAT;

ANOVA.(Muscles{imuscle}).MainB.nClusters = FFni.SPMs{1, 2}.nClusters;
ANOVA.(Muscles{imuscle}).MainB.clusters = FFni.SPMs{1, 2}.clusters;
ANOVA.(Muscles{imuscle}).MainB.z = FFni.SPMs{1, 2}.z;
ANOVA.(Muscles{imuscle}).MainB.zstar = FFni.SPMs{1, 2}.zstar;
ANOVA.(Muscles{imuscle}).MainB.Stat = FFni.SPMs{1, 2}.STAT;

ANOVA.(Muscles{imuscle}).IntAB.nClusters = FFni.SPMs{1, 3}.nClusters;
ANOVA.(Muscles{imuscle}).IntAB.clusters = FFni.SPMs{1, 3}.clusters;
ANOVA.(Muscles{imuscle}).IntAB.z = FFni.SPMs{1, 3}.z;
ANOVA.(Muscles{imuscle}).IntAB.zstar = FFni.SPMs{1, 3}.zstar;
ANOVA.(Muscles{imuscle}).IntAB.Stat = FFni.SPMs{1, 3}.STAT;


clearvars -except Muscles GroupData ANOVA


end

%save(['ANOVA',Muscles{imuscle}],'FFni');

% 
% 
% %(2) Plot:
% close all;
% FFni.plot('plot_threshold_label',true, 'plot_p_values',true, 'autoset_ylim',true);
% % FFi        = spm1d.stats.anova2onerm(Y, A, B, SUBJ).inference(alpha);
% % %%% compare to parametric results by plotting the parametric thresholds:
% % for i = 1:FFi.nEffects
% %     Fi = FFi(i);
% %     subplot(2,2,i);
% %     hold on
% %     plot([0 numel(Fi.z)], Fi.zstar*[1 1], 'color','c', 'linestyle','--')
% %     hold off
% %     text(5, Fi.zstar, 'Parametric', 'color','k', 'backgroundcolor','c')
% % end
% % 
% subplot(2,2,1)
% xlabel(['nH = ', num2str(length(sujetH)), ' nF =', num2str(length(sujetF)), ' Muscle: ', Signal]);
% 
% 
