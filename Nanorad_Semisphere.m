%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This program is an example to calculate 
% one Cylinder and two semisphere system where the semisphere locate in the
% upside and downside of the Cylinder respectively.
% The Cylinder has radium = 12.5nm Height = 75nm and these two semispheres have 
% the diameter D=25nm.
% This system consists of three this basic unit which rotate 120 degrees
% from one of them clockwisely and anticlockwisely.
% the distance between these units is RR.
%
%      
% 
%  Author: Song Jianlin
%          15143014944@163.com
%
% File name: Nanorod_Semisphere.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc
load Nanorod_semispher_ExtraFine_cood.txt;
a = Nanorod_semispher_ExtraFine_cood;
load Nanorod_semispher_ExtraFine_vertex.txt;
b = Nanorod_semispher_ExtraFine_vertex;
H_Cylinder=75;
D_Cylinder=25;
R_Semisphere=12.5;
D_R=30;
theta=0:pi*2/3:pi*4/3;
[p q]=size(theta);
R_Z_1=[cos(theta(1)) sin(theta(1)) 0;-sin(theta(1)) cos(theta(1)) 0; 0 0 1];
R_Z_2=[cos(theta(2)) sin(theta(2)) 0;-sin(theta(2)) cos(theta(2)) 0; 0 0 1];
R_Z_3=[cos(theta(3)) sin(theta(3)) 0;-sin(theta(3)) cos(theta(3)) 0; 0 0 1];
R_X_1=[1 0 0;0 cos(theta(1)) sin(theta(1));0 -sin(theta(1)) cos(theta(1))];
R_X_2=[1 0 0;0 cos(theta(2)) sin(theta(2));0 -sin(theta(2)) cos(theta(2))];
R_X_3=[1 0 0;0 cos(theta(3)) sin(theta(3));0 -sin(theta(3)) cos(theta(3))];
R_Y_1=[cos(theta(1)) 0 -sin(theta(1));0 1 0;sin(theta(1)) 0 cos(theta(1))];
R_Y_2=[cos(theta(2)) 0 -sin(theta(2));0 1 0;sin(theta(2)) 0 cos(theta(2))];
R_Y_3=[cos(theta(3)) 0 -sin(theta(3));0 1 0;sin(theta(3)) 0 cos(theta(3))];
% for i=1:q
%     R_Z=[cos(theta(i)) sin(theta(i)) 0;-sin(theta(i)) cos(theta(i)) 0; 0 0 1];
%     R_X=[1 0 0;0 cos(theta(i)) sin(theta(i));0 -sin(theta(i)) cos(theta(i))];
%     R_Y=[cos(theta(i)) 0 -sin(theta(i));0 1 0;sin(theta(i)) 0 cos(theta(i))];
% end
lngtha = length(a);
lngthb = length(b);
C0_Coordinate = a;
Index = b;
TPX0 = Tri_Positions_Area (C0_Coordinate, Index);
Direction = TPX0(:,1:3);
Direction_Org=Direction;
Direction_Chg=Direction;
[m n]=size(Direction);
for i=1:m
    for j=1:n
        if j==3&&abs(Direction(i,j))<=(H_Cylinder/2)
            RR_Semisphere=sqrt(Direction_Chg(i,1)^2+Direction_Chg(i,2)^2);
            Direction_Chg(i,1)=Direction(i,1)/RR_Semisphere;
            Direction_Chg(i,2)=Direction(i,2)/RR_Semisphere;
            Direction_Chg(i,3)=0;
        end
        if j==3&&(Direction(i,j)>(H_Cylinder/2))
            Direction_Chg(i,3)=(Direction_Chg(i,3)-H_Cylinder/2);
            RR_Semisphere=sqrt(Direction_Chg(i,1)^2+Direction_Chg(i,2)^2+Direction_Chg(i,3)^2);
            Direction_Chg(i,1)=Direction(i,1)/RR_Semisphere;
            Direction_Chg(i,2)=Direction(i,2)/RR_Semisphere;
            Direction_Chg(i,3)=Direction_Chg(i,3)/RR_Semisphere;
        end
        if j==3&&(Direction(i,j)<(-(H_Cylinder/2)))
            Direction_Chg(i,3)=(Direction_Chg(i,3)+H_Cylinder/2);
            RR_Semisphere=sqrt(Direction_Chg(i,1)^2+Direction_Chg(i,2)^2+Direction_Chg(i,3)^2);
            Direction_Chg(i,1)=Direction(i,1)/RR_Semisphere;
            Direction_Chg(i,2)=Direction(i,2)/RR_Semisphere;
            Direction_Chg(i,3)=Direction_Chg(i,3)/RR_Semisphere;
        end
    end
end
Direction_0=Direction_Chg;
quiver3(TPX0(:,1),TPX0(:,2),TPX0(:,3),Direction_0(:,1),Direction_0(:,2),Direction_0(:,3))
C1_Coordinate = [C0_Coordinate(:,1),C0_Coordinate(:,2),C0_Coordinate(:,3)+H_Cylinder/2+D_R];
C2_Coordinate = C1_Coordinate*R_X_2;
C3_Coordinate = C1_Coordinate*R_X_3;
C_Coordinate=[C1_Coordinate; C2_Coordinate; C3_Coordinate];
Direction_1=Direction_0;
Direction_2=Direction_0*R_X_2;
Direction_3=Direction_0*R_X_3;
Direction=[Direction_1;Direction_2;Direction_3];
Index1 = b;
Index2 = lngtha*ones(lngthb,3) + Index1;
Index3 = lngtha*ones(lngthb,3) + Index2;
Index = [Index1;Index2;Index3];
TPA = Tri_Positions_Area (C_Coordinate, Index);
TPX = Direction;
quiver3(TPA(:,1),TPA(:,2),TPA(:,3),Direction(:,1),Direction(:,2),Direction(:,3))
view([90 0 0]);
s = length(TPA(:,1));
T = eye(s,s);
W = zeros(s,s); 
% %Initialize Matlab Parallel Computing Enviornment by Xaero | Macro2.cn
% CoreNum=4; %设定机器CPU核心数量，我的机器是双核，所以CoreNum=2
% if matlabpool('size')<=0 %判断并行计算环境是否已然启动
% matlabpool('open','local',CoreNum); %若尚未启动，则启动并行环境
% else
% disp('Already initialized'); %说明并行环境已经启动。
% end
tic
disp('Calculate the matrix...')
for Count_j = 1:s
  parfor Count_i = 1:s
    if Count_i ~= Count_j
      Tmp = TPA(Count_i,1:3) - TPA(Count_j,1:3);
      R_MQ = norm(Tmp);
      W(Count_i,Count_j) = dot(Tmp, TPX(Count_i,1:3))*TPA(Count_i,4)/R_MQ^3;
    end
  end
  W(Count_j,Count_j) = 2*pi - sum(W(:,Count_j));
end
t0 = toc
tic
  disp('Calculate eigenvalues and eigenvectors ...')
  [V E]=eig(W,T);
t1= toc