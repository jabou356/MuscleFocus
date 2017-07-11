clear


import org.opensim.modeling.*

LocalCoordinate=[1,0,0;0,1,0;0,0,1];
GenericPath

Path.OpensimGenericModel=[Path.OpensimSetupJB,'NoConstrainStandfordVAtoAdapt.osim']
GenericModel=Model(Path.OpensimGenericModel);
MyJointSet=GenericModel.getJointSet;
MyMarkerSet=GenericModel.getMarkerSet;

%% Clavicle location SC: orientation OK
CLAV_SC_thorax=MyMarkerSet.get('CLAV_SC_thorax');
CLAV_SC=MyMarkerSet.get('CLAV_SC');
LocationInParent=CLAV_SC_thorax.getOffset;
LocationInChild=CLAV_SC.getOffset;

SCjoint=MyJointSet.get('sternoclavicular');
SCjointID=MyJointSet.getIndex('sternoclavicular');
SCjoint.setLocation(LocationInChild);
SCjoint.setLocationInParent(LocationInParent);

MyJointSet.set(SCjointID,SCjoint);
clear CLAV_SC CLAV_SC_thorax LocationInChild LocationInParent SCjoint SCjointID

%% Scapula Location AC: orientation TBD
%Extract markers position in parent and child reference system
SCAP_AA_clav = MyMarkerSet.get('SCAP_AA_clav'); SCAP_AA_clav = SCAP_AA_clav.getOffset;
SCAP_AA_clav = [SCAP_AA_clav.get(0), SCAP_AA_clav.get(1), SCAP_AA_clav.get(2)]; %pour pouvoir faire des opérations dans Matlab

SCAP_AA = MyMarkerSet.get('SCAP_AA'); SCAP_AA = SCAP_AA.getOffset;
SCAP_AA = [SCAP_AA.get(0), SCAP_AA.get(1), SCAP_AA.get(2)];

SCAP_IA_clav = MyMarkerSet.get('SCAP_IA_clav'); SCAP_IA_clav = SCAP_IA_clav.getOffset;
SCAP_IA_clav = [SCAP_IA_clav.get(0), SCAP_IA_clav.get(1), SCAP_IA_clav.get(2)];

SCAP_IA = MyMarkerSet.get('SCAP_IA'); SCAP_IA = SCAP_IA.getOffset;
SCAP_IA = [SCAP_IA.get(0), SCAP_IA.get(1), SCAP_IA.get(2)];

SCAP_RS_clav = MyMarkerSet.get('SCAP_RS_clav'); SCAP_RS_clav = SCAP_RS_clav.getOffset;
SCAP_RS_clav = [SCAP_RS_clav.get(0), SCAP_RS_clav.get(1), SCAP_RS_clav.get(2)];

SCAP_RS = MyMarkerSet.get('SCAP_RS'); SCAP_RS = SCAP_RS.getOffset;
SCAP_RS = [SCAP_RS.get(0), SCAP_RS.get(1), SCAP_RS.get(2)];

CLAV_AC = MyMarkerSet.get('CLAV_AC'); CLAV_AC = CLAV_AC.getOffset;
%CLAV_AC = [CLAV_AC.get(0), CLAV_AC.get(1), CLAV_AC.get(2)]; 

CLAV_AC_scap = MyMarkerSet.get('CLAV_AC_scap'); CLAV_AC_scap = CLAV_AC_scap.getOffset;
%CLAV_AC_scap = [CLAV_AC_scap.get(0), CLAV_AC_scap.get(1), CLAV_AC_scap.get(2)];


%Build RBDL joint coordinate system in the parent and child segments 
Zparent = SCAP_AA_clav-SCAP_RS_clav; Zparent = Zparent./norm(Zparent);
Zchild = SCAP_AA-SCAP_RS; Zchild = Zchild./norm(Zchild);
Xparent = cross(SCAP_IA_clav-SCAP_RS_clav,SCAP_IA_clav-SCAP_AA_clav); Xparent = Xparent./norm(Xparent);
Xchild = cross(SCAP_IA-SCAP_RS,SCAP_IA-SCAP_AA); Xchild = Xchild./norm(Xchild);
Yparent = cross(Zparent,Xparent);
Ychild = cross(Zchild,Xchild);

Oparent = CLAV_AC;
Ochild = CLAV_AC_scap;

