disp("Starting Script");
disp("Testing antenna function")
a = IFA();
disp("Made antenna")
disp(a.ant)
disp("starting optimization")
optimizeAntennaMultiVars({"W1",'W2', 'W3'}, {[0.3e-3, 0.7e-3], [0.3e-3, 0.7e-3], [0.3e-3, 0.7e-3]}, 'match', 'impedance', 50, 1.2e-3)
%optimizeAntennaMultiVars({"W1",'W2', 'W3'}, {[0.15e-3, 1e-3], [0.15e-3, 1e-3], [0.15e-3, 1e-3]}, 'match', 'impedance', 50, 1.2e-3)