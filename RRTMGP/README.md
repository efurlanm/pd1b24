# RRTMGP

This subrepository contains my research and experiment notes on the radiation scheme for use in weather and climate models. The main idea is to replace the [RRTMGP](https://github.com/earth-system-radiation/rte-rrtmgp) lookup table with a PIML model, based on:

- Ukkonen, P., & Hogan, R. J. (2023). Implementation of a machine-learned gas optics parameterization in the ECMWF Integrated Forecasting System: RRTMGP-NN 2.0. Geoscientific Model Development, 16(11), 3241–3261. <https://doi.org/10.5194/gmd-16-3241-2023>

## Notebooks

- [ukk23test01-train-r2.ipynb](ukk23test01-train-r2.ipynb) : continuation of `ukk23test01-train.ipynb`, adding more documentation, better organization, complete training, etc.

- [ukk23test01-train.ipynb](ukk23test01-train.ipynb) : generates files containing the neural network (NN) model that is later used in the RTE+RRTMGP-NN model. The implementation uses TensorFlow and Python, and Fortran routines are used to generate the training data set. The idea is to replace the RRTMGP lookup tables with NN.

- [ecrad01-gprof.ipynb](ecrad01-gprof.ipynb) : gprof of ecrad executable from ecrad dir.

- [ukk23eo01-gprof.ipynb](ukk23eo01-gprof.ipynb) : gprof of ecrad executable from ukk23eo01 dir.

- [ukk23test01-rfmip-clear-sky.ipynb](ukk23test01-rfmip-clear-sky.ipynb) : runs the RFMIP-CLEAR-SKY example.

- [ecrad-01-sd-r240823.ipynb](ecrad-01-sd-r240823.ipynb) : shows the original ecRad radiation module using conventional numerical method, running on SDumont.

- [ukk23test01-train-sd-r240823.ipynb](ukk23test01-train-sd-r240823.ipynb) [work in progress] : DNN network training for the optical gas radiation problem, running on SDumont.

## Files

- [ecRad radiation scheme User Guide - Hogan 2022.md](ecRad radiation scheme User Guide - Hogan 2022.md) : original document converted from PDF to Markdown.

## Subdirectories

- [ukk23test01](ukk23test01) : based on <https://zenodo.org/records/7413935> [3]

- [ukk23eo01](ukk23eo01) : based on <https://github.com/peterukk/ecrad-opt>

- [ecrad](ecrad) : based on <https://github.com/ecmwf-ifs/ecrad>

## Code and data

Due to size restrictions, the data is not present in this repository and must be obtained and installed from several sources:

- <https://zenodo.org/records/7413935>
- <https://zenodo.org/records/4030436>
- <https://doi.org/10.5281/zenodo.5833494>
- <https://zenodo.org/records/7413952>
- <https://zenodo.org/records/7852526>

The repositories in <https://github.com/peterukk> also contain code and data, which are distributed across different branches.

The RTE+RRTMGP-NN is available on GitHub:

- <https://github.com/peterukk/rte-rrtmgp-nn> (last access: 8 June 2023)
- <https://doi.org/10.5281/zenodo.7413935> (Ukkonen, 2022c) [1]
  - <https://zenodo.org/records/7413935> [code]

The Fortran programs and Python scripts used for data generation and model training are found in the subdirectory

- examples/rrtmgp-nn-training

The training data and archived version of RTE+RRTMGP-NN 2.0 with its training scripts can be accessed at

- <https://doi.org/10.5281/zenodo.6576680> (Ukkonen, 2022d) [2]
  - <https://zenodo.org/records/7413952> [code and data set]

The optimized version of the ecRad radiation scheme integrated with RRTMGP-NN 2.0 can be accessed at

- <https://doi.org/10.5281/zenodo.7148329> (Ukkonen, 2022e) [3]
  - <https://zenodo.org/records/7852526> [code]

## Notes

- The "*.nc" files are from NetCDF4 and their structure can be viewed using the [ToolsUI](https://docs.unidata.ucar.edu/netcdf-java/current/userguide/reading_cdm.html).

## References

[1] Ukkonen, P., Pincus, R., Hillman, B. R., Norman, M., fomics, & Heerwaarden, C. van. (2022c). peterukk/rte-rrtmgp-nn: 2.0 (2.0) [Computer software]. Zenodo. <https://doi.org/10.5281/zenodo.7413935>

[2] Ukkonen, P. (2022). Code and extensive data for training neural networks for radiation, used in “Implementation of a machine-learned gas optics parameterization in the ECMWF Integrated Forecasting System: RRTMGP-NN 2.0”" [Dataset]. Zenodo. <https://doi.org/10.5281/zenodo.7413952>

[3] Ukkonen, P. (2022). Optimized version of the ecRad radiation scheme with new RRTMGP-NN gas optics [Computer software]. Zenodo. <https://doi.org/10.5281/zenodo.7852526>
