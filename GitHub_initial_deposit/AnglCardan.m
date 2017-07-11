function [Alpha, Beta, Gamma] = AnglCardan(M);

%% alpah, beta et gamma sont les angles de cardans qui décrivent les
%% mouvements de flexion-extension, abduction-adduction et rotation médiolatérale

%% Selon le modèle d'Hatze les repères locaux sont de la forme :
        % X axe médiolatéral (axe de la flexion-extension);
        % Y axe antéropostérieur (axe de l'adduction-abduction);
        % Z selon la longueur du segment (axe de rotation médiolatérale);

%% Selon la séquence proposée par l'ISB on aura des rotations : XYZ
        
%% M est une matrice (4,4,n); chaque feuille est de la forme [R T; 0 0 0 1];
%% M est une matrice (3,3,n)

[n,p,q] = size(M);
if n==4 & p==4; M = M(1:3,1:3,:); end % conserver uniquement la matrice de rotation
% Méthode proposée par Roberson et Schwertossek (88) Dynamics of multibody systems
Beta  = atan2(M(1,3,:), sqrt( M(2,3,:).^2+M(3,3,:).^2));
Alpha = atan2(-M(2,3,:),M(3,3,:));
Gamma = atan2(-M(1,2,:),M(1,1,:));

Alpha = unwrap(squeeze(Alpha));
Beta  = unwrap(squeeze(Beta));
Gamma = unwrap(squeeze(Gamma));

if nargout==1; Alpha = [Alpha Beta Gamma]; end

