clear all
clc
Radium_1 = 1;
Cx = 1.1;
Cy = 0;
Center_1 = [-Cx 0 0];
Center_2 = [Cx 0 0];
load cood.dat;
a = cood;
load vertex.dat;
b = vertex;
lngtha = length(a);
lngthb = length(b);
S1_Coordinate = a + [ones(lngtha,1)*Center_1(1),...
                   ones(lngtha,1)*Center_1(2),ones(lngtha,1)*Center_1(3)];
S2_Coordinate = a + [ones(lngtha,1)*Center_2(1),...
                   ones(lngtha,1)*Center_2(2),ones(lngtha,1)*Center_2(3)];
Coordinate = [S1_Coordinate; S2_Coordinate];
TPX1 = Tri_Positions_Area (a,b);
Direction = [TPX1(:,1:3);TPX1(:,1:3)];
Index1 = b;
Index2 = lngtha*ones(lngthb,3) + Index1;
Index = [Index1;Index2];
TPA = Tri_Positions_Area (Coordinate, Index);
TPX = Direction;
s = length(TPA(:,1));
T = eye(s,s);
W = zeros(s,s); 
%Initialize Matlab Parallel Computing Enviornment by Xaero | Macro2.cn
CoreNum=4; %设定机器CPU核心数量，我的机器是双核，所以CoreNum=2
if matlabpool('size')<=0 %判断并行计算环境是否已然启动
matlabpool('open','local',CoreNum); %若尚未启动，则启动并行环境
else
disp('Already initialized'); %说明并行环境已经启动。
end
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
x=length(Index1);
y=length(Index2);
k=length(Index);
E1=E(1:x,1:x);
E2=E(x+1:k,x+1:k);
W_New=[E1*W(1:x,1:x) E1*W(1:x,(x+1):k);E2*W((x+1):k,1:x) E2*W((x+1):k,(x+1):k)];
tic
  disp('Calculate eigenvalues and eigenvectors ...')
  [V_New E_New]=eig(W_New,T);
t2=toc
V=V_New;
E=E_New;
save -v7.3 TSE.mat
matlabpool close