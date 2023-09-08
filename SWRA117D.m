%%
DI = 0e-4;
%L1 = 3.94e-3+DL;
%L2 = 2.70e-3+DL;

L4 = 2.64e-3+DI;
L5 = 2e-3+DI;
%L6 = 4.90e-3;
L6 = 7.5e-3;
L7 = L6;

%W1 = 0.90e-3;
%W2 = 0.5e-3+DI;
DW = 0.09e-3
W2 = 0.6e-3+DW;
W1 = 3.0e-3+DW;

L1 = L6-0.0055
L2 = L5+2*W2
D1 = 0.5e-3;
D2 = 0.3e-3
D3 = 0.3e-3
D4 = 0.5e-3;
D5 = 1.3e-3;
D6 = 1.70e-3;

L3 = W1+D5+W2+D6+W2;

ED = 4e-4
Lgp = D1+L3+L5*2+L2*2+D3; % Length of the Groundplane

Wgp = 30e-3;   % Width of the Groundplane

LBS = Lgp; % Length for the Board Shape
Aheigth = L6+W2+D2
WBS = Wgp+Aheigth;  % Width of the Board Shape

ant_gap = 0.7e-3;

TH  = W2/2+L6; % upper row height
BH = L6-L4+W2/2; % Bottom row height
VH = L6-L4/2 % Vertical Row height

a = antenna.Rectangle('Length',W1,'Width',L6,'Center',[W1/2,L6/2]);
b = antenna.Rectangle('Length',L3,'Width',W2,'Center',[L3/2,TH]);
c = antenna.Rectangle('Length',W2,'Width',L7,'Center',[W2/2+D5+W1,L6-L7/2]);
d = antenna.Rectangle('Length',W2,'Width',L4,'Center',[L3-W2/2,VH]);
e = antenna.Rectangle('Length',L5,'Width',W2,'Center',[L5/2+L3,BH]);
f = antenna.Rectangle('Length',W2,'Width',L4,'Center',[L3+L5+W2/2,VH]);
g = antenna.Rectangle('Length',L2,'Width',W2,'Center',[L3+L5+L2/2,TH]);
h = antenna.Rectangle('Length',W2,'Width',L4,'Center',[L3+L5+L2-W2/2,VH]);
i = antenna.Rectangle('Length',L5,'Width',W2,'Center',[L3+L5+L2+L5/2,BH]);
j = antenna.Rectangle('Length',W2,'Width',L4,'Center',[L3+L5+L2+L5+W2/2,VH]);
k = antenna.Rectangle('Length',L2,'Width',W2,'Center',[L3+L5+L2+L5+L2/2,TH]);
l = antenna.Rectangle('Length',W2,'Width',L1,'Center',[L3+L5+L2+L5+L2-W2/2,L6-L1/2]);
% 
% attach = antenna.Rectangle('Length',W2+ant_gap,'Width',L6+ant_gap,'Center',[W2/2+D5+W1,L6/2-D4]);
% 
% gnd1 = antenna.Rectangle('Length',Lgp+edge,'Width',Wgp,'Center',[Lgp/2-0.5e-3-edge/2,-Wgp/2]);
% cutout = antenna.Rectangle('Length',W2+ant_gap,'Width',L6+ant_gap,'Center',[W2/2+D5+W1,L6/2-D4]);
% 
% gnd1 = gnd1-cutout

Newobj = a+b+c+d+e+f+g+h+i+j+k+l;%+gnd1;
figure;
show(Newobj)

%2 layer Eurocircuits
d = dielectric('FR4');
d.Thickness = 1.55e-3;
d.EpsilonR = 4.5;

%4 layer Eurocircuits
% d = dielectric('FR4');
% d.Thickness = 0.36e-3;
% d.EpsilonR = 4.5;
% d1 = dielectric('FR4');
% d1.Thickness = 0.71e-3+0.36e-3;
% d1.EpsilonR = 4.5;

edge = 10.8e-3;
edge_height = Aheigth-D4


ant                = pcbStack;
boardshape         = antenna.Rectangle('Length',LBS+edge,'Width',WBS,'Center',[LBS/2-D1-edge/2,Aheigth+(-WBS)/2]);
%cutout             = antenna.Rectangle('Length',edge,'Width',edge_height,'Center',[-edge/2-D1,edge_height/2+D4+D2]);
%boardshape = boardshape-cutout;

ant.BoardShape     = boardshape;
%ant.BoardThickness = d.Thickness+d1.Thickness;
ant.BoardThickness = d.Thickness;%Dual Layer
%gnd                = antenna.Rectangle('Length',Lgp+edge-2*D2,'Width',Wgp+D4-D2,'Center',[Lgp/2-D1-edge/2,D4-Wgp/2]);

gnd                = antenna.Rectangle('Length',Lgp+edge,'Width',Wgp+D4,'Center',[Lgp/2-D1-edge/2,D4-Wgp/2]);

%ant.Layers         = {Newobj,d,gnd,d1};
ant.Layers         = {Newobj,d,gnd};
ant.FeedDiameter   = W2/2;
ant.ViaDiameter    = W1/4;
ant.FeedLocations  = [W1+1.4e-3+W2/2,L6-L7+D4/2,3,1];
ant.ViaLocations   = [W1/2,D4/2,3,1];
ant.FeedViaModel   = 'square';
ant.Conductor      = metal('Copper');
ant.Conductor.Thickness = 35e-6;
figure;
show(ant)
%%
minf = 2.4e9;
maxf = 2.5e9;
points = 3;
x = 3, y=3
freqs = linspace(minf,maxf,points)

%%
%profile on 
figure;
mesh(ant,'MaxEdgeLength', 1.2e-3);
%%
tic
figure;
impedance(ant,freqs);
toc
%%
tic
figure;
spar = sparameters(ant,freqs);
rfplot(spar)
toc
%profile viewer
%%
% figure;
% rfplot(spar)
% 
% figure;
% pattern(ant,2.4e9)
