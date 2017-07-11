function data = emg_compute(MVC,data,freq)
%% parameters
param.bandfilter = [10,425]; % lower and upper freq
param.lowfilter = 5;
param.RMSwindow = 250 * freq.emg / 1000 ;
if mod(param.RMSwindow,2)==0 %if bin length is an even number
    param.RMSwindow=param.RMSwindow+1;
end

param.nbframe = 4000; % number frame needed (interpolation)

%% treatment
for itrial = length(data):-1:1
    emg = data(itrial).emg;
    emg=emg;
    
    % 1) Rebase
    emg = emg - repmat(mean(emg),size(emg,1),1);
    
    % 2) band-pass filter
    [b, a]=butter(2, [10/(freq.emg/2) 425/(freq.emg/2)]);
    for imuscle=1:size(data(itrial).emg,2)
        emg(:,imuscle)=filtfilt(b,a,emg(:,imuscle));
    end
    
    %% method lp
    %) 3) signal rectification
    emg = abs(emg);
    
    %     % 4) low pass filter at 5Hz
    %     emg = lpfilter(emg, param.lowfilter, freq.emg);
    %
    % %% method rms
    % 3) RMS
    
    temp=mean(emg(1:param.RMSwindow,:),1);
    RMS(1:floor(param.RMSwindow/2),:)=repmat(temp,floor(param.RMSwindow/2),1);
    temp=mean(emg(end-param.RMSwindow+1:end,:),1);
    RMS(ceil(length(emg)-param.RMSwindow/2)+1:length(emg),:)=repmat(temp,floor(param.RMSwindow/2),1);
    
    for i=ceil(param.RMSwindow/2):ceil(length(emg)-param.RMSwindow/2)
        RMS(i,:)=mean(emg(ceil(i-param.RMSwindow/2):floor(i+param.RMSwindow/2),:),1);
    end
    emg=RMS;
    
    % 5) Normalization
    emg = emg ./ (repmat(MVC/100,size(emg,1),1));
    
    % 6) slice trial with force onset/offset
    debut = (data(itrial).start*freq.emg)/freq.camera;
    fin = (data(itrial).end*freq.emg)/freq.camera;
    emg = emg(floor(debut):floor(fin),:);
    
    % 7) interpolation
    emg = ScaleTime(emg, 1, length(emg), param.nbframe);
    
    data(itrial).emg = emg;
    


    clearvars emg RMS 
end


