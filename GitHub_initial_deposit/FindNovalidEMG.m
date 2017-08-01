muscle={'DeltA', 'DeltM', 'DeltP', 'BB', 'TB', 'UpTrap', 'LowTrap', 'SerrAnt'...
	, 'Supra', 'Infra', 'SubScap', 'Pect', 'Lat'};

condH={'H6H1', 'H6H2', 'H6H3', 'H6H4', 'H6H5', 'H6H6',...
	'H12H1', 'H12H2', 'H12H3', 'H12H4', 'H12H5', 'H12H6'...
	'H18H1', 'H18H2', 'H18H3', 'H18H4', 'H18H5', 'H18H6'};

condF={'F6H1', 'F6H2', 'F6H3', 'F6H4', 'F6H5', 'F6H6',...
	'F12H1', 'F12H2', 'F12H3', 'F12H4', 'F12H5', 'F12H6'};

for imuscle=1:length(muscle)
	EMG.(muscle{imuscle}).NoValidH=[];
	
	for icond= 1:length(condH)
		zeroEMG=find(EMG.(muscle{imuscle}).(condH{icond})==0);
		EMG.(muscle{imuscle}).(condH{icond})(zeroEMG)=nan;
		
		[rows, cols]=find(isnan(squeeze(EMG.(muscle{imuscle}).(condH{icond})(1,:,:))));
		novalid.(muscle{imuscle}).(condH{icond})=[rows,cols];
	end
	
	for icond= 1:length(condF)
		zeroEMG=find(EMG.(muscle{imuscle}).(condF{icond})==0);
		EMG.(muscle{imuscle}).(condF{icond})(zeroEMG)=nan;
		
		[rows, cols]=find(isnan(squeeze(EMG.(muscle{imuscle}).(condF{icond})(1,:,:))));
		novalid.(muscle{imuscle}).(condF{icond})=[rows,cols];
	end
end

xlswrite('E:\Projet_IRSST_LeverCaisse\ElaboratedData\GroupJB\NoValidEMG.xlsx',EMG.Hname,1,'B1');
xlswrite('E:\Projet_IRSST_LeverCaisse\ElaboratedData\GroupJB\NoValidEMG.xlsx',EMG.Fname,2,'B1');

xlswrite('E:\Projet_IRSST_LeverCaisse\ElaboratedData\GroupJB\NoValidEMG.xlsx',muscle',1,'A2');
xlswrite('E:\Projet_IRSST_LeverCaisse\ElaboratedData\GroupJB\NoValidEMG.xlsx',muscle',2,'A2');

for isubject=1:length(EMG.Hname)
	for imuscle = 1:length(muscle)
		notvalid=[];
		for icond=1:length(condH)
			notvalid=[notvalid;find(novalid.(muscle{imuscle}).(condH{icond})(:,2)==isubject)];
		end
		
		xlswrite('E:\Projet_IRSST_LeverCaisse\ElaboratedData\GroupJB\NoValidEMG.xlsx',length(notvalid),1,[char(ExcelCol(isubject+1)), char(num2str(imuscle+1))]);

	end
end

for isubject=1:length(EMG.Fname)
	for imuscle = 1:length(muscle)
		notvalid=[];
		for icond=1:length(condF)
			notvalid=[notvalid;find(novalid.(muscle{imuscle}).(condF{icond})(:,2)==isubject)];
		end
		
		xlswrite('E:\Projet_IRSST_LeverCaisse\ElaboratedData\GroupJB\NoValidEMG.xlsx',length(notvalid),2,[char(ExcelCol(isubject+1)), char(num2str(imuscle+1))]);

	end
end
