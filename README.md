# CochlearNerveFHModel
Computational model based off of the Frankenhaeuser-Huxley equations to simulate the effects of demyelination on cochlear neurons in humans.

Authors: Lauren Heckelman, Matthew McCann, and Michelle Mueller.

This code relies on the FH mechanism written by Michael Hines, which describes the FH equation given in the original Frankenhaeuser-Huxley paper. Also referenced is the extracellular_sample.hoc code distributed by Leo Medina. Spiral ganglion cell membrane parameters taken from Frijns, et al. (1995), and Cartee (2006).

The original code by Hines replicates Figures 1, 3, and 6 in the original Frankenhaeuser-Huxley paper. To validate for yourself, compile the fh.mod function and run fh.hoc.

References:

[1] Frankenhaeuser, B. and Huxley, A. F. (1964)
The action potential in the myelinated nerve fibre of Xenoupus Laevis as computed
on the basis of voltage clamp data.
J. Physiol. 171: 302-315

[2] Hines, Michael. Xenopus Myelinated Neuron (Frankenhaeuser, Huxley 1964). From http://senselab.med.yale.edu/ModelDB/showModel.cshtml?model=3507

[3] Frijns, J.H.M, de Snoo, S.L., and Schoonhoven, R. (1995) Potential distributions and neural excitation patterns in a rotationally symmetric model of the electrically stimulated cochlea. Hearing Research 87: 170-186

[4] Cartee, Lianne, A. (2006). Spiral ganglion cell site of excitation II: Numerical model analysis. ￼￼Hearing Research 215: 22–30
