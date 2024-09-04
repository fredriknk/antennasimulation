%%%        L3
%%%     ____________ W3
%%%    | D5 |
%%% L6 |    |L6
%%%   W1    W2
classdef IFA
    properties
        L3 = 0.019588%0.019530%20.0e-3
        L6 = 0.005586%0.005404%6.0143e-3
        W1 = 0.000613%0.000564%0.412e-3
        W2 = 0.000425%0.000475%0.328e-3
        W3 = 0.000472%0.000475%0.328e-3
        D4 = 0.5e-3  % board edge
        D5 = 0.001108%0.001070%1.534e-3
        dThickness = 0.12e-3
        d1Thickness = 1.2e-3
        dEpsilonR = 4.6
        d1EpsilonR = 4.6
        Lgp = 20.0e-3 % Length of the Groundplane
        Wgp = 83.15e-3 % Width of the Groundplane
    end

    properties (Dependent)
        ant
    end

    methods
        % Constructor
        function obj = IFA(varargin)
            % Initialize properties from name-value pairs
            for k = 1:2:length(varargin)
                if isprop(obj, varargin{k}) % Check if the name is a valid property
                    obj.(varargin{k}) = varargin{k+1};
                else
                    error('%s is not a valid property', varargin{k});
                end
            end
        end
        
        % Getter for the dependent property 'ant'
        function value = get.ant(obj)
            value = buildAntenna(obj);
        end
        
        % Setters that trigger antenna rebuild
        function obj = set.L3(obj, value)
            obj.L3 = value;
        end

        function obj = set.L6(obj, value)
            obj.L6 = value;
        end

        function obj = set.W1(obj, value)
            obj.W1 = value;
        end
        function obj = set.W2(obj, value)
            obj.W2 = value;
        end
        function obj = set.W3(obj, value)
            obj.W3 = value;
        end

        function obj = set.D4(obj, value)
            obj.D4 = value;
        end

        function obj = set.D5(obj, value)
            obj.D5 = value;
        end

        function obj = set.dThickness(obj, value)
            obj.dThickness = value;
        end

        function obj = set.d1Thickness(obj, value)
            obj.d1Thickness = value;
        end

        function obj = set.dEpsilonR(obj, value)
            obj.dEpsilonR = value;
        end

        function obj = set.d1EpsilonR(obj, value)
            obj.d1EpsilonR = value;
        end

        function obj = set.Lgp(obj, value)
            obj.Lgp = value;
        end

        function obj = set.Wgp(obj, value)
            obj.Wgp = value;
        end

        % Method to build antenna
        function ant = buildAntenna(obj)
            W1 = obj.W1;
            W2 = obj.W2;
            W3 = obj.W3;

            a = antenna.Rectangle('Length', W1, 'Width', obj.L6, 'Center', [W1/2, obj.L6/2 - obj.D4]);
            c = antenna.Rectangle('Length', W2, 'Width', obj.L6, 'Center', [W2/2 + obj.D5 + W1, obj.L6/2 - obj.D4]);
            b = antenna.Rectangle('Length', obj.L3, 'Width', W3, 'Center', [obj.L3/2, W3/2 + obj.L6 - obj.D4]);

            Newobj = a + c + b;

            d = dielectric('FR4');
            d.Thickness = obj.dThickness;
            d.EpsilonR = obj.dEpsilonR;
            d1 = dielectric('FR4');
            d1.Thickness = obj.d1Thickness;
            d1.EpsilonR = obj.d1EpsilonR;

            LBS = obj.Lgp + 2 * obj.D4;  % Length for the Board Shape
            WBS = obj.L6;  % Width of the Board Shape

            ant = pcbStack;
            boardshape = antenna.Rectangle('Length', LBS, 'Width', WBS + obj.Wgp + 2 * obj.D4, 'Center', [LBS/2 - obj.D4, (WBS - obj.Wgp)/2]);
            ant.BoardShape = boardshape;
            ant.BoardThickness = d.Thickness + d1.Thickness;
            gnd = antenna.Rectangle('Length', obj.Lgp, 'Width', obj.Wgp, 'Center', [LBS/2 - obj.D4, -obj.Wgp/2]);
            ant.Layers = {Newobj, d, gnd, d1};
            ant.FeedDiameter = W2/2;
            ant.ViaDiameter = W1/4;
            ant.FeedLocations = [W1 + obj.D5 + W2/2, -obj.D4/2, 3, 1];
            ant.ViaLocations = [W1/2, -obj.D4/2, 3, 1];
            ant.FeedViaModel = 'square';
            ant.Conductor = metal('Copper');
            ant.Conductor.Thickness = 35e-6;
        end
    end
end

%ant1 = IFA();
    
%msh = mesh(ant1,'MaxEdgeLength', 10.2e-3);

%imp = impedance(ant1,freqs);

%spar = sparameters(ant,freqs);

%frequency = spar.Frequencies;
%impedans = imp
%dbi = 20*log10(abs(spar.Parameters))

