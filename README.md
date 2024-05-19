# PINN Discovery 1D Burgers 2024 (PD1B24)

*Last edited: 2024-05-17*

This repository contains the code, data, manuscript, and other files used in the research entitled *Data-driven Parameter Discovery of One-dimensional Burgers' Equation Using Physics-Informed Neural Network*. The description of some files used are below:

* `Burgers-1D-Discovery-Numerical.ipynb` - 1D Burgers Data-Driven Parameter Discovery using PySINDy. Used in the first part of the work to compare the PINN and NM methods.

* `Burgers-1D-Discovery-PINN.ipynb` - 1D Burgers Data-Driven Parameter Discovery using PINN. Used in the first part of the work to compare the PINN and NM methods.

* `Burgers-1D-Parameters-PINN.ipynb` - Notebook used in the second part of the work, which evaluates accuracy and performance depending on network parameters.

* `Burgers-1D-Exact-Solution.ipynb` - 1D Burgers Exact Solution using the Gaussian Quadrature Method (GQM)

* `*-environment.txt` - spec files for the purpose of recreating a [Conda environment](<https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html>) identical to the one used in the experiments.

This repository contains some parts adapted from the work of Raissi et al. (2019) <https://github.com/maziarraissi/PINNs/>, and also from the PySINDy examples <https://pysindy.readthedocs.io/>.
