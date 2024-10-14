# RRTMGP

This sub-repository contains my personal notes on research and experiments related to radiation scheme for use in weather and climate models. The work is mainly based on: 

Ukkonen, P., & Hogan, R. J. (2023). Implementation of a machine-learned gas optics parameterization in the ECMWF Integrated Forecasting System: RRTMGP-NN 2.0. Geoscientific Model Development, 16(11), 3241–3261. <https://doi.org/10.5194/gmd-16-3241-2023>

The main idea is to replace the [RRTMGP](https://github.com/earth-system-radiation/rte-rrtmgp) lookup table with a PIML model.

## Notebooks

- [ukk23test01-train-v2.ipynb](ukk23test01-train-v2.ipynb) : continuation of `ukk23test01-train.ipynb`, adding more documentation, better organization, complete training, etc.

- [ukk23test01-train-v1.ipynb](ukk23test01-train-v1.ipynb) : generates files containing the neural network (NN) model that is later used in the RTE+RRTMGP-NN model. The implementation uses TensorFlow/Python for training the NN, and Fortran routines are used to generate the training dataset. 

- [ecrad01-gprof.ipynb](ecrad01-gprof.ipynb) : gprof of ecrad executable from ecrad dir.

- [ukk23eo01-gprof.ipynb](ukk23eo01-gprof.ipynb) : gprof of ecrad executable from ukk23eo01 dir (optimized version of ecRad radiation scheme with new RRTMGP-NN gas optics).

- [ukk23test01-rfmip-clear-sky.ipynb](ukk23test01-rfmip-clear-sky.ipynb) : runs the RFMIP-CLEAR-SKY example.

- [ecrad-01-sd-r240823.ipynb](ecrad-01-sd-r240823.ipynb) : shows the original ecRad radiation module using conventional numerical method, running on SDumont.

- [ukk23test01-train-sd-r240823.ipynb](ukk23test01-train-sd-r240823.ipynb)  : DNN network training for the optical gas radiation problem, running on SDumont. [work in progress]

## Files

- [ecrad-radiation-user-guide-2022.md](ecrad-radiation-user-guide-2022.md) : ecRad Radiation Scheme User Guide original document converted from PDF to Markdown:
  - Hogan, R. J. [ecRad radiation scheme: User Guide](https://confluence.ecmwf.int/download/attachments/70945505/ecrad_documentation.pdf?version=5&modificationDate=1655480733414&api=v2). Version 1.5 (June 2022) applicable to ecRad version 1.5.x.

## Directories

- [ukk23test01](ukk23test01) : based on <https://zenodo.org/records/7413935> [3] (see References)

- [ukk23eo01](ukk23eo01) : optimized version of ecRad radiation scheme with new RRTMGP-NN gas optics. Based on <https://github.com/peterukk/ecrad-opt>

- [ecrad](ecrad) : based on <https://github.com/ecmwf-ifs/ecrad>

- `.txt` and `.yml` : auxiliary files.

## Code and data

Due to size restrictions, the data is not present in this repository and must be obtained and installed from several sources:

- <https://zenodo.org/records/7413935>
- <https://zenodo.org/records/4030436>
- <https://zenodo.org/records/7413952>
- <https://zenodo.org/records/7852526>
- https://zenodo.org/records/5833494
- https://github.com/peterukk/rte-rrtmgp-nn

Description:

The repositories in <https://github.com/peterukk> contain code and also some data ( distributed across different repo branches). The RTE+RRTMGP-NN is available on:

- <https://github.com/peterukk/rte-rrtmgp-nn> (see also the repo branches)
- <https://doi.org/10.5281/zenodo.7413935> (Ukkonen, 2022) [1]
  - Redirects to: <https://zenodo.org/records/7413935> [code]. "peterukk/rte-rrtmgp-nn: 2.0".
* The Fortran programs and Python scripts used for data generation and model training are found in the directory `examples/rrtmgp-nn-training` .

The training data and archived version of RTE+RRTMGP-NN 2.0 with its training scripts can be accessed at

- <https://doi.org/10.5281/zenodo.6576680> (Ukkonen, 2022) [2]
  - Redirects to: <https://zenodo.org/records/7413952> [code and data].  "Code and extensive data for training neural networks for radiation, used in "Implementation of a machine-learned gas optics parameterization in the ECMWF Integrated Forecasting System: RRTMGP-NN 2.0" ".

The optimized version of the ecRad radiation scheme integrated with RRTMGP-NN 2.0 can be accessed at

- <https://doi.org/10.5281/zenodo.7148329> (Ukkonen, 2022) [3]
  - Redirects to: <https://zenodo.org/records/7852526> [code]. "Optimized version of the ecRad radiation scheme with new RRTMGP-NN gas optics.".

Peter Ukkonen. (2021). Training and evaluation data for machine learning models emulating the RTE+RRTMGP radiation scheme or its components. 

* https://doi.org/10.5281/zenodo.5833494
  
  * Redirects to: https://zenodo.org/records/5833494 [data]. "Training and evaluation data for machine learning models emulating the RTE+RRTMGP radiation scheme or its components.".

## Notes

- `*.nc` files are of the NetCDF4 type, and their structure can be viewed using the [ToolsUI](https://docs.unidata.ucar.edu/netcdf-java/current/userguide/reading_cdm.html) .

## References

[1] Ukkonen, P., Pincus, R., Hillman, B. R., Norman, M., fomics, & Heerwaarden, C. van. (2022). peterukk/rte-rrtmgp-nn: 2.0 (2.0) [Computer software]. Zenodo. <https://doi.org/10.5281/zenodo.7413935>

[2] Ukkonen, P. (2022). Code and extensive data for training neural networks for radiation, used in “Implementation of a machine-learned gas optics parameterization in the ECMWF Integrated Forecasting System: RRTMGP-NN 2.0”" [Dataset]. Zenodo. <https://doi.org/10.5281/zenodo.7413952> (<https://zenodo.org/records/7413952>)

[3] Ukkonen, P. (2022). Optimized version of the ecRad radiation scheme with new RRTMGP-NN gas optics [Computer software]. Zenodo. <https://doi.org/10.5281/zenodo.7852526> (<https://zenodo.org/records/7852526>)
