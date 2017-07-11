function [vecDirNorm,distance] = projPointOrth(Orig,vecDir,point)

% function that calculate the vector orthogonal to a line (D) and crossing a point (M0)
% inputs :      - Orig = point which belongs to (D)
%               - vecDir = unit vector director of the line (D)
%               - point = point crossed by the vector orthogonal (M0)
% outputs :     - vecDirNorm = unit vector in direction to the line (D)
%               - distance = distance between the point M0 and the line (D)



% Orig = [3 1 2;3 2 5];
% point = [2 3 4; 2 6 3];
% vecDir = [1 2 1; 4 5 6];

vectOrigPoint = point - Orig;

k = (vecDir(:,1) .* vectOrigPoint(:,1) + vecDir(:,2) .* vectOrigPoint(:,2)+ vecDir(:,3) .* vectOrigPoint(:,3) ) ...
    ./ (vecDir(:,1).^2 + vecDir(:,2).^2 + vecDir(:,3).^2);


projCoordinates = [k.*vecDir(:,1)+ Orig(:,1) , ...
                   k.*vecDir(:,2)+ Orig(:,2) , ... 
                   k.*vecDir(:,3)+ Orig(:,3)];
               
vecDir = projCoordinates-point;
vecDirNorm = vecDir./repmat(sqrt(vecDir(:,1).^2 + vecDir(:,2).^2 + vecDir(:,3).^2),1,size(vecDir,2));
distance = sqrt(vecDir(:,1).^2 + vecDir(:,2).^2 + vecDir(:,3).^2);


