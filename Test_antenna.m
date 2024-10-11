antennaobject = IFA()
ant = a.ant


gerberWrite(ant);

mesh(ant, 'MaxEdgeLength', 1.2e-3)
freqs=linspace(2.39e9,2.5e9,11 )
spar = sparameters(ant,freqs)

imp = impedance(ant, freqs)
display(imp)