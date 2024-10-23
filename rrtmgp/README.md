# RRTMGP-NN

*Last edited: 2024-10-17*

This (sub)repository contains my personal notes on research, and experiments related to radiation scheme for use in weather and climate models. The work is mainly based on Ukkonen & Hogan (2023) [[4]](#ref04). The main idea of ​​the research is to replace the [RRTMGP](https://github.com/earth-system-radiation/rte-rrtmgp) lookup table with a PIML model.

## Notebooks

Unsorted list

- [ukk23test01-train-v2.ipynb](ukk23test01-train-v2.ipynb) : continuation of `ukk23test01-train-v1.ipynb`, adding more documentation, better organization, complete training, etc.

- [ukk23test01-train-v1.ipynb](ukk23test01-train-v1.ipynb) : generates files containing the neural network (NN) model that is later used in the RTE+RRTMGP-NN model. The implementation uses TensorFlow/Python for training the NN, and Fortran routines are used to generate the training dataset. Based on [[1]](#ref01).

- [ukk23test01-rfmip-clear-sky.ipynb](ukk23test01-rfmip-clear-sky.ipynb) : runs the RFMIP-CLEAR-SKY example, described in [[1]](#ref01).

- [ecrad01-gprof.ipynb](ecrad01-gprof.ipynb) : gprof of ecrad executable from ecrad dir.

- [ukk23eo01-gprof.ipynb](ukk23eo01-gprof.ipynb) : gprof of ecrad executable from ukk23eo01 dir (optimized version of ecRad radiation scheme with new RRTMGP-NN gas optics).

- [ecrad-01-sd-v240823.ipynb](ecrad-01-sd-v240823.ipynb) : shows the original ecRad radiation module using conventional numerical method, running on SDumont. {work in progress}

- [ukk23test01-train-sd-v240823.ipynb](ukk23test01-train-sd-v240823.ipynb) : DNN network training for the optical gas radiation problem, running on SDumont. {work in progress}

- [jn_rrtmgp_rfmip_lw.ipynb](rrtmgp_rfmip_lw.ipynb) : Example program to demonstrate the calculation of longwave radiative fluxes in clear, aerosol-free skies. Based on ´rfmip-clear-sky/rrtmgp_rfmip_lw.F90`. {work in progress}

Note: the Table of Contents for each Notebook is automatically generated when opened by JupyterLab by selecting the *View > Table of Contents* menu item, or by pressing Ctrl+Shift-K.

## Directories

- [ukk23test01](ukk23test01) : my tests directory. Contains the sub-dir `/examples/rrtmgp-nn-training` with the implementation for training gas optics NN. Based on [[1]](#ref01) .
  
  - Files corresponding to the paper (Ukkonen, 2023) describing the implementation of RRTMGP-NN in ecRad.

- [ukk23eo01](ukk23eo01) : my tests directory. Contains the optimized version of the ecRad radiation scheme, with the new RRTMGP-NN gas optics (similar to ukk23test01). Does not contain the implementation that does the NN training. Based on:
  
  - <https://github.com/peterukk/ecrad-opt>
    
    - "(...) the most up-to-date optimized ecRad code, see branch `clean_no_opt_testing` in this github repo (...)" .

- [ecrad](ecrad) : original ecRad repo, without NN. Based on:
  
  - <https://github.com/ecmwf-ifs/ecrad>

## Files

- [ecrad-radiation-user-guide-2022.md](ecrad-radiation-user-guide-2022.md) : ecRad Radiation Scheme User Guide original document converted from PDF to Markdown:
  
  - Hogan, R. J. [ecRad radiation scheme: User Guide](https://confluence.ecmwf.int/download/attachments/70945505/ecrad_documentation.pdf?version=5&modificationDate=1655480733414&api=v2). Version 1.5 (June 2022) applicable to ecRad version 1.5.x .

- `*.txt` and `*.yml` are auxiliary files.

- `*.nc` files are of type NetCDF4 and can be browsed and their structure visualized using the Java tool [ToolsUI](https://docs.unidata.ucar.edu/netcdf-java/current/userguide/reading_cdm.html) or the Python library [netcdf4-python](https://github.com/Unidata/netcdf4-python).

- `env.md` :  briefly describes the installation of the Conda environment used in Notebooks.

## Code and data

Due to size restrictions, the data is not present in this repository and must be obtained and installed from several sources:

- <https://zenodo.org/records/7413935>

- <https://zenodo.org/records/7413952>

- <https://zenodo.org/records/7852526>

- <https://zenodo.org/records/4030436>

- <https://zenodo.org/records/5833494>

- <https://github.com/peterukk/rte-rrtmgp-nn>

The repositories in <https://github.com/peterukk> contain code and also some data (distributed across different repo branches). The RTE+RRTMGP-NN is available on

- <https://github.com/peterukk/rte-rrtmgp-nn> (see also the repo branches).

- <https://doi.org/10.5281/zenodo.7413935> (Ukkonen, 2022) [[1]](#ref01)
  
  - Redirects to: <https://zenodo.org/records/7413935> . "peterukk/rte-rrtmgp-nn: 2.0" .

- The Fortran programs and Python scripts used for data generation and model training are found in the directory `examples/rrtmgp-nn-training` .

The training data and archived version of RTE+RRTMGP-NN 2.0 with its training scripts can be accessed at

- <https://doi.org/10.5281/zenodo.6576680> (Ukkonen, 2022) [[2]](#ref02)
  
  - Redirects to: <https://zenodo.org/records/7413952> .  "Code and extensive data for training neural networks for radiation, used in "Implementation of a machine-learned gas optics parameterization in the ECMWF Integrated Forecasting System: RRTMGP-NN 2.0" " .

The optimized version of the ecRad radiation scheme integrated with RRTMGP-NN 2.0 can be accessed at

- <https://doi.org/10.5281/zenodo.7148329> (Ukkonen, 2022) [[3]](#ref03)
  
  - Redirects to: <https://zenodo.org/records/7852526> . "Optimized version of the ecRad radiation scheme with new RRTMGP-NN gas optics." .

Ukkonen (2021) training and evaluation data for machine learning models emulating the RTE+RRTMGP radiation scheme or its components. 

- <https://doi.org/10.5281/zenodo.5833494>
  
  - Redirects to: <https://zenodo.org/records/5833494> . "Training and evaluation data for machine learning models emulating the RTE+RRTMGP radiation scheme or its components." .

Ukkonen (2020) code and data for the paper [[5]](#ref05). Supplementary Python code and data used to train NN.

- <https://zenodo.org/records/4030436>

## Notes

1. From <https://github.com/peterukk/rte-rrtmgp-nn/tree/2.0> :
   
   1. Instead of the original lookup-table interpolation routine and "eta" parameter to handle the overlapping absorption of gases in a given band, this fork implements neural networks (NNs) to predict optical properties for given atmospheric conditions and gas concentrations, which includes all minor longwave (LW) gases supported by RRTMGP. The NNs predict molecular absorption (LW/SW), scattering (SW) or emission (LW) for all spectral points from an input vector consisting of temperature, pressure and gas concentrations of an atmospheric layer. The models have been trained on 6-7 million samples (LW) spanning a wide range of conditions (pre-industrial, present-day, future...) so that they may be used for both weather and climate applications.

2. From <https://zenodo.org/records/7413952> :
   
   1. The files contain datasets for training neural network versions of the RRTMGP gas optics scheme (as described in the paper) that are read by `ml_train.py`.
   
   2. The ML datasets were generated using the input profiles datasets and running the Fortran programs `rrtmgp_sw_gendata_rfmipstyle.F90` and `rrtmgp_lw_gendata_rfmipstyle.F90` in `rte-rrtmgp-nn/examples/rrtmgp-nn-training`, which call the RRTMGP gas optics scheme.

## Main references

<a id="ref01">[1]</a> Ukkonen, P., et al. (Dec 8, 2022). "peterukk/rte-rrtmgp-nn: 2.0". (see [4]) (**code**) (includes NN trainning)

- <https://doi.org/10.5281/zenodo.7413935> (redirects to <https://zenodo.org/records/7413935>)

- <https://github.com/peterukk/rte-rrtmgp-nn/tree/2.0>

<a id="ref02">[2]</a> Ukkonen, P. (May 25, 2022). Data for training neural networks for radiation, used in [4]. (**data**)

- <https://doi.org/10.5281/zenodo.7413952> (redirects to <https://zenodo.org/records/7413952>)

<a id="ref03">[3]</a> Ukkonen, P. (Oct 5, 2022). Optimized version of the ecRad radiation scheme with new RRTMGP-NN gas optics. (code and data) (does not include the NN training)

- <https://doi.org/10.5281/zenodo.7852526> (redirects to <https://zenodo.org/records/7852526>)
- Code: <https://github.com/peterukk/ecrad-opt/tree/clean_no_opt_testing>

<a id="ref04">[4]</a> Ukkonen, P., & Hogan, R. J. (2023). *Implementation of a machine-learned gas optics parameterization in the ECMWF Integrated Forecasting System: RRTMGP-NN 2.0*. Geoscientific Model Development, 16(11), 3241–3261. (main paper)

- <https://doi.org/10.5194/gmd-16-3241-2023> (redirects to <https://gmd.copernicus.org/papers/16/3241/2023>)

[5] Ukkonen, P., Pincus, R., Hogan, R. J., Pagh Nielsen, K., & Kaas, E. (2020). *Accelerating Radiation Computations for Dynamical Models With Targeted Machine Learning and Code Optimization*. Journal of Advances in Modeling Earth Systems, 12(12), e2020MS002226.

- https://doi.org/10.1029/2020MS002226 (redirects to https://agupubs.onlinelibrary.wiley.com/doi/10.1029/2020MS002226)
- <https://zenodo.org/records/4030436> (supplementary Python code and data used to train NN)
- https://zenodo.org/records/4029138 (RRTMGP-NN 2020 code and data. Is supplement to <https://github.com/peterukk/rte-rrtmgp-nn/tree/0.9>)

[6] Pincus, R., Mlawer, E. J., & Delamere, J. S. (2019). Balancing Accuracy, Efficiency, and Flexibility in Radiation Calculations for Dynamical Models. *Journal of Advances in Modeling Earth Systems*, *11*(10), 3074–3089. https://doi.org/10.1029/2019MS001621

- <https://github.com/RobertPincus/rte-rrtmgp> 
