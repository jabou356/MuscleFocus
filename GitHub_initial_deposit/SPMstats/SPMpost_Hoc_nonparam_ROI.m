
npergroup=length(A)/4;
%% Test Men vs Women 6kg
if FFni.SPMs{1,3}.h0reject  
for icluster=1:length(FFni.SPMs{1,3}.clusters)
   
endpoint=FFni.SPMs{3}.clusters{1,icluster}.endpoints;
    



%(1) Conduct non-parametric test:
rng(0)
alpha      = 0.0083;
two_tailed = true;
iterations = min([1000, 2^npergroup]);
snpm1       = spm1d.stats.nonparam.ttest2(Y(A==0&B==0,endpoint(1):endpoint(2)), Y(A==1&B==0,endpoint(1):endpoint(2)));
snpmiH6F6{icluster} = snpm1.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results')
disp( snpmiH6F6 )

%% Test Men vs Women 12kg

%(1) Conduct non-parametric test:
rng(0)
alpha      = 0.0083;
two_tailed = true;
iterations = min([1000, 2^npergroup]);
snpm2       = spm1d.stats.nonparam.ttest2(Y(A==0&B==1,endpoint(1):endpoint(2)), Y(A==1&B==1,endpoint(1):endpoint(2)));
snpmiH12F12{icluster}      = snpm2.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results')
disp( snpmiH12F12 )

%% Test Men 12 vs Women 6kg

%(1) Conduct non-parametric test:
rng(0)
alpha      = 0.0083;
two_tailed = true;
iterations = min([1000, 2^npergroup]);
snpm5       = spm1d.stats.nonparam.ttest2(Y(A==0&B==1,endpoint(1):endpoint(2)), Y(A==1&B==0,endpoint(1):endpoint(2)));
snpmiH12F6{icluster}      = snpm5.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results')
disp( snpmiH12F6 )

%% Test Men 6 vs Women 12kg

%(1) Conduct non-parametric test:
rng(0)
alpha      = 0.0083;
two_tailed = true;
iterations = min([1000, 2^npergroup]);
snpm6       = spm1d.stats.nonparam.ttest2(Y(A==0&B==0,endpoint(1):endpoint(2)), Y(A==1&B==1,endpoint(1):endpoint(2)));
snpmiH6F12{icluster}      = snpm6.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results')
disp( snpmiH6F12 )

%% Test Women 6kg vs Women 12kg

%(1) Conduct non-parametric test:
rng(0)
alpha      = 0.0083;
two_tailed = true;
iterations = min([1000, 2^npergroup]);
snpm3       = spm1d.stats.nonparam.ttest_paired(Y(A==1&B==0,endpoint(1):endpoint(2)), Y(A==1&B==1,endpoint(1):endpoint(2)));
snpmiF6F12{icluster}      = snpm3.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results')
disp( snpmiF6F12 )

%% Test Men 6kg vs Men 12kg

%(1) Conduct non-parametric test:
rng(0)
alpha      = 0.0083;
two_tailed = true;
iterations = min([1000, 2^npergroup]);
snpm4       = spm1d.stats.nonparam.ttest_paired(Y(A==0&B==0,endpoint(1):endpoint(2)), Y(A==0&B==1,endpoint(1):endpoint(2)));
snpmiH6H12{icluster}      = snpm4.inference(alpha, 'two_tailed', two_tailed, 'iterations', iterations);
disp('Non-Parametric results')
disp( snpmiH6H12 )

end
end

