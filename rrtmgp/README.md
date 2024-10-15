# RRTMGP-NN

This sub-repository contains my personal notes on research, and experiments related to radiation scheme for use in weather and climate models. The work is mainly based on Ukkonen & Hogan (2023) [[4]](#ref04). The main idea of ​​the research is to replace the [RRTMGP](https://github.com/earth-system-radiation/rte-rrtmgp) lookup table with a PIML model.

## Notebooks

- [ukk23test01-train-v2.ipynb](ukk23test01-train-v2.ipynb) : continuation of `ukk23test01-train.ipynb`, adding more documentation, better organization, complete training, etc.

- [ukk23test01-train-v1.ipynb](ukk23test01-train-v1.ipynb) : generates files containing the neural network (NN) model that is later used in the RTE+RRTMGP-NN model. The implementation uses TensorFlow/Python for training the NN, and Fortran routines are used to generate the training dataset. 

- [ecrad01-gprof.ipynb](ecrad01-gprof.ipynb) : gprof of ecrad executable from ecrad dir.

- [ukk23eo01-gprof.ipynb](ukk23eo01-gprof.ipynb) : gprof of ecrad executable from ukk23eo01 dir (optimized version of ecRad radiation scheme with new RRTMGP-NN gas optics).

- [ukk23test01-rfmip-clear-sky.ipynb](ukk23test01-rfmip-clear-sky.ipynb) : runs the RFMIP-CLEAR-SKY example.

- [ecrad-01-sd-r240823.ipynb](ecrad-01-sd-r240823.ipynb) : shows the original ecRad radiation module using conventional numerical method, running on SDumont.

- [ukk23test01-train-sd-r240823.ipynb](ukk23test01-train-sd-r240823.ipynb) : DNN network training for the optical gas radiation problem, running on SDumont. (work in progress)

## Directories

- [ukk23test01](ukk23test01) : my tests directory. Contains the sub-dir /examples/rrtmgp-nn-training with the implementation for training gas optics NN. Based on [[1]](#ref01) .
  - Files corresponding to the article (Ukkonen, 2023) describing the implementation of RRTMGP-NN in ecRad, and prognostic tests in IFS.

- [ukk23eo01](ukk23eo01) : my tests directory. Contains the optimized version of the ecRad radiation scheme, with the new RRTMGP-NN gas optics. Does not contain the implementation that does the NN training. Based on
  
  - <https://github.com/peterukk/ecrad-opt>
  - "(...) the most up-to-date optimized ecRad code, see branch `clean_no_opt_testing` in this github repo (...)" .
  - The repository is referenced in [[3]](#ref03) .

- [ecrad](ecrad) : original ecRad repo, without NN. Based on
  
  - <https://github.com/ecmwf-ifs/ecrad>

## Files

- [ecrad-radiation-user-guide-2022.md](ecrad-radiation-user-guide-2022.md) : ecRad Radiation Scheme User Guide original document converted from PDF to Markdown:
  
  - Hogan, R. J. [ecRad radiation scheme: User Guide](https://confluence.ecmwf.int/download/attachments/70945505/ecrad_documentation.pdf?version=5&modificationDate=1655480733414&api=v2). Version 1.5 (June 2022) applicable to ecRad version 1.5.x .

- `*.txt` and `*.yml` are auxiliary files.

- `*.nc` files are of the NetCDF4 type, and their structure can be viewed using the [ToolsUI](https://docs.unidata.ucar.edu/netcdf-java/current/userguide/reading_cdm.html) .

## Code and data

Due to size restrictions, the data is not present in this repository and must be obtained and installed from several sources:

- <https://zenodo.org/records/7413935>
- <https://zenodo.org/records/4030436>
- <https://zenodo.org/records/7413952>
- <https://zenodo.org/records/7852526>
- <https://zenodo.org/records/5833494>
- <https://github.com/peterukk/rte-rrtmgp-nn>

Description:

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

Peter Ukkonen. (2021). Training and evaluation data for machine learning models emulating the RTE+RRTMGP radiation scheme or its components. 

- <https://doi.org/10.5281/zenodo.5833494>
  - Redirects to: <https://zenodo.org/records/5833494> . "Training and evaluation data for machine learning models emulating the RTE+RRTMGP radiation scheme or its components." .

## Notes

1. From <https://github.com/peterukk/rte-rrtmgp-nn/tree/2.0> : "Instead of the original lookup-table interpolation routine and "eta" parameter to handle the overlapping absorption of gases in a given band, this fork implements neural networks (NNs) to predict optical properties for given atmospheric conditions and gas concentrations, which includes all minor longwave (LW) gases supported by RRTMGP. The NNs predict molecular absorption (LW/SW), scattering (SW) or emission (LW) for all spectral points from an input vector consisting of temperature, pressure and gas concentrations of an atmospheric layer. The models have been trained on 6-7 million samples (LW) spanning a wide range of conditions (pre-industrial, present-day, future...) so that they may be used for both weather and climate applications."

2. From <https://zenodo.org/records/7413952> :
   
   1. The files contain datasets for training neural network versions of the RRTMGP gas optics scheme (as described in the paper) that are read by `ml_train.py`.
   2. The ML datasets were generated using the input profiles datasets and running the Fortran programs `rrtmgp_sw_gendata_rfmipstyle.F90` and `rrtmgp_lw_gendata_rfmipstyle.F90` in `rte-rrtmgp-nn/examples/rrtmgp-nn-training`, which call the RRTMGP gas optics scheme.

## Some references

<a id="ref01"></a>[1] Ukkonen, P., et al. (2022). peterukk/rte-rrtmgp-nn: 2.0 (2.0) .

- <https://doi.org/10.5281/zenodo.7413935>
- <https://github.com/peterukk/rte-rrtmgp-nn/tree/2.0>

<a id="ref02"></a>[2] Ukkonen, P. (2022). Code and extensive data for training neural networks for radiation, used in “Implementation of a machine-learned gas optics parameterization in the ECMWF Integrated Forecasting System: RRTMGP-NN 2.0” ".

- <https://doi.org/10.5281/zenodo.7413952>
  - <https://zenodo.org/records/7413952>

<a id="ref03"></a>[3] Ukkonen, P. (2022). Optimized version of the ecRad radiation scheme with new RRTMGP-NN gas optics.

- <https://doi.org/10.5281/zenodo.7852526>
  - <https://zenodo.org/records/7852526>

<a id="ref04"></a>[4] Ukkonen, P., & Hogan, R. J. (2023). Implementation of a machine-learned gas optics parameterization in the ECMWF Integrated Forecasting System: RRTMGP-NN 2.0. Geoscientific Model Development, 16(11), 3241–3261.

- <https://doi.org/10.5194/gmd-16-3241-2023>
  - <https://gmd.copernicus.org/articles/16/3241/2023/>
