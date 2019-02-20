%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This program is used to draw the 
% electric potential. 
% 
%
%      Won Park nanophtonic group
%      ECEE at Colorado University
% 
%  Author: Jianhong Zhou
%          zhoujianhong@gmail.com
%
%  File name:  Potential.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Before run this program, you should first set
% the mode numbers MN to point which mode to draw
%Mode number
%MN = 3;

%Define the view area
x = [-2.5*Cx:Cx/20:2.5*Cx] ;
y = x;
z = 0;

%size of the plot
l_w = length(x);
TPA_V = [TPA,V];


%Eig_Chrg_Mode = TPA_V(:,MN+3);%First three are positon, next seven are meanless
Eig_Chrg_Mode = V(:,MN);%First three are positon, next seven are meanless

ss = length(TPA_V(:,1));


%Potential
P_phi = zeros(l_w,l_w);
XX = zeros(l_w,l_w);
YY = zeros(l_w,l_w);

for Count_x = 1:l_w
  for Count_y = 1:l_w
      Tmp = [x(Count_x)*ones(ss,1) y(Count_y)*ones(ss,1) z*ones(ss,1)]...
            - TPA_V(:,1:3);
      R_MP = (Tmp(:,1).^2+Tmp(:,2).^2+Tmp(:,3).^2).^0.5;
      XX(Count_x,Count_y)=x(Count_x);
      YY(Count_x,Count_y)=y(Count_y);

      P_phi(Count_x,Count_y) = sum(Eig_Chrg_Mode./R_MP);
  end
end

surf(XX,YY,P_phi);shading interp,colorbar,

%hold on

%DCirc(Center_1,1)
%DCirc(Center_2,1)
%hold off