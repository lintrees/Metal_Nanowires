%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This program is used to draw the charge distributions 
% and save them as ps file.
%
%      Won Park nanophtonic group
%      ECEE at Colorado University
% 
%  Author: Jianhong Zhou
%          zhoujianhong@gmail.com
%
% File name: DrawChargeDistribution.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

eb = 1.42; % The back gound dielectric function
for MN = 1
mm=V(:,MN)./TPA(:,4);

trisurf(Index+ones(length(Index),3),...
        Coordinate(:,1),Coordinate(:,2),...
        Coordinate(:,3),sign(mm).*(abs(mm).^(1/3)));axis equal
axis equal;% colorbar%camlight left
view([30,60,90]);
set(gca, 'visible', 'off');
lmd = 2*pi/E(MN,MN);

aa = eb*(1+lmd)/(1-lmd);

MN_S = int2str(MN);
E_S = num2str( aa );
name_ps = strcat('Eig_eps',E_S,'_',MN_S,'.ps');
print(name_ps)

end
