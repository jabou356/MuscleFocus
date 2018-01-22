
npergroup=length(A)/4;
%% Test Men vs Women 6kg
  
    roi=false(1,4000);
for icluster=1:length(FFni.SPMs{1,3}.clusters)
   
    endpoint=FFni.SPMs{3}.clusters{1,icluster}.endpoints;
    roi(round(endpoint(1)):round(endpoint(2)))=true;
    
end


%(1) Conduct non-parametric test:
rng(0)
alpha      = 0.0083;
two_tailed = true;
iterations = min([1000, 2^npergroup]);
snpm1       = spm1d.stats.nonparam.ttest2(Y(A==0&B==0,:), Y(A==1&B==0,:),'roi',roi);
snpmiH6F6 = snpm1.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results')
disp( snpmiH6F6 )

%% Test Men vs Women 12kg

%(1) Conduct non-parametric test:
rng(0)
alpha      = 0.0083;
two_tailed = true;
iterations = min([1000, 2^npergroup]);
snpm2       = spm1d.stats.nonparam.ttest2(Y(A==0&B==1,:), Y(A==1&B==1,:),'roi',roi);
snpmiH12F12      = snpm2.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results')
disp( snpmiH12F12 )

%% Test Men 12 vs Women 6kg

%(1) Conduct non-parametric test:
rng(0)
alpha      = 0.0083;
two_tailed = true;
iterations = min([1000, 2^npergroup]);
snpm5       = spm1d.stats.nonparam.ttest2(Y(A==0&B==1,:), Y(A==1&B==0,:),'roi',roi);
snpmiH12F6      = snpm5.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results')
disp( snpmiH12F6 )

%% Test Men 6 vs Women 12kg

%(1) Conduct non-parametric test:
rng(0)
alpha      = 0.0083;
two_tailed = true;
iterations = min([1000, 2^npergroup]);
snpm6       = spm1d.stats.nonparam.ttest2(Y(A==0&B==0,:), Y(A==1&B==1,:),'roi',roi);
snpmiH6F12      = snpm6.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results')
disp( snpmiH6F12 )

%% Test Women 6kg vs Women 12kg

%(1) Conduct non-parametric test:
rng(0)
alpha      = 0.0083;
two_tailed = true;
iterations = min([1000, 2^npergroup]);
snpm3       = spm1d.stats.nonparam.ttest_paired(Y(A==1&B==0,:), Y(A==1&B==1,:));
snpmiF6F12      = snpm3.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results')
disp( snpmiF6F12 )

%% Test Men 6kg vs Men 12kg

%(1) Conduct non-parametric test:
rng(0)
alpha      = 0.0083;
two_tailed = true;
iterations = min([1000, 2^npergroup]);
snpm4       = spm1d.stats.nonparam.ttest_paired(Y(A==0&B==0,:), Y(A==0&B==1,:));
snpmiH6H12      = snpm4.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results')
disp( snpmiH6H12 )


%
% 
% %% Plot results
% close all
% subplot(3,2,1)
% title([Signal, ': ', CondH{1}, 'vs ', CondF{1}])
% hold on
% plot(H1','b')
% plot(mean(H1),'b','linewidth',4)
% plot(F1','r')
% plot(mean(H1),'b','linewidth',4)
% plot(mean(F1),'r','linewidth',4)
% for icluster=1:length(snpmi1.clusters)
%     plot(snpmi1.clusters{icluster}.endpoints,[0 0],'k','linewidth', 3)
% end
% 
% subplot(3,2,2)
% title([Signal, ': ', CondH{2}, 'vs ', CondF{2}])
% hold on
% plot(H2','c')
% plot(F2','m')
% plot(mean(H2),'c','linewidth',4)
% plot(mean(F2),'m','linewidth',4)
% for icluster=1:length(snpmi2.clusters)
%     plot(snpmi2.clusters{icluster}.endpoints,[0 0],'k','linewidth', 3)
% end
% 
% subplot(3,2,3)
% title([Signal, ': ', CondF{1}, 'vs ', CondH{2}])
% hold on
% plot(F1','r')
% plot(H2','c')
% plot(mean(F1),'r','linewidth',4)
% plot(mean(H2),'c','linewidth',4)
% for icluster=1:length(snpmi5.clusters)
%     plot(snpmi5.clusters{icluster}.endpoints,[0 0],'k','linewidth', 3)
% end
% 
% subplot(3,2,4)
% title([Signal, ': ', CondH{1}, 'vs ', CondF{2}])
% hold on
% plot(H1','b')
% plot(F2','m')
% plot(mean(H1),'b','linewidth',4)
% plot(mean(F2),'m','linewidth',4)
% for icluster=1:length(snpmi6.clusters)
%     plot(snpmi6.clusters{icluster}.endpoints,[0 0],'k','linewidth', 3)
% end
% 
% 
% 
% subplot(3,2,5)
% title([Signal, ': ', CondF{1}, 'vs ', CondF{2}])
% hold on
% plot(F1','r')
% plot(F2','m')
% plot(mean(F1),'r','linewidth',4)
% plot(mean(F2),'m','linewidth',4)
% for icluster=1:length(snpmi3.clusters)
%     plot(snpmi3.clusters{icluster}.endpoints,[0 0],'k','linewidth', 3)
% end
% 
% subplot(3,2,6)
% title([Signal, ': ', CondH{1}, 'vs ', CondH{2}])
% hold on
% plot(H1','b')
% plot(H2','c')
% plot(mean(H1),'b','linewidth',4)
% plot(mean(H2),'c','linewidth',4)
% for icluster=1:length(snpmi4.clusters)
%     plot(snpmi4.clusters{icluster}.endpoints,[0 0],'k','linewidth', 3)
% end
% 
