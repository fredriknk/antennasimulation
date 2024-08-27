function out=optimizeAntenna(varName, lb, ub, presets,presetvals, goal, optimizeMetric,meshsize)
    % Validate optimizeMetric input
    if ~ismember(optimizeMetric, {'impedance', 's11'})
        error('optimizeMetric must be either "impedance" or "s11".');
    end

    % Objective Function
    if strcmp(goal, "minimum")
        objectiveFunction = @(x) calculatePerformanceMetric(x, varName,presets, presetvals, optimizeMetric,meshsize);
    elseif strcmp(goal, "maximum")
        objectiveFunction = @(x) -calculatePerformanceMetric(x, varName,presets, presetvals, optimizeMetric,meshsize);
    else
        error('Goal must be "minimum" or "maximum".');
    end

    % Optimization options
    options = optimset('TolX', 1e-5, 'Display', 'iter');

    % Run fminbnd to find the optimal value
    [optValue, optMetric] = fminbnd(objectiveFunction, lb, ub, options);

    fprintf('Optimal %s: %f, Optimal %s: %f\n', varName, optValue, optimizeMetric, optMetric * (strcmp(goal, "minimum")*2-1));
    out=optValue;
end

function metric = calculatePerformanceMetric(value, varName, presets, presetvals, optimizeMetric,meshsize);
    tic
    % Set up the antenna object with the specified variable value
    antennaObject = IFA();
    antennaObject.(varName) = value;  % Dynamically set the property
    
    % Set optimized variable values
    if ~isempty(presets)
        for i = 1:length(presets)
            if length(presetvals) >= i  % Check if index exists in x
                antennaObject.(presets{i}) = presetvals{i};
            else
                error('Mismatch in number of variables and optimization parameters.');
            end
        end
    end

    ant = antennaObject.ant;  % Get the antenna configuration

    % Define operational parameters
    mesh(ant, 'MaxEdgeLength', meshsize);
    freqs = 2.44e9;

    % Calculate impedance and S-parameters
    imp = impedance(ant, freqs);
    spar = sparameters(ant, freqs);
    s11 = 20 * log10(abs(spar.Parameters(1,1,1)));

    % Print the current values
    fprintf('At %s = %f: Impedance = %f Ohm, S11 = %f dB\n', varName, value, abs(imp), s11);

    % Decide which metric to return based on the optimization target
    toc
    if strcmp(optimizeMetric, 'impedance')
        metric = abs(imp);
    else
        metric = s11;
    end
end