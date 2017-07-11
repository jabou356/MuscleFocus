%Show generic Geometry
clear;clc;clf

[fn,pn]=uigetfile('Go get your Subject Geometry')
load([pn,fn]);

[fn,pn]=uigetfile('Go get your Subject Geometry')
load([pn,fn]);

itrial=input('Which trial would you like to see')

while itrial>0


for itime=1:10:size(Data(itrial).vecDir,1)
    for i=1:length(SubjectPoly);
    plot3([SubjectPoints(SubjectPoly(i,1),1) SubjectPoints(SubjectPoly(i,2),1)],[SubjectPoints(SubjectPoly(i,1),2) SubjectPoints(SubjectPoly(i,2),2)],[SubjectPoints(SubjectPoly(i,1),3) SubjectPoints(SubjectPoly(i,2),3)],'k')
    hold on
    plot3([SubjectPoints(SubjectPoly(i,1),1) SubjectPoints(SubjectPoly(i,3),1)],[SubjectPoints(SubjectPoly(i,1),2) SubjectPoints(SubjectPoly(i,3),2)],[SubjectPoints(SubjectPoly(i,1),3) SubjectPoints(SubjectPoly(i,3),3)],'k')
    plot3([SubjectPoints(SubjectPoly(i,2),1) SubjectPoints(SubjectPoly(i,3),1)],[SubjectPoints(SubjectPoly(i,2),2) SubjectPoints(SubjectPoly(i,3),2)],[SubjectPoints(SubjectPoly(i,2),3) SubjectPoints(SubjectPoly(i,3),3)],'k')
end

    
    for imuscle=1:8
    plot3([Data(itrial).attach(itime,1,imuscle) Data(itrial).attach(itime,1,imuscle)+Data(itrial).vecDir(itime,1,imuscle)/10],[Data(itrial).attach(itime,2,imuscle) Data(itrial).attach(itime,2,imuscle)+Data(itrial).vecDir(itime,2,imuscle)/10],[Data(itrial).attach(itime,3,imuscle) Data(itrial).attach(itime,3,imuscle)+Data(itrial).vecDir(itime,3,imuscle)/10])
    
    
    end
    drawnow
    clf
end

itrial=input('Which trial would you like to see')
end