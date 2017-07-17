%% SPM: Repeated measure ANOVA 3 way, 2 RM. Y is MuscleFocus
clearvars -except MuscleFocus
Signal='MFBlache';

CondH={'H6H2', 'H12H2'};%, 'H6H2', 'H6H3', 'H6H4', 'H6H5', 'H6H6',...
    %'H12H1', 'H12H2', 'H12H3', 'H12H4', 'H12H5', 'H12H6'};

CondF={'F6H2', 'F12H2'};% 'F6H2', 'F6H3', 'F6H4', 'F6H5', 'F6H6',...
   % 'F12H1', 'F12H2', 'F12H3', 'F12H4', 'F12H5', 'F12H6'};

for icond =1:length(CondH)
    dataH(:,:,icond)=squeeze(nanmean(MuscleFocus.(Signal).(CondH{icond})(:,:,:),2));
    dataF(:,:,icond)=squeeze(nanmean(MuscleFocus.(Signal).(CondF{icond})(:,:,:),2));
end

sujetH=find(sum(isnan(dataH(1,:,:)),3)==0);
sujetF=find(sum(isnan(dataF(1,:,:)),3)==0);
npergroup=min([length(sujetH), length(sujetF)]);

SUBJ=repmat(1:2*npergroup,1,2);

Y=[];
for icond= 1:length(CondH)
    Y=[Y; dataH(:,sujetH(1:npergroup),icond)'; dataF(:,sujetF(1:npergroup),icond)'];
end
    
A=[repmat(0,1,npergroup), repmat(1,1,npergroup)];
A=repmat(A,1,2);

B=[repmat(0,1,npergroup*2), repmat(1,1,npergroup*2)];

%(1) Conduct non-parametric test:
rng(0)     %set the random number generator seed
alpha      = 0.05;
iterations = 500;
FFn        = spm1d.stats.nonparam.anova2onerm(Y, A, B, SUBJ);
FFni       = FFn.inference(alpha, 'iterations', iterations);
disp_summ(FFni)



%(2) Plot:
close all;
FFni.plot('plot_threshold_label',true, 'plot_p_values',true, 'autoset_ylim',true);
% FFi        = spm1d.stats.anova2onerm(Y, A, B, SUBJ).inference(alpha);
% %%% compare to parametric results by plotting the parametric thresholds:
% for i = 1:FFi.nEffects
%     Fi = FFi(i);
%     subplot(2,2,i);
%     hold on
%     plot([0 numel(Fi.z)], Fi.zstar*[1 1], 'color','c', 'linestyle','--')
%     hold off
%     text(5, Fi.zstar, 'Parametric', 'color','k', 'backgroundcolor','c')
% end
% 
% subplot(2,2,1)
% xlabel(['nH = ', num2str(length(sujetH)), ' nF =', num2str(length(sujetF)), ' Muscle: ', Signal]);
% 
% 
