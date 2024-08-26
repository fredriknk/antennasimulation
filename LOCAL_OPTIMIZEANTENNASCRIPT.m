params={"L3","L6","D5","W3","W2","W1"}
Ranges={[10e-3, 20.5e-3],[1e-3, 15e-3],[1e-3, 15e-3],[0.15e-3,1e-3],[0.15e-3,1e-3],[0.15e-3,1e-3]}
meshsize = 1.2e-3 % Defined once, used for all optimizations

% Run the automated optimization
results = automatedOptimization(params, Ranges, meshsize);


function results = automatedOptimization(vars, ranges, meshsize)
    nVars = length(vars);
    results = struct(); % Initialize a structure to store optimization results

    % Loop through each variable
    for idx = 1:nVars
        varName = vars{idx}; % Current variable
        range = ranges{idx}; % Range for the current variable
        
        % Prepare presets and their values based on previous results
        if idx == 1
            % First variable, no dependencies
            presets = {};
            presetVals = {};
        else
            % Subsequent variables, use all previous variables as dependencies
            presets = vars(1:idx-1);
            presetVals = cell(1, idx-1); % Initialize cell array for preset values
            for j = 1:(idx-1)
                % Fill the cell array with optimized values from the results structure
                presetVals{j} = results.(vars{j});
            end
        end
        
        % Optimize the current variable
        %varName, range(1), range(2), presets, presetVals, "minimum", "s11", meshsize
        optimizedValue = optimizeAntenna(varName, range(1), range(2), presets, presetVals, "minimum", "s11", meshsize);
        
        % Store the optimized value
        results.(varName) = optimizedValue;
        
        % Display the result
        fprintf('%s optimized to: %f\n', varName, optimizedValue);

        % Display all optimized results after completion of all optimizations
        fprintf('\nAll optimized values:\n');

        for idx2 = 1:idx
            varName = vars{idx2};
            optimizedValue = results.(varName);
            fprintf('%s: %f\n', varName, optimizedValue);
        end
    end
end