function optimizeAntennaMultiVars(varNames, varSettings, goal, optimizeMetric, targetImpedance, meshsize)
    % Ensure all variable names and settings are in cell arrays, even for single entries
    if ~iscell(varNames) || ~iscell(varSettings)
        error('Variable names and settings must be provided in cell arrays.');
    end

    % Separate optimization variables and their bounds from fixed settings
    optIndices = cellfun(@(x) isnumeric(x) && length(x) == 2, varSettings);

    lb = cellfun(@(x) x(1), varSettings(optIndices));
    ub = cellfun(@(x) x(2), varSettings(optIndices));

    % Calculate initial guesses with random dithering
    range = ub - lb;  % Range of each variable
    dither = range .* (0.1 * (2 * rand(size(lb)) - 1));  % Dithering up to 10% of the range, symmetrically about the center
    initialGuesses = (lb + ub) / 2 + dither;  % Midpoint of the bounds plus random dithering

    % Define the objective function
    objectiveFunction = @(x) calculateMultiPerformanceMetric(x, varNames(optIndices), varSettings, optimizeMetric, goal, targetImpedance, meshsize);

    % Optimization options
    %options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');
    options = optimoptions('fmincon', 'UseParallel', true, 'Display', 'iter', 'Algorithm', 'sqp');
    % Execute the optimization
    [optValues, optMetric] = fmincon(objectiveFunction, initialGuesses, [], [], [], [], lb, ub, [], options);
    
    % Print results
    fprintf('Optimized values:\n');
    optVarNames = varNames(optIndices);
    for i = 1:length(optVarNames)
        fprintf('%s = %f\n', optVarNames{i}, optValues(i));
    end
    fprintf('Optimal %s: %f\n', optimizeMetric, optMetric);
end

function metric = calculateMultiPerformanceMetric(x, optVarNames, varSettings, optimizeMetric, goal, targetImpedance, meshsize)
    % Create and setup the antenna object
    antennaObject = IFA();

    % Debug: Print variable names and values to ensure correct mapping
    disp('Optimization Variables and Values:');
    disp(optVarNames);
    disp(x);

    % Set optimized variable values
    for i = 1:length(optVarNames)
        if length(x) >= i  % Check if index exists in x
            antennaObject.(optVarNames{i}) = x(i);
        else
            error('Mismatch in number of variables and optimization parameters.');
        end
    end

    ant = antennaObject.ant;  % Get the antenna configuration

    % Define simulation parameters
    mesh(ant, 'MaxEdgeLength', meshsize);
    freqs = 2.44e9;

    % Select the optimization metric based on user choice
    if strcmp(optimizeMetric, 'impedance') && strcmp(goal, 'match')
         % Compute impedance and S-parameters
        imp = impedance(ant, freqs);
        metric = abs(abs(imp) - targetImpedance);  % Difference from target impedance
    elseif strcmp(optimizeMetric, 's11')
        spar = sparameters(ant, freqs);
        s11 = 20 * log10(abs(spar.Parameters(1,1,1)));
        metric = s11;  % S11 value directly
    else
        error('Unsupported optimization metric or goal.');
    end
end

%optimizeAntennaMultiVars({"L3","L6","D5","W1",'W2', 'W3'}, {[10e-3, 20.5e-3],[1e-3, 10e-3],[1e-3, 10e-3],[0.15e-3, 1e-3], [0.15e-3, 1e-3], [0.15e-3, 1e-3]}, 'minimum', 's11',50, 10.2e6)
%optimizeAntennaMultiVars({"W1",'W2', 'W3'}, {[0.1e-3, 1e-3], [0.1e-3, 1e-3], [0.1e-3, 1e-3]}, 'match', 'impedance', 50, 10.2e6)