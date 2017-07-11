% ----------------------------------------------------------------------- %
% The OpenSim API is a toolkit for musculoskeletal modeling and           %
% simulation. See http://opensim.stanford.edu and the NOTICE file         %
% for more information. OpenSim is developed at Stanford University       %
% and supported by the US National Institutes of Health (U54 GM072970,    %
% R24 HD065690) and by DARPA through the Warrior Web program.             %
%                                                                         %   
% Copyright (c) 2005-2012 Stanford University and the Authors             %
%                                                                         %   
% Licensed under the Apache License, Version 2.0 (the "License");         %
% you may not use this file except in compliance with the License.        %
% You may obtain a copy of the License at                                 %
% http://www.apache.org/licenses/LICENSE-2.0.                             %
%                                                                         % 
% Unless required by applicable law or agreed to in writing, software     %
% distributed under the License is distributed on an "AS IS" BASIS,       %
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or         %
% implied. See the License for the specific language governing            %
% permissions and limitations under the License.                          %
% ----------------------------------------------------------------------- %

% Pull in the modeling classes straight from the OpenSim distribution
import org.opensim.modeling.*


%% Get and operate on the files
model = Model([Path.ServerAddressE 'Projet_IRSST_LeverCaisse\Jason\StandfordVACoRAnatoJB.osim']);
model.initSystem();
model.LoadOpenSimLibrary('C:\OpenSim 3.3\plugins\MuscleForceDirection.dll')

analyzeTool = AnalyzeTool(Path.OpensimGenericMD);



% Tell Tool to use the loaded model
analyzeTool.setModel(model);

% get the file names that match the ik_reults convention
% this is where consistent naming conventions pay off
trialsForAn = dir([Path.IKresultpath '*.mot']);
nTrials =length(trialsForAn);

for trial= 1:nTrials
    % get the name of the file for this trial
    motIKCoordsFile = trialsForAn(trial).name;
    
    % create name of trial from .trc file name
    name = regexprep(motIKCoordsFile,'_ik.mot','');
    
    % get .mot data to determine time range
    motCoordsData = Storage([Path.IKresultpath motIKCoordsFile]);
    
    % for this example, column is time
    initial_time = motCoordsData.getFirstTime();
    final_time = motCoordsData.getLastTime();
    
    analyzeTool.setName(name);
    analyzeTool.setResultsDir(Path.MDresultpath);
    analyzeTool.setCoordinatesFileName([Path.IKresultpath motIKCoordsFile]);
    analyzeTool.setInitialTime(initial_time);
    analyzeTool.setFinalTime(final_time);   
    
    outfile = ['Setup_MDAnalyze_' name '.xml'];
    analyzeTool.print([Path.MDsetuppath outfile]);
    
    if final_time > 0
    analyzeTool.run();
    fprintf(['Performing MD on cycle # ' num2str(trial) '\n']);
    
    
    % rename the out.log so that it doesn't get overwritten
    %copyfile('out.log',[Path.MDpath name '_out.log'])
    end
    
end

model.disownAllComponents();
clear model analyzeTool initial_time final_time outfile motIKCoordsFile name
%sendmail(mail,subjectNumber, ['Hello! Analysis for ' subjectNumber '  is complete']);

