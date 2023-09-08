

for L3mil = linspace(780,850,4)
    
    m = 2.54e-5;
    W1= 65*m;
    W2 = W1;
    L6 = 160*m;
    
    L7 = 8.334e-3;
    W3 = 0.667e-3;
    D4 = 0.127e-3;
    
    W4 = W3+D4*2;
    
    D5 = 20*m;
    %L3 = 800*m;
    L3 = L3mil*m;
    
    D1 = 0.5e-3;
    D2 = 0.3e-3;
    D3 = 0.3e-3;
    
    ED = 4e-4;
    Lgp = D1+L3+D3; % Length of the Groundplane
    
    Wgp = 25e-3;   % Width of the Groundplane
    
    LBS = Lgp; % Length for the Board Shape
    Aheigth = L6+W2+D2;
    WBS = Wgp+Aheigth;  % Width of the Board Shape
    
    ant_gap = 0.7e-3;
    edge = 26e-3 - Lgp;
    edge_height = Aheigth-D4
    
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
    ant.FeedLocations  = [W1+D5+W2/2,-L7+W2/4,3,1];
    ant.ViaLocations   = [W1/2,-W1/4,3,1];
    ant.FeedViaModel   = 'square';
    ant.Conductor      = metal('Copper');
    ant.Conductor.Thickness = 35e-6;
    
    minf = 2.40e9;
    maxf = 2.50e9;
    points = 3;
    freqs = 2.45e9;%linspace(minf,maxf,points)
    
    msh = mesh(ant,'MaxEdgeLength', 3.2e-3);
    
    imp = impedance(ant,freqs);
    
    spar = sparameters(ant,freqs);
    
    frequency = spar.Frequencies
    impedans = imp
    dbi = 20*log10(abs(spar.Parameters))

end

