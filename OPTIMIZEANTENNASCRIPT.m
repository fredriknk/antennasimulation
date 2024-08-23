disp("Starting Script");
disp("Testing antenna function")
a = IFA();
disp("Made antenna")
disp(a.ant)
disp("starting optimization")
optimizeAntennaMultiVars({"L3","L6","D5","W1",'W2', 'W3'}, {[15e-3, 20.5e-3],[1e-3, 10e-3],[1e-3, 10e-3],[0.15e-3, 1e-3], [0.15e-3, 1e-3], [0.15e-3, 1e-3]}, 'minimum', 's11',50, 1.2e-3)
%optimizeAntennaMultiVars({"W1",'W2', 'W3'}, {[0.15e-3, 1e-3], [0.15e-3, 1e-3], [0.15e-3, 1e-3]}, 'match', 'impedance', 50, 1.2e-3)