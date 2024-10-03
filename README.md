# PIML Radiation and PINN Discovery 1D Burgers 2024 (PD1B24)

*Last edited: 2024-08-23*

This repository contains the code, data, manuscripts, and other files used in the research:

- *Data-driven Parameter Discovery of One-dimensional Burgers' Equation Using Physics-Informed Neural Network*

- *Implementation of the ecRad Radiation Module using Physics Informed Machine Learning*

It is a work in progress and subject to constant changes.

Description of some files and directories:

- [ecrad-01-sd-20240823.ipynb](ecrad-01-sd-20240823.ipynb) - shows the original ecRad radiation module using conventional numerical method, running on SDumont.

- [ukk23test01-train-sd-20240823.ipynb](ukk23test01-train-sd-20240823.ipynb) - DNN network training for the optical gas radiation problem, running on SDumont.

- [Burgers-1D-Discovery-Numerical.ipynb](Burgers-1D-Discovery-Numerical.ipynb) - 1D Burgers Data-Driven Parameter Discovery using PySINDy. Used in the first part of the work to compare the PINN and NM methods.

- [Burgers-1D-Discovery-PINN.ipynb](Burgers-1D-Discovery-PINN.ipynb) - 1D Burgers Data-Driven Parameter Discovery using PINN. Used in the first part of the work to compare the PINN and NM methods.

- [Burgers-1D-Parameters-PINN.ipynb](Burgers-1D-Parameters-PINN.ipynb) - Notebook used in the second part of the work, which evaluates accuracy and performance depending on network parameters.

- [Burgers-1D-Exact-Solution.ipynb](Burgers-1D-Exact-Solution.ipynb) - 1D Burgers Exact Solution using the Gaussian Quadrature Method (GQM)

- [1D_Burgers_Data_Driven_Parameter_Discovery.odp](1D_Burgers_Data_Driven_Parameter_Discovery.odp) - Presentation

- [manuscript-1](manuscript-1) - Qualification Exam LaTeX sources

- [ukk23](ukk23) - Notes on the use of PINN in gas optics radiation scheme

- [ktuner](ktuner) - Notes on using Keras Tuner

- [manuscript-2](manuscript-1) - Thesis Proposal Examination LaTeX sources

- `*-environment.txt` - spec files for the purpose of recreating a [Conda environment](<https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html>) identical to the one used in the experiments


This work contains some parts adapted from the works of:

- Raissi et al. <https://github.com/maziarraissi/PINNs/>
- PySINDy. <https://pysindy.readthedocs.io/>
- Ukkonen et al. <https://github.com/peterukk/>
- And others.
