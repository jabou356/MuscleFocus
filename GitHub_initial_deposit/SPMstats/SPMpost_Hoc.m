clearvars -except MuscleFocus
Signal='DENOMINATORallmuscles';

CondH={'H6H2', 'H12H2'};%, 'H6H2', 'H6H3', 'H6H4', 'H6H5', 'H6H6',...
    %'H12H1', 'H12H2', 'H12H3', 'H12H4', 'H12H5', 'H12H6'};

CondF={'F6H2', 'F12H2'};% 'F6H2', 'F6H3', 'F6H4', 'F6H5', 'F6H6',...
   % 'F12H1', 'F12H2', 'F12H3', 'F12H4', 'F12H5', 'F12H6'};
   
%% Subjects used in the ANOVa


for icond =1:length(CondH)
    dataH(:,:,icond)=squeeze(nanmean(MuscleFocus.(Signal).(CondH{icond})(:,:,:),2));
    dataF(:,:,icond)=squeeze(nanmean(MuscleFocus.(Signal).(CondF{icond})(:,:,:),2));
end

sujetH=find(sum(isnan(dataH(1,:,:)),3)==0);
sujetF=find(sum(isnan(dataF(1,:,:)),3)==0);
npergroup=min([length(sujetH), length(sujetF)]);

H1=squeeze(nanmean(MuscleFocus.(Signal).(CondH{1})(:,:,sujetH(1:npergroup)),2))';
H2=squeeze(nanmean(MuscleFocus.(Signal).(CondH{2})(:,:,sujetH(1:npergroup)),2))';
F1=squeeze(nanmean(MuscleFocus.(Signal).(CondF{1})(:,:,sujetF(1:npergroup)),2))';
F2=squeeze(nanmean(MuscleFocus.(Signal).(CondF{2})(:,:,sujetF(1:npergroup)),2))';

%% Test Men vs Women 6kg

%(1) Conduct non-parametric test:
rng(0)
alpha      = 0.05;
two_tailed = true;
iterations = min([1000, 2^npergroup]);
snpm1       = spm1d.stats.nonparam.ttest2(H1, F1);
snpmi1      = snpm1.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results')
disp( snpmi1 )

%% Test Men vs Women 12kg

%(1) Conduct non-parametric test:
rng(0)
alpha      = 0.05;
two_tailed = true;
iterations = min([1000, 2^npergroup]);
snpm2       = spm1d.stats.nonparam.ttest2(H2, F2);
snpmi2      = snpm2.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results')
disp( snpmi2 )

%% Test Men 12 vs Women 6kg

%(1) Conduct non-parametric test:
rng(0)
alpha      = 0.05;
two_tailed = true;
iterations = min([1000, 2^npergroup]);
snpm5       = spm1d.stats.nonparam.ttest2(H2, F1);
snpmi5      = snpm5.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results')
disp( snpmi5 )

%% Test Men 6 vs Women 12kg

%(1) Conduct non-parametric test:
rng(0)
alpha      = 0.05;
two_tailed = true;
iterations = min([1000, 2^npergroup]);
snpm6       = spm1d.stats.nonparam.ttest2(H1, F2);
snpmi6      = snpm6.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results')
disp( snpmi6 )

%% Test Women 6kg vs Women 12kg

%(1) Conduct non-parametric test:
rng(0)
alpha      = 0.05;
two_tailed = true;
iterations = min([1000, 2^npergroup]);
snpm3       = spm1d.stats.nonparam.ttest_paired(F1, F2);
snpmi3      = snpm3.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results')
disp( snpmi3 )

%% Test Men 6kg vs Men 12kg

%(1) Conduct non-parametric test:
rng(0)
alpha      = 0.05;
two_tailed = true;
iterations = min([1000, 2^npergroup]);
snpm4       = spm1d.stats.nonparam.ttest_paired(H1, H2);
snpmi4      = snpm4.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results')
disp( snpmi4 )
% 

%% Plot results
close all
subplot(3,2,1)
title([Signal, ': ', CondH{1}, 'vs ', CondF{1}])
hold on
plot(H1','b')
plot(mean(H1),'b','linewidth',4)
plot(F1','r')
plot(mean(H1),'b','linewidth',4)
plot(mean(F1),'r','linewidth',4)
for icluster=1:length(snpmi1.clusters)
    plot(snpmi1.clusters{icluster}.endpoints,[0 0],'k','linewidth', 3)
end

subplot(3,2,2)
title([Signal, ': ', CondH{2}, 'vs ', CondF{2}])
hold on
plot(H2','c')
plot(F2','m')
plot(mean(H2),'c','linewidth',4)
plot(mean(F2),'m','linewidth',4)
for icluster=1:length(snpmi2.clusters)
    plot(snpmi2.clusters{icluster}.endpoints,[0 0],'k','linewidth', 3)
end

subplot(3,2,3)
title([Signal, ': ', CondF{1}, 'vs ', CondH{2}])
hold on
plot(F1','r')
plot(H2','c')
plot(mean(F1),'r','linewidth',4)
plot(mean(H2),'c','linewidth',4)
for icluster=1:length(snpmi5.clusters)
    plot(snpmi5.clusters{icluster}.endpoints,[0 0],'k','linewidth', 3)
end

subplot(3,2,4)
title([Signal, ': ', CondH{1}, 'vs ', CondF{2}])
hold on
plot(H1','b')
plot(F2','m')
plot(mean(H1),'b','linewidth',4)
plot(mean(F2),'m','linewidth',4)
for icluster=1:length(snpmi6.clusters)
    plot(snpmi6.clusters{icluster}.endpoints,[0 0],'k','linewidth', 3)
end



subplot(3,2,5)
title([Signal, ': ', CondF{1}, 'vs ', CondF{2}])
hold on
plot(F1','r')
plot(F2','m')
plot(mean(F1),'r','linewidth',4)
plot(mean(F2),'m','linewidth',4)
for icluster=1:length(snpmi3.clusters)
    plot(snpmi3.clusters{icluster}.endpoints,[0 0],'k','linewidth', 3)
end

subplot(3,2,6)
title([Signal, ': ', CondH{1}, 'vs ', CondH{2}])
hold on
plot(H1','b')
plot(H2','c')
plot(mean(H1),'b','linewidth',4)
plot(mean(H2),'c','linewidth',4)
for icluster=1:length(snpmi4.clusters)
    plot(snpmi4.clusters{icluster}.endpoints,[0 0],'k','linewidth', 3)
end

