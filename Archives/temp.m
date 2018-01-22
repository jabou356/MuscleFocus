Chan=[1,3;2,2;3,1;4,10;5,9;6,11;7,13;8,12];
spmEMG.emg=spmEMG.emg';

for i=1:8
	spmMuscleFocus.denominator(:,i:8:size(spmMuscleDir.dInt,3)-8+i) = spmEMG.emg(:,Chan(i,2):13:size(spmEMG.emg,2)-13+Chan(i,2));
	
	spmMuscleFocus.numerator(:,1,i:8:size(spmMuscleDir.dInt,3)-8+i) = spmEMG.emg(:,Chan(i,2):13:size(spmEMG.emg,2)-13+Chan(i,2)).* squeeze(spmMuscleDir.dInt(:,1,Chan(i,1):8:size(spmMuscleDir.dInt,3)-8+Chan(i,1)));
	spmMuscleFocus.numerator(:,2,i:8:size(spmMuscleDir.dInt,3)-8+i) = spmEMG.emg(:,Chan(i,2):13:size(spmEMG.emg,2)-13+Chan(i,2)).* squeeze(spmMuscleDir.dInt(:,2,Chan(i,1):8:size(spmMuscleDir.dInt,3)-8+Chan(i,1)));
	
	spmMuscleFocus.numerator(:,3,i:8:size(spmMuscleDir.dInt,3)-8+i) = spmEMG.emg(:,Chan(i,2):13:size(spmEMG.emg,2)-13+Chan(i,2)).* squeeze(spmMuscleDir.dInt(:,3,Chan(i,1):8:size(spmMuscleDir.dInt,3)-8+Chan(i,1)));
	
	
end

k=0;
for i=1:8:size(spmMuscleFocus.denominator,2)
	k=k+1;
	
	spmMuscleFocus.DENOMINATORblache(:,k) = sum(spmMuscleFocus.denominator(:,i+[1:3 7:8]-1),2);
	spmMuscleFocus.vecNUMERATORblache(:,:,k) = sum(spmMuscleFocus.numerator(:,:,i+[1:3 7:8]-1),3);
	spmMuscleFocus.NUMERATORblache(:,k) = sqrt(sum(spmMuscleFocus.vecNUMERATORblache(:,:,k).^2,2));
	spmMuscleFocus.MUSCLEFOCUSblache(:,k) = spmMuscleFocus.NUMERATORblache(:,k)./spmMuscleFocus.DENOMINATORblache(:,k);
	
	spmMuscleFocus.DENOMINATORall(:,k) = sum(spmMuscleFocus.denominator(:,i:i+7),2);
	spmMuscleFocus.vecNUMERATORall(:,:,k) = sum(spmMuscleFocus.numerator(:,:,i:i+7),3);
	spmMuscleFocus.NUMERATORall(:,:,k) = sqrt(sum(spmMuscleFocus.vecNUMERATORall(:,:,k).^2,2));
	spmMuscleFocus.MUSCLEFOCUSall(:,k) = spmMuscleFocus.NUMERATORall(:,k)./spmMuscleFocus.DENOMINATORall(:,k);
	
	spmMuscleFocus.DENOMINATORdelt(:,k) = sum(spmMuscleFocus.denominator(:,i+[1:3]-1),2);
	spmMuscleFocus.vecNUMERATORdelt(:,:,k) = sum(spmMuscleFocus.numerator(:,:,i+[1:3]-1),3);
	spmMuscleFocus.NUMERATORdelt(:,k) = sqrt(sum(spmMuscleFocus.vecNUMERATORdelt(:,:,k).^2,2));
	spmMuscleFocus.MUSCLEFOCUSdelt(:,k) = spmMuscleFocus.NUMERATORdelt(:,k)./spmMuscleFocus.DENOMINATORdelt(:,k);
	
end


spmMuscleFocus.sex=spmEMG.sex;
spmMuscleFocus.height=spmEMG.height;
spmMuscleFocus.weight=spmEMG.weight;
spmMuscleFocus.nsubject=spmEMG.nsubject;


trials=find(spmMuscleFocus.sex==1 & spmMuscleFocus.weight==1 & spmMuscleFocus.height==1);

