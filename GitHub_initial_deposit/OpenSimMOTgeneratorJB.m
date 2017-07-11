

for trial = 1 : length(Data)

%% Variables pour la crï¿½ation de fichiers OpenSim
    q = Data(trial).Qdata.Q2;
        
        %% Filtre passe-bas 15Hz
      for chan=1:size(q,1)
        NanQ=find(isnan(q(chan,:)));
        NoNanQ=find(isnan(q(chan,:))==0);
        if length(NanQ)>0
            for i=1:length(NanQ)
                nextvalid=find(NoNanQ>NanQ(i),1,'first');
        q(chan,NanQ(i))=q(chan,NoNanQ(nextvalid));
            end
        end
      end
        q = transpose(lpfilter(q', 15, 100));% vecteur temporel (s)
        
    
Data(trial).time      = linspace(0,(size(q,2)-1)/Alias.frequency,size(q,2));
    % # frame


confMot.header = {'time'} ;
OpenSimDoFname={'Th_rotX', 'Th_rotY', 'Th_rotZ', 'Th_transX', 'Th_transY', 'Th_transZ',...
    'Clav_rotZ_right', 'Clav_rotY_right', 'Clav_rotX_right'...
    'Scap_rotZ_right', 'Scap_rotY_right', 'Scap_rotX_right'...
    'Hum_rotZ_right', 'Hum_rotY_right', 'Hum_rotZZ_right'...
    'Elb_flex_right','Elb_ProSup_right', 'wrist_dev_r', 'wrist_flex_r'};

    confMot.header = [confMot.header OpenSimDoFname];


dataOrder=[10 11 12 7 8 9 13:18 22:28];


% for i=dataOrder([1:3 7:length(dataOrder)])
%     a=find(q(i,:)>pi);
%     b=find(q(i,:)<-pi);
%     
%     while length(a)+length(b)>0
%         if length(a)>0; q(i,a)=q(i,a)-2*pi; end
% if length(b)>0; q(i,b)=q(i,b)+2*pi; end
%     a=find(q(i,:)>pi);
%     b=find(q(i,:)<-pi);
%     end
% end
    
    Data(trial).motmat    = [Data(trial).time ; q(dataOrder,:)]';
Data(trial).motmat(:,[2:4 8:end])=Data(trial).motmat(:,[2:4 8:end])*180/pi; %Rad 2 degrees for joint angles

    % Matrice pour ï¿½criture fichier .mot

    % fonction permettant de gï¿½nï¿½rer le .trc
    
 
    
 fid   = fopen([Path.IKresultpath Data(trial).trialname '.mot'],'w+');
%% Écriture des headers
fprintf(fid, 'name %s\n', Data(trial).trialname);
fprintf(fid, 'datacolumns %d\n', length(dataOrder)+1);
fprintf(fid, 'datarows %d\n', size(Data(trial).Qdata.Q2,2));
fprintf(fid, 'range %f %f\n', min(Data(trial).time), max(Data(trial).time));
fprintf(fid, 'endheader\n');

for i=1:length(confMot.header)
	fprintf(fid, '%20s\t', confMot.header{i});
end
fprintf(fid, '\n');

fprintf(fid, [repmat('%f\t', 1, size(Data(trial).motmat(:,:), 2)) '\r\n'], Data(trial).motmat(:,:)');

fclose(fid);   

end
