# PINN Discovery 1D Burgers 2024 (PD1B24)

*Last edited: 2024-07-29*

This repository contains the code, data, manuscript, and other files used in the research titled *Data-driven Parameter Discovery of One-dimensional Burgers' Equation Using Physics-Informed Neural Network*. It also includes a research to use neural network in the optical radiation module of atmospheric model.

It is a work in progress and subject to constant changes.

Description of some files and directories:

* [Burgers-1D-Discovery-Numerical.ipynb](Burgers-1D-Discovery-Numerical.ipynb) - 1D Burgers Data-Driven Parameter Discovery using PySINDy. Used in the first part of the work to compare the PINN and NM methods.

* [Burgers-1D-Discovery-PINN.ipynb](Burgers-1D-Discovery-PINN.ipynb) - 1D Burgers Data-Driven Parameter Discovery using PINN. Used in the first part of the work to compare the PINN and NM methods.

* [Burgers-1D-Parameters-PINN.ipynb](Burgers-1D-Parameters-PINN.ipynb) - Notebook used in the second part of the work, which evaluates accuracy and performance depending on network parameters.

* [Burgers-1D-Exact-Solution.ipynb](Burgers-1D-Exact-Solution.ipynb) - 1D Burgers Exact Solution using the Gaussian Quadrature Method (GQM)

* `*-environment.txt` - spec files for the purpose of recreating a [Conda environment](<https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html>) identical to the one used in the experiments. The environment name used in Notebooks is "tf1".

* [1D_Burgers_Data_Driven_Parameter_Discovery.odp](1D_Burgers_Data_Driven_Parameter_Discovery.odp) - Presentation

* [manuscript-1](manuscript-1) - Qualification Exam LaTeX sources

* [ukk23](ukk23) - Research on the use of PINN in gas optics (RRTMGP-NN) of the ecRad radiation scheme.

* [manuscript-2](manuscript-1) - Thesis Proposal Examination LaTeX sources

This work contains some parts adapted from the work of:

- Raissi et al. <https://github.com/maziarraissi/PINNs/>
- PySINDy. <https://pysindy.readthedocs.io/>
- Ukkonen et al. <https://github.com/peterukk/>
- And others.
