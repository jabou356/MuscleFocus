%This function scale humerus to participants' size
import org.opensim.modeling.*

GenericPath

%% Nom des sujets
Alias.sujet = sujets_validesJB(Path.ServerAddressE);

genericHumpath='E:\Projet_IRSST_LeverCaisse\Jason\OpenSimSetUpFiles\humerus.vtp'

GenHumerus=importdata(genericHumpath);

PointRange=350:688;
PolyRange=693:1367;

GenPoints=cell2mat(GenHumerus(PointRange));
GenPoints=str2num(GenPoints);

for i=1:length(PolyRange)
temp=cell2mat(GenHumerus(PolyRange(i)));
GenPoly(i,:)=str2num(temp);
end
GenPoly=GenPoly+1;


for isujet=length(Alias.sujet):-1:1
SubjectPath

MyScaleSet=ScaleSet([Path.exportPath Alias.sujet{isujet} 'ScaleSet.xml']);
Hum=MyScaleSet.get(7);
HumFactor=Hum.getScaleFactors;
HumFactor=HumFactor.get(0);

SubjectPoints=GenPoints*HumFactor;
SubjectPoly=GenPoly;

Path.SubjectGeometry=[Path.exportPath,Alias.sujet{isujet},'HumGeometry.mat'];
save(Path.SubjectGeometry, 'SubjectPoints', 'SubjectPoly', 'GenPoints', 'GenPoly');
clear SubjectPoints SubjectPoly HumFactor Hum MyScaleSet
end



