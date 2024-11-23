# Evaluation of the application of PIML and PINN methods

*Last edited: 2024-11-21*

This repository contains code, data, manuscripts, and other files used in my research on Physics-Informed Machine Learning (PIML) and Physics-Informed Neural Network (PINN) methods, which were used in the Qualifying Exams and Proposal. The research compared the accuracy and processing time of PINN and a standard numerical method (SINDy) on the inverse and forward problems for the 1D Burgers' problem, analyzed the impact of dataset size and hyperparameters on PINN performance, and generated a proposal for a study of the use of PIML in the radiation module of an atmospheric model.

Some case studies:

- Data-driven parameter discovery of one-dimensional Burgers' Equation using PINN.

- Evaluation of PIML and other methods applied to the RRTMGP gas optics scheme used in ECMWF's ecRad radiation module. (moved to <https://github.com/efurlanm/radnn>)

The idea of ​​this repo is to be a place for controlled experiments of new ideas and theories that emerge over time, evaluation of results, direct observation of implementations, review, correction, curiosities, and learning from mistakes. This repois a work in progress and is subject to constant change.

Description of some files and subdirectories:

- [Proposal-Radiation-PIML-240827.pdf](Proposal-Radiation-PIML-240827.pdf) Proposal Exam main document.

- [Proposal-Radiation-PIML-Presentation-240827.pdf](Proposal-Radiation-PIML-Presentation-240827.pdf) - Proposal Exam presentation.

- [Qualification-Data-Driven-Parameter-Discovery-240517.pdf](Qualification-Data-Driven-Parameter-Discovery-240517.pdf) - Qualification Exam main document.

- [Qualification-Parameter-Discovery-Presentation-240523.pdf](Qualification-Parameter-Discovery-Presentation-240523.pdf) - Qualification Exam presentation.

- [BurgersPINN](BurgersPINN) - case study of application of PINN in solving the Burgers' Equation .

- [manuscript-1](manuscript-1) - Qualification Exam LaTeX sources.

- [manuscript-2](manuscript-2) - Proposal Exam LaTeX sources.

This work is based on:

- Raissi et al. <https://github.com/maziarraissi/PINNs/>
- Ukkonen et al. <https://github.com/peterukk/>
- And others.

The acronym PD1B24 originally comes from the first studies entitled *PINN Discovery 1D Burgers 2024*.

