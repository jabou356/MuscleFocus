clearvars -except ANOVA

Variables={'MFBlache', 'DENOMINATORBlache', 'MFallmuscles', 'DENOMINATORallmuscles', 'DENOMINATORrotator', 'MFrotator','DENOMINATORdelt', 'MFdelt'};


for ivar=1:length(Variables)
    ROI=[];
    
    Y = ANOVA.(Variables{ivar}).Y;
    A = ANOVA.(Variables{ivar}).A;
    B = ANOVA.(Variables{ivar}).B;
    SUBJ = ANOVA.(Variables{ivar}).SUBJ;
    
    IntAB = ANOVA.(Variables{ivar}).IntAB;
    nClusters = IntAB.nClusters;
    
    
    if nClusters > 0
        p (1) = IntAB.clusters{1,1}.P;
        
        tomerge(1)=0;
        for icluster =  nClusters : -1: 2
            % Merge clusters separated by less thant 5% movement duration (200/4000) 
            if IntAB.clusters{1,icluster-1}.endpoints(2)>IntAB.clusters{1,icluster}.endpoints(1)-200
                tomerge(icluster)=1;
            else 
                tomerge(icluster)=0;
            end
            p(icluster) = IntAB.clusters{1,icluster}.P;
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
        ROI = round(ROI(ROI(:,2)-ROI(:,1) > 200,:));
        P = P(ROI(:,2)-ROI(:,1) >200);
        
%% Conduct Post-Hoc tests on clusters            
rng(0)
alpha      = 0.0083;
two_tailed = true;
iterations = min([10000, 2^(length(find(A==1))/2), 2^(length(find(A==2))/2)]);
if iterations >= 121


for icluster = length(ROI(:,1)):-1:1
    POSTHoc.(Variables{ivar}){icluster}.ROI = ROI(icluster,:);
    POSTHoc.(Variables{ivar}){icluster}.ANOVAp = P(icluster);
%(1) Conduct non-parametric test:

snpm       = spm1d.stats.nonparam.ttest2(Y(A==1&B==6,ROI(icluster,1):ROI(icluster,2)), Y(A==2&B==6,ROI(icluster,1):ROI(icluster,2)));
snpmi = snpm.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results : H6F6')
disp( snpmi )
POSTHoc.(Variables{ivar}){icluster}.H6F6.z = snpmi.z;
POSTHoc.(Variables{ivar}){icluster}.H6F6.zstar = snpmi.zstar;
POSTHoc.(Variables{ivar}){icluster}.H6F6.nClusters = snpmi.nClusters;
POSTHoc.(Variables{ivar}){icluster}.H6F6.clusters = snpmi.clusters;

snpm       = spm1d.stats.nonparam.ttest2(Y(A==1&B==12,ROI(icluster,1):ROI(icluster,2)), Y(A==2&B==12,ROI(icluster,1):ROI(icluster,2)));
snpmi = snpm.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results : H12F12')
disp( snpmi )
POSTHoc.(Variables{ivar}){icluster}.H12F12.z = snpmi.z;
POSTHoc.(Variables{ivar}){icluster}.H12F12.zstar = snpmi.zstar;
POSTHoc.(Variables{ivar}){icluster}.H12F12.nClusters = snpmi.nClusters;
POSTHoc.(Variables{ivar}){icluster}.H12F12.clusters = snpmi.clusters;

snpm       = spm1d.stats.nonparam.ttest2(Y(A==1&B==6,ROI(icluster,1):ROI(icluster,2)), Y(A==2&B==12,ROI(icluster,1):ROI(icluster,2)));
snpmi = snpm.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results : H6F12')
disp( snpmi )
POSTHoc.(Variables{ivar}){icluster}.H6F12.z = snpmi.z;
POSTHoc.(Variables{ivar}){icluster}.H6F12.zstar = snpmi.zstar;
POSTHoc.(Variables{ivar}){icluster}.H6F12.nClusters = snpmi.nClusters;
POSTHoc.(Variables{ivar}){icluster}.H6F12.clusters = snpmi.clusters;

snpm       = spm1d.stats.nonparam.ttest2(Y(A==1&B==12,ROI(icluster,1):ROI(icluster,2)), Y(A==2&B==6,ROI(icluster,1):ROI(icluster,2)));
snpmi = snpm.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results : H12F6')
disp( snpmi )
POSTHoc.(Variables{ivar}){icluster}.H12F6.z = snpmi.z;
POSTHoc.(Variables{ivar}){icluster}.H12F6.zstar = snpmi.zstar;
POSTHoc.(Variables{ivar}){icluster}.H12F6.nClusters = snpmi.nClusters;
POSTHoc.(Variables{ivar}){icluster}.H12F6.clusters = snpmi.clusters;

snpm       = spm1d.stats.nonparam.ttest_paired(Y(A==1&B==6,ROI(icluster,1):ROI(icluster,2)), Y(A==1&B==12,ROI(icluster,1):ROI(icluster,2)));
snpmi = snpm.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results : H6H12')
disp( snpmi )
POSTHoc.(Variables{ivar}){icluster}.H6H12.z = snpmi.z;
POSTHoc.(Variables{ivar}){icluster}.H6H12.zstar = snpmi.zstar;
POSTHoc.(Variables{ivar}){icluster}.H6H12.nClusters = snpmi.nClusters;
POSTHoc.(Variables{ivar}){icluster}.H6H12.clusters = snpmi.clusters;

snpm       = spm1d.stats.nonparam.ttest_paired(Y(A==2&B==6,ROI(icluster,1):ROI(icluster,2)), Y(A==2&B==12,ROI(icluster,1):ROI(icluster,2)));
snpmi = snpm.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results : F6F12')
disp( snpmi )
POSTHoc.(Variables{ivar}){icluster}.F6F12.z = snpmi.z;
POSTHoc.(Variables{ivar}){icluster}.F6F12.zstar = snpmi.zstar;
POSTHoc.(Variables{ivar}){icluster}.F6F12.nClusters = snpmi.nClusters;
POSTHoc.(Variables{ivar}){icluster}.F6F12.clusters = snpmi.clusters;
end
end
    end
    
    clear tomerge ROI P p
    end

