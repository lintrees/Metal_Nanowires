%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This program is used to calculate the
% center position and the area of the trigon
% meshed structed. 
%
%      Won Park nanophtonic group
%      ECEE at Colorado University
% 
%  Author: Jianhong Zhou
%          zhoujianhong@gmail.com
%
% File name: Tri_Positions_Area.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [CntPstns_Ar] = Tri_Position_Area(Vertexes, Vertexes_indices)

% Input:
%      Vertexes -- the vertexes of the meshed surface (L x 3)
%      Vertexes_indices -- the indices of the trigon (M x 3)
% Return:
%      CntPstns_Ar = [Center_Positions Tri_Area]        (M X 4)
%      Center_Positions -- center positions of the trigon  (M X 3)
%      Tri_Area -- Area of the trigon                          (M X 1)
%  This work begins at : 2011-07-28 00:42:02 -0600

% due to the comsol position index is from zero,
% while Matlab from 1, add one to all indices.
  
  
  Length_Of_VI = length(Vertexes_indices(:,1));
  Vertexes_indices = Vertexes_indices + ones(Length_Of_VI,3);
  
  %Change Vetexes_indices to trigon vetexes positions
  X1 = Vertexes(Vertexes_indices(:,1),:);
  X2 = Vertexes(Vertexes_indices(:,2),:);
  X3 = Vertexes(Vertexes_indices(:,3),:);
  
  % Center Positions of trigon
  Center_Positions = (X1 + X2 + X3)/3;

  %Computer the Area
  y12 = X2(:,2) - X1(:,2);
  y13 = X3(:,2) - X1(:,2);
  z13 = X3(:,3) - X1(:,3);
  z12 = X2(:,3) - X1(:,3);
  x13 = X3(:,1) - X1(:,1);
  x12 = X2(:,1) - X1(:,1);
  
  Tri_Area = 0.5 * ((y12 .* z13 - z12 .* y13).^2 + ...
                    (x13 .* z12 - z13 .* x12).^2 + ...
                    (x12 .* y13 - y12 .* x13).^2).^0.5;

  CntPstns_Ar = [Center_Positions Tri_Area];
