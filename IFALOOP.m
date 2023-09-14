function IFALOOP(startL3, stopL3, numsL3,startL6, stopL6, numsL6,startW1, stopW1, numsW1, startD5, stopD5, numsD5, meshsize)
    % 
    % startL6= 160;
    % stopL6 = 160;
    % numsL6 = 1;
    varL6 = linspace(startL6,stopL6,numsL6);
    % 
    % startL3 = 748;
    % stopL3 = 748;
    % numsL3 = 1;
    varL3 = linspace(startL3,stopL3,numsL3);
    % 
    % startW1 =24;
    % stopW1 = 24;
    % numsW1 = 1;
    varW1 = linspace(startW1,stopW1,numsW1);
    % 
    % startD5 = 18;
    % stopD5 = 22;
    % numsD5 = 5;
    varD5 = linspace(startD5,stopD5,numsD5);
    
    param= "L6,L3,W2,D1";
    
    t = datestr(now,'yyyy_mm_ddTHH-MM-SS');
    filename = sprintf("data/results_%s_meshsize-%.0f_L3-%.0f-%.0f-%.0f_L6-%.0f-%.0f-%.0f_W1-%.0f-%.0f-%.0f_D5-%.0f-%.0f-%.0f.txt",t,meshsize*10000,startL3,stopL3,numsL3,startL6,stopL6,numsL6,startW1,stopW1,numsW1,startD5,stopD5,numsD5);
    
    str = sprintf("Tuning %s, Meshsize is %.6f m",param,meshsize);
    
    fileID = fopen(filename,'a');
    fprintf(fileID,str+"\n");
    fclose(fileID);
    disp(str);
    
    %%
    for i = 1:numsL3
        for j = 1:numsL6
            for k = 1:numsW1
                for iD5 = 1:numsD5 
                    tic   
                    m = 2.54e-5;
                    W1 = varW1(k)*m;
                    L6 = varL6(j)*m;
                    L3 = varL3(i)*m;
        
                    W2 = 24*m;
                    
                    
                    L7 = 1e-3;
                    W3 = W1;
                    D4 = 0.127e-3;
                
                    W4 = W3+D4*2;
                    
                    D5 = varD5(iD5)*m;
                    
                    
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
                    a_ = antenna.Rectangle('Length',W1,'Width',W2/2,'Center',[W1/2,-W2/2/2]);
                    b = antenna.Rectangle('Length',L3,'Width',W2,'Center',[L3/2,TH]);
                    
                    c = antenna.Rectangle('Length',W2,'Width',L6,'Center',[W2/2+D5+W1,L6/2]);
                    d = antenna.Rectangle('Length',W3,'Width',W2/2,'Center',[W2/2+D5+W1,-W2/2/2]);
                    
                    Newobj = a+a_+b+c+d;%+gnd;
                    
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
                    ant.FeedLocations  = [W1+D5+W2/2,-W2/4,1,3];
                    ant.ViaLocations   = [W1/2,-W2/4,1,3];
                    ant.FeedViaModel   = 'square';
                    %ant.Conductor      = metal('Copper');
                    %ant.Conductor.Thickness = 35e-6;
        
                    freqs = 2.44e9;%linspace(minf,maxf,points)
                    
                    msh = mesh(ant,'MaxEdgeLength', meshsize);
                    
                    imp = impedance(ant,freqs);
                    
                    spar = sparameters(ant,freqs);
                    
                    frequency = spar.Frequencies;
                    impedans = imp;
                    dbi = 20*log10(abs(spar.Parameters));
                    
                    str = sprintf("L3\t%.3f\tL6\t%.3f\tW1\t%.3f\tD5\t%.3f\tDB\t%.3f\tIMP\t%.5f\tmeshsize\t%0.3f\n", varL3(i),varL6(j),varW1(k),varD5(iD5),dbi,impedans,meshsize);
                    
                    fileID = fopen(filename,'a');
                    fprintf(fileID,str);
                    fclose(fileID);
                    
                    disp(str);
                    
                    toc
                end
            end
        end
    end

    exit;
end