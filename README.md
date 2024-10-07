# Evaluation of the application of PIML and PINN methods

*Last edited: 2024-10-07*

This repository contains code, data, manuscripts, and other files used in my research on PIML (Physics-Informed Machine Learning) and PINN (Physics-Informed Neural Network) methods. Some case studies used in the study:

- Data-driven Parameter Discovery of One-dimensional Burgers' Equation Using Physics-Informed Neural Network.

- Evaluation of physics-based machine learning (PIML) and other methods applied to the RRTMGP gas optics scheme used in ECMWF's ecRad radiation module.

The acronym PD1B24 originally comes from the first studies entitled *PINN Discovery 1D Burgers 2024*.

This repository is a work in progress and is subject to constant change.

Description of some files and subdirectories. More information can be found inside the subdirectories:

- [BurgersPINN](BurgersPINN) - case study of application of PINN in solving the Burgers' Equation 

- [RRTMGP](RRTMGP) - case study of application of PIML in RRTMGP gas optics scheme.

- [ecrad-01-sd-20240823.ipynb](ecrad-01-sd-20240823.ipynb) - shows the original ecRad radiation module using conventional numerical method, running on SDumont.

- [ukk23test01-train-sd-20240823.ipynb](ukk23test01-train-sd-20240823.ipynb) - DNN network training for the optical gas radiation problem, running on SDumont.

- [Burgers-1D-Discovery-Numerical.ipynb](Burgers-1D-Discovery-Numerical.ipynb) - 1D Burgers Data-Driven Parameter Discovery using PySINDy. Used in the first part of the work to compare the PINN and NM methods.

- [Burgers-1D-Discovery-PINN.ipynb](Burgers-1D-Discovery-PINN.ipynb) - 1D Burgers Data-Driven Parameter Discovery using PINN. Used in the first part of the work to compare the PINN and NM methods.

- [Burgers-1D-Parameters-PINN.ipynb](Burgers-1D-Parameters-PINN.ipynb) - Notebook used in the second part of the work, which evaluates accuracy and performance depending on network parameters.

- [Burgers-1D-Exact-Solution.ipynb](Burgers-1D-Exact-Solution.ipynb) - 1D Burgers Exact Solution using the Gaussian Quadrature Method (GQM)

- [1D_Burgers_Data_Driven_Parameter_Discovery.odp](1D_Burgers_Data_Driven_Parameter_Discovery.odp) - Presentation

- [manuscript-1](manuscript-1) - Qualification Exam LaTeX sources

- [manuscript-2](manuscript-2) - Proposal Exam LaTeX sources

- [ktuner](ktuner) - Notes on using Keras Tuner

- 

This work is based on the works of:

- Raissi et al. <https://github.com/maziarraissi/PINNs/>
- Ukkonen et al. <https://github.com/peterukk/>
- And others.