for itrial=1:3:length(trials)-2
	clf
	subplot(3,1,1)
	plot(spmMuscleFocus.NUMERATORblache(:,trials(itrial):trials(itrial)+2))
	hold on
	
	subplot(3,1,2)
		plot(spmMuscleFocus.DENOMINATORblache(:,trials(itrial):trials(itrial)+2))
		hold on
		
		subplot(3,1,3)
			plot(spmMuscleFocus.MUSCLEFOCUSblache(:,trials(itrial):trials(itrial)+2))
			hold on
			title(num2str(itrial))
			waitforbuttonpress
end
clf
subplot(3,1,1)
	plot(nanmean(spmMuscleFocus.NUMERATORblache(:,trials),2))
	hold on
	
	subplot(3,1,2)
		plot(nanmean(spmMuscleFocus.DENOMINATORblache(:,trials),2))
		hold on
		
		subplot(3,1,3)
			plot(nanmean(spmMuscleFocus.MUSCLEFOCUSblache(:,trials),2))
			hold on
			title(num2str(itrial))
			waitforbuttonpress

for i=1:8:12000
	
	clf
	plot3([0 spmMuscleDir.dInt(1,1,i)],[0 spmMuscleDir.dInt(1,2,i)],[0 spmMuscleDir.dInt(1,3,i)],'b')
	hold on
		plot3([0 spmMuscleDir.dInt(1,1,i+1)],[0 spmMuscleDir.dInt(1,2,i+1)],[0 spmMuscleDir.dInt(1,3,i+1)],'k')
			plot3([0 spmMuscleDir.dInt(1,1,i+2)],[0 spmMuscleDir.dInt(1,2,i+2)],[0 spmMuscleDir.dInt(1,3,i+2)],'c')
		plot3([0 spmMuscleDir.dInt(1,1,i+6)],[0 spmMuscleDir.dInt(1,2,i+6)],[0 spmMuscleDir.dInt(1,3,i+6)],'m')
	plot3([0 spmMuscleDir.dInt(1,1,i+7)],[0 spmMuscleDir.dInt(1,2,i+7)],[0 spmMuscleDir.dInt(1,3,i+7)],'r')
	xlabel('X Abduction')
	ylabel('Y Rotation')
	zlabel('Z Flexion')
	view(0,0)
	axis([-1 1 -1 1 -1 1])
	drawnow

end

trials=find(spmMuscleFocus.sex==1 & spmMuscleFocus.weight==1 & spmMuscleFocus.height==1);

for itrial=1:3:length(trials)-2
	clf
	subplot(4,1,1)
	plot(spmMuscleFocus.NUMERATORblache(:,trials(itrial):trials(itrial)+2))
	hold on
	
	subplot(4,1,2)
		plot(spmMuscleFocus.DENOMINATORblache(:,trials(itrial):trials(itrial)+2))
		hold on
		
		subplot(4,1,3)
			plot(spmMuscleFocus.MUSCLEFOCUSblache(:,trials(itrial):trials(itrial)+2))
			hold on
			title(num2str(itrial))
			


	
	subplot(4,1,4)
	plot(nanmean(spmEMG.emg(:,[trials(itrial)*13+Chan(1,2)-13 trials(itrial+1)*13+Chan(1,2)-13 trials(itrial+2)*13+Chan(1,2)-13]),2),'b')
	hold on
	plot(nanmean(spmEMG.emg(:,[trials(itrial)*13+Chan(2,2)-13 trials(itrial+1)*13+Chan(2,2)-13 trials(itrial+2)*13+Chan(2,2)-13]),2),'k')
	plot(nanmean(spmEMG.emg(:,[trials(itrial)*13+Chan(3,2)-13 trials(itrial+1)*13+Chan(3,2)-13 trials(itrial+2)*13+Chan(3,2)-13]),2),'c')
	plot(nanmean(spmEMG.emg(:,[trials(itrial)*13+Chan(7,2)-13 trials(itrial+1)*13+Chan(7,2)-13 trials(itrial+2)*13+Chan(7,2)-13]),2),'r')
	plot(nanmean(spmEMG.emg(:,[trials(itrial)*13+Chan(8,2)-13 trials(itrial+1)*13+Chan(8,2)-13 trials(itrial+2)*13+Chan(8,2)-13]),2),'m')

	
	

waitforbuttonpress
end

	