%Compute rotation to needed match each segment CS to joint CS
Rparent=([Xparent;Yparent;Zparent]*LocalCoordinate');
Rchild=([Xchild;Ychild;Zchild]*LocalCoordinate');

XYZparent=AnglCardan(Rparent');
XYZparent=Vec3(XYZparent(1),XYZparent(2),XYZparent(3));
XYZchild=AnglCardan(Rchild');
XYZchild=Vec3(XYZchild(1),XYZchild(2),XYZchild(3));

%Update the joint CS
ACjoint=MyJointSet.get('acromioclavicular');
ACjointID=MyJointSet.getIndex('acromioclavicular');
ACjoint.setLocation(Ochild);
ACjoint.setLocationInParent(Oparent);
ACjoint.setOrientation(XYZchild);
ACjoint.setOrientationInParent(XYZparent);

%Update the joint set
MyJointSet.set(ACjointID,ACjoint);
clear CLAV_AC CLAV_AC_scap SCAP_AA_clav SCAP_AA SCAP_IA_clav SCAP_IA SCAP_RS_clav SCAP_RS Xchild Xparent Ychild Yparent Zchild Zparent Ochild Oparent XYZchild XYZparent Rchild Rparent ACjoint ACjointID 

%% Humerus Location AC+ 0.17*(mean([EL EM])-AC; Orientation TBD
CLAV_AC_humerus=MyMarkerSet.get('CLAV_AC_humerus'); CLAV_AC_humerus = CLAV_AC_humerus.getOffset;
CLAV_AC_humerus = [CLAV_AC_humerus.get(0), CLAV_AC_humerus.get(1), CLAV_AC_humerus.get(2)]; %pour pouvoir faire des opérations dans Matlab

CLAV_AC_scap=MyMarkerSet.get('CLAV_AC_scap');  CLAV_AC_scap = CLAV_AC_scap.getOffset;
CLAV_AC_scap = [CLAV_AC_scap.get(0), CLAV_AC_scap.get(1), CLAV_AC_scap.get(2)];

EPICl=MyMarkerSet.get('EPICl');  EPICl = EPICl.getOffset;
EPICl = [EPICl.get(0), EPICl.get(1), EPICl.get(2)];

EPICl_scap=MyMarkerSet.get('EPICl_scap');  EPICl_scap = EPICl_scap.getOffset;
EPICl_scap = [EPICl_scap.get(0), EPICl_scap.get(1), EPICl_scap.get(2)];

EPICm=MyMarkerSet.get('EPICm');  EPICm = EPICm.getOffset;
EPICm = [EPICm.get(0), EPICm.get(1), EPICm.get(2)];

EPICm_scap=MyMarkerSet.get('EPICm_scap'); EPICm_scap = EPICm_scap.getOffset;
EPICm_scap = [EPICm_scap.get(0), EPICm_scap.get(1), EPICm_scap.get(2)];

%Build RBDL joint coordinate system in the parent and child segments 
Yparent = CLAV_AC_scap-mean([EPICl_scap;EPICm_scap]); Yparent = Yparent./norm(Yparent);
Ychild = CLAV_AC_humerus-mean([EPICl;EPICm]); Ychild = Ychild./norm(Ychild);
Xparent = cross(EPICl_scap-CLAV_AC_scap,EPICm_scap-CLAV_AC_scap); Xparent = Xparent./norm(Xparent);
Xchild = cross(EPICl-CLAV_AC_humerus,EPICm-CLAV_AC_humerus); Xchild = Xchild./norm(Xchild);
Zparent = cross(Xparent,Yparent);
Zchild = cross(Xchild,Ychild);

Oparent=CLAV_AC_scap+0.17*(mean([EPICl_scap;EPICm_scap])-CLAV_AC_scap);
Ochild=CLAV_AC_humerus+0.17*(mean([EPICl;EPICm])-CLAV_AC_humerus);

Oparent=Vec3(Oparent(1),Oparent(2),Oparent(3));
Ochild=Vec3(Ochild(1),Ochild(2),Ochild(3));

%Compute rotation to match each segment CS to joint CS
Rparent=([Xparent;Yparent;Zparent]*LocalCoordinate');
Rchild=([Xchild;Ychild;Zchild]*LocalCoordinate');

XYZparent=AnglCardan(Rparent');
XYZparent=Vec3(XYZparent(1),XYZparent(2),XYZparent(3));
XYZchild=AnglCardan(Rchild');
XYZchild=Vec3(XYZchild(1),XYZchild(2),XYZchild(3));

GHjoint0=MyJointSet.get('shoulder0');
GHjoint0ID=MyJointSet.getIndex('shoulder0');
GHjoint0.setLocation(Ochild);
GHjoint0.setLocationInParent(Oparent);
GHjoint0.setOrientation(XYZchild);
GHjoint0.setOrientationInParent(XYZparent);

MyJointSet.set(GHjoint0ID,GHjoint0);

GHjoint1=MyJointSet.get('shoulder1');
GHjoint1ID=MyJointSet.getIndex('shoulder1');
GHjoint1.setLocation(Ochild);
GHjoint1.setLocationInParent(Ochild);
GHjoint1.setOrientation(XYZchild);
GHjoint1.setOrientationInParent(XYZchild);

MyJointSet.set(GHjoint1ID,GHjoint1);

GHjoint2=MyJointSet.get('shoulder2');
GHjoint2ID=MyJointSet.getIndex('shoulder2');
GHjoint2.setLocation(Ochild);
GHjoint2.setLocationInParent(Ochild);
GHjoint2.setOrientation(XYZchild);
GHjoint2.setOrientationInParent(XYZchild);

MyJointSet.set(GHjoint2ID,GHjoint2);

GenericModel.disownAllComponents();
GenericModel.print([Path.OpensimSetupJB, 'StandfordVACoRAnatoJB.osim']);

clear


