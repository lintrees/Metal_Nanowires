function YY = DCirc(Cnt,R)
  t = [0:0.01:2*pi];
  x = R*cos(t)-Cnt(1);
  y = R*sin(t)-Cnt(2);
  plot(x,y);
    