Muscles={'DeltA', 'DeltM', 'DeltP', 'BB', 'TB', 'UpTrap',...
    'LowTrap', 'SerrAnt', 'Supra', 'Infra', 'SubScap',...
    'Pect', 'Lat'};

for imuscle=1:length(Muscles)
    ROI=[];
    
    IntAB = ANOVA.(Muscles{imuscle}).IntAB;
    nClusters = IntAB.nClusters;
    
    if nClusters > 0
        for icluster =  nClusters : -1: 2
            % Merge clusters separated by less thant 5% movement duration (200/4000) 
            if IntAB.clusters{1,icluster-1}.endpoints(2)<IntAB.clusters{1,icluster}.endpoints(1)-200
                tomerge(icluster)=1;
            end
            p(icluster) = IntAB.clusters{1,icluster}.p;
        end
        
        isROI = find(tomerge==0);
        for icluster = length(isROI):-1:1
            ROI(icluster,1) = IntAB.clusters{1,isROI(icluster)}.endpoints(1);
            
            
            if icluster == length(isROI)
                ROI(icluster,2) = IntAB.clusters{1, nClusters}.endpoints(2);
                P(icluster) = min(p(isROI(icluster):end)); % take the minimum p value of all merged clusters, say that P < min(p)
            else
                ROI(icluster,2) = IntAB.clusters{1, isROI(icluster+1)-1}.endpoints(2);
                P(icluster) = min(p(isROI(icluster):isROI(icluster+1)-1));
            end
        end
        
        % clear clusters of less thant 5% movement duration (200/4000)
        ROI = ROI(ROI(:,2)-ROI(:,1) > 200,:);
        P = ROI(:,2)-ROI(:,1);
    end
        
            


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
FFni.(Muscles{imuscle}) = FFn.inference(alpha, 'iterations', iterations);
disp_summ(FFni.(Muscles{imuscle}))
end

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
