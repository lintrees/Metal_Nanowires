%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This program is used to draw the 
% field distributions 
% 
%
%      Won Park nanophtonic group
%      ECEE at Colorado University
% 
%  Author: Jianhong Zhou
%          zhoujianhong@gmail.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Before run this program, you should first set
% the mode numbers MN to point which mode to draw
%Mode number
%MN = 3;


%Define the view area
x = [-2.02*Cx:Cx/6.02:2.02*Cx] ;
y = x;
z = 0;

%size of the plot
l_w = length(x);
TPA_V = [TPA,V];


Eig_Chrg_Mode =  V(:,MN);%First three are positon, next seven are meanless

ss = length(TPA_V(:,1));

%Electric field
E_F_x = zeros(l_w,l_w);
E_F_y = zeros(l_w,l_w);
E_F_z = zeros(l_w,l_w);

%Potential
P_phi = zeros(l_w,l_w);
XX = zeros(l_w,l_w);
YY = zeros(l_w,l_w);

for Count_x = 1:l_w
  for Count_y = 1:l_w
      Tmp = [x(Count_x)*ones(ss,1) y(Count_y)*ones(ss,1) z*ones(ss,1)]...
            - TPA_V(:,1:3);
      R_MP = (Tmp(:,1).^2+Tmp(:,2).^2+Tmp(:,3).^2).^0.5;
%Electric field at position [x(Count_x) y(Count_y) z]
      E_F_x(Count_x,Count_y) = sum(Eig_Chrg_Mode./R_MP.^3.*Tmp(:,1)); 
      E_F_y(Count_x,Count_y) = sum(Eig_Chrg_Mode./R_MP.^3.*Tmp(:,2));
      E_F_z(Count_x,Count_y) = sum(Eig_Chrg_Mode./R_MP.^3.*Tmp(:,3)); 
      XX(Count_x,Count_y)=x(Count_x);
      YY(Count_x,Count_y)=y(Count_y);
  end
end
% [x y] = meshgrid(x,y);
%figure(1)
%surf(XX,YY,P_phi);shading interp,colorbar

ex = E_F_x;
ey = E_F_y;
ez = E_F_z;

E_Vector = ex+ey*1i;

E_Rou = abs(E_Vector);
E_Angle = angle(E_Vector);
Ex = cos(E_Angle).*E_Rou.^(1/5);
Ey = sin(E_Angle).*E_Rou.^(1/5);

quiver(XX,YY,Ex,Ey,0.5,'-','r');axis equal;axis off;

hold on

DCirc(Center_1,1)
DCirc(Center_2,1)
hold off