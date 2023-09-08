
start= 700;
stop = 900;
nums = 30;
meshsize =  1.2e-3;
param= "L3";
%%
t = datestr(now,'yyyy_mm_ddTHH-MM-SS');
filename = sprintf("results_%s.txt",t);

%%

str = sprintf("Tuning %s, from %d to %d in %d steps, Meshsize is %.6f m",param,start,stop,nums,meshsize);

fileID = fopen(filename,'a');
fprintf(fileID,str+"\n");
fclose(fileID);
disp(str);
varnum = linspace(start,stop,nums)

%%
str_arr = [""];
var_array = [];
imp_array = [];
db_array = [];

tic
parfor i = 1:nums
    m = 2.54e-5;
    W1= 65*m;
    W2 = W1;
    L6 = 160*m;
    
    L7 = 1e-3;
    W3 = W1;
    D4 = 0.127e-3;

    W4 = W3+D4*2;
    
    D5 = 20*m;
    L3 = varnum(i)*m;
    
    D1 = 0.5e-3;
    D2 = 0.3e-3;
    D3 = 0.3e-3;
    
    ED = 4e-4;
    Lgp = D1+L3+D3; % Length of the Groundplane
    
    Wgp = 75e-3;   % Width of the Groundplane
    
    LBS = Lgp; % Length for the Board Shape
    Aheigth = L6+W2+D2;
    WBS = Wgp+Aheigth;  % Width of the Board Shape
    TH = L6+W2/2;
    
    ant_gap = 0.7e-3;
    edge = 26e-3 - Lgp;
    edge_height = Aheigth-D4;
    
    a = antenna.Rectangle('Length',W1,'Width',L6,'Center',[W1/2,L6/2]);
    b = antenna.Rectangle('Length',L3,'Width',W2,'Center',[L3/2,TH]);
    
    c = antenna.Rectangle('Length',W2,'Width',L6,'Center',[W2/2+D5+W1,L6/2]);
    d = antenna.Rectangle('Length',W3,'Width',L7,'Center',[W2/2+D5+W1,-L7/2]);
    
    ccut = antenna.Rectangle('Length',W2+2*D4,'Width',L6,'Center',[W2/2+D5+W1,L6/2-D4]);
    dcut = antenna.Rectangle('Length',W3+2*D4,'Width',L7+D4,'Center',[W2/2+D5+W1,-L7/2-D4]);
    
    gnd  = antenna.Rectangle('Length',Lgp+edge,'Width',Wgp,'Center',[Lgp/2-edge/2-D1,-Wgp/2]);
    
    
    
    gnd = gnd-ccut-dcut;
    
    Newobj = a+b+c+d+gnd;

    d = dielectric('FR4');
    d.Thickness = 1.55e-3;
    d.EpsilonR = 4.5;
    
    ant                = pcbStack;
    boardshape         = antenna.Rectangle('Length',LBS+edge,'Width',WBS,'Center',[LBS/2-D1-edge/2,Aheigth+(-WBS)/2]);
    ant.BoardShape     = boardshape;
    ant.BoardThickness = d.Thickness;%Dual Layer
    gnd                = antenna.Rectangle('Length',Lgp+edge,'Width',Wgp,'Center',[Lgp/2-D1-edge/2,D4-Wgp/2]);

    ant.Layers         = {Newobj,d,gnd};
    ant.FeedDiameter   = W2/4;
    ant.ViaDiameter    = W1/4;
    ant.FeedLocations  = [W1+D5+W2/2,-L7+W2/4,1,3];
    ant.ViaLocations   = [W1/2,-W1/4,1,3];
    ant.FeedViaModel   = 'square';
    ant.Conductor      = metal('Copper');
    ant.Conductor.Thickness = 35e-6;
    
    minf = 2.40e9;
    maxf = 2.50e9;
    points = 3;
    freqs = 2.45e9;%linspace(minf,maxf,points)
    
    msh = mesh(ant,'MaxEdgeLength', meshsize);
    
    imp = impedance(ant,freqs);
    
    spar = sparameters(ant,freqs);
    
    frequency = spar.Frequencies;
    impedans = imp;
    dbi = 20*log10(abs(spar.Parameters));

    str = sprintf("no: %d length = %.3f Dbi = %.3f Impedance = %.3f\n",i,varnum(i),dbi,impedans);
    disp(str);
    var_array(i) = varnum(i);
    imp_array(i) =impedans;
    db_array(i) = dbi;
    stringarr(i) = str;
    
end
toc

fileID=fopen(filename,'a');
for n = 1 : length(stringarr)
    fprintf(fileID,stringarr(n));
end

fclose(fileID);

delete(gcp('nocreate'))

exit
