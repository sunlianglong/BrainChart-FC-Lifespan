# Functional connectome through the human life span


First revision date: 15/09/2023

Second revision date: 30/05/2024

E-mail: lianglongsun@mail.bnu.edu.cn


This repository provides code and source data that support the findings of the article entitled "Human lifespan changes in the brain’s functional connectome" by Sun et al. Nat Neurosci (2025). https://doi.org/10.1038/s41593-025-01907-4

### Data 
- Growth_curve_global_mean_of_FC.mat
  - The lifespan normative growth curve of the global mean of functional connectome
- Growth_curve_global_variance_of_FC.mat
  - The lifespan normative growth curve of the global variance of functional connectome
- Growth_curve_global_atlas_similarity.mat
  - The lifespan normative growth curve of the global atlas similarity (individual level)
- Growth_curve_global_system_segregation.mat
  - The lifespan normative growth curve of the global system segregation
- Growth_curve_VIS_system_segregation.mat
  - The lifespan normative growth curve of the system segregation of VIS network
- Growth_curve_SM_system_segregation.mat
  - The lifespan normative growth curve of the system segregation of SM network
- Growth_curve_DA_system_segregation.mat
  - The lifespan normative growth curve of the system segregation of DA network
- Growth_curve_VA_system_segregation.mat
  - The lifespan normative growth curve of the system segregation of VA network
- Growth_curve_LIM_system_segregation.mat
  - The lifespan normative growth curve of the system segregation of LIM network
- Growth_curve_FP_system_segregation.mat
  - The lifespan normative growth curve of the system segregation of FP network
- Growth_curve_DM_system_segregation.mat
  - The lifespan normative growth curve of the system segregation of DM network
&nbsp;
- Lifespan_growth_axis.fs4.L(R).func.gii
  - The lifespan growth axis (in fsaverage4 space) of brain functional connectivity, represented by the first principal component from a PCA on vertex-level FCS curves.
- Lifespan_growth_axis.fsLR32k.L(R).func.gii
  - The lifespan growth axis in fs_LR_32k space, ressampled from Lifespan_growth_axis.fs4.L(R).func.gii
- S-A_axis.fsLR32k.L(R).func.gii
  - The sensorimotor-association axis (in fs_LR_32k space), as formulated by Sydnor et al. [ Sydnor, V.J., et al. Neurodevelopment of the association cortices: Patterns, mechanisms, and implications for psychopathology. Neuron (2021) ]
- S-A_axis.fs4.L(R).func.gii 
  - The sensorimotor-association axis in fsaverage4 space, ressampled from S-A_axis.fsLR32k.L(R).func.gii

&nbsp;

### Age-specific Group Atlas

| Atlas                  | Age Range                | Atlas file in fsaverage4 space        | Atlas file in fs_LR_32k space          |
| ---------------------- | -------------------------- | ----------------------------------- | -------------------------------------- |
| 34-week atlas          | 32-35 postmenstrual weeks  | Atlas1_fs4_L(R).label.gii  | Atlas1_fsLR32k_L(R).label.gii  |
| 36-week atlas          | 35-37 postmenstrual weeks  | Atlas2_fs4_L(R).label.gii  | Atlas2_fsLR32k_L(R).label.gii  |
| 38-week atlas          | 37-39 postmenstrual weeks  | Atlas3_fs4_L(R).label.gii  | Atlas3_fsLR32k_L(R).label.gii  |
| 40-week (0-month) atlas | 39-41 postmenstrual weeks  | Atlas4_fs4_L(R).label.gii  | Atlas4_fsLR32k_L(R).label.gii  |
| 1-month atlas          | 0.25-1.5 months           | Atlas5_fs4_L(R).label.gii  | Atlas5_fsLR32k_L(R).label.gii  |
| 3-month atlas          | 1.5-4.5 months            | Atlas6_fs4_L(R).label.gii  | Atlas6_fsLR32k_L(R).label.gii  |
| 6-month atlas          | 4.5-7.5 months            | Atlas7_fs4_L(R).label.gii  | Atlas7_fsLR32k_L(R).label.gii  |
| 9-month atlas          | 7.5-10.5 months           | Atlas8_fs4_L(R).label.gii  | Atlas8_fsLR32k_L(R).label.gii  |
| 12-month atlas         | 10.5-13.5 months          | Atlas9_fs4_L(R).label.gii  | Atlas9_fsLR32k_L(R).label.gii  |
| 18-month atlas         | 13.5-21 months            | Atlas10_fs4_L(R).label.gii | Atlas10_fsLR32k_L(R).label.gii |
| 24-month atlas         | 21-27 months              | Atlas11_fs4_L(R).label.gii | Atlas11_fsLR32k_L(R).label.gii |
| 4-year atlas           | 2.25-5 years              | Atlas12_fs4_L(R).label.gii | Atlas12_fsLR32k_L(R).label.gii |
| 6-year atlas           | 5-7 years                 | Atlas13_fs4_L(R).label.gii | Atlas13_fsLR32k_L(R).label.gii |
| 8-year atlas           | 7-9 years                 | Atlas14_fs4_L(R).label.gii | Atlas14_fsLR32k_L(R).label.gii |
| 10-year atlas          | 9-11 years                | Atlas15_fs4_L(R).label.gii | Atlas15_fsLR32k_L(R).label.gii |
| 12-year atlas          | 11-13 years               | Atlas16_fs4_L(R).label.gii | Atlas16_fsLR32k_L(R).label.gii |
| 14-year atlas          | 13-15 years               | Atlas17_fs4_L(R).label.gii | Atlas17_fsLR32k_L(R).label.gii |
| 16-year atlas          | 15-17 years               | Atlas18_fs4_L(R).label.gii | Atlas18_fsLR32k_L(R).label.gii |
| 18-year atlas          | 17-19 years               | Atlas19_fs4_L(R).label.gii | Atlas19_fsLR32k_L(R).label.gii |
| 20-year atlas          | 19-21 years               | Atlas20_fs4_L(R).label.gii | Atlas20_fsLR32k_L(R).label.gii |
| 30-year atlas          | 25-35 years               | Atlas21_fs4_L(R).label.gii | Atlas21_fsLR32k_L(R).label.gii |
| 40-year atlas          | 35-45 years               | Atlas22_fs4_L(R).label.gii | Atlas22_fsLR32k_L(R).label.gii |
| 50-year atlas          | 45-55 years               | Atlas23_fs4_L(R).label.gii | Atlas23_fsLR32k_L(R).label.gii |
| 60-year atlas          | 55-65 years               | Atlas24_fs4_L(R).label.gii | Atlas24_fsLR32k_L(R).label.gii |
| 70-year atlas          | 65-75 years               | Atlas25_fs4_L(R).label.gii | Atlas25_fsLR32k_L(R).label.gii |
| 80-year atlas          | 75-80 years               | Atlas26_fs4_L(R).label.gii | Atlas26_fsLR32k_L(R).label.gii |

&nbsp;

### Code
#### Quality control for raw images
- MRIQC v0.15.0 (https://github.com/nipreps/mriqc)
#### Data preprocessing
- QuNex v0.93.2 (https://gitlab.qunex.yale.edu/)
- HCP pipeline v4.4.0-rc-MOD-e7a6af9 (https://github.com/Washington-University/HCPpipelines/releases)
- ABCD-HCP pipeline v1 (https://github.com/DCAN-Labs/abcd-hcp-pipeline)
- dHCP structural pipeline v1 (https://github.com/BioMedIA/dhcp-structural-pipeline)
- dHCP functional pipeline v1 (https://git.fmrib.ox.ac.uk/seanf/dhcp-neonatal-fmri-pipeline)
- iBEAT pipeline v1.0.0 (https://github.com/iBEAT-V2/iBEAT-V2.0-Docker)
#### Data postprocessing
- MATLAB R2018b (https://www.mathworks.com/products/matlab.html)
- SPM12 toolbox v6470 (https://www.fil.ion.ucl.ac.uk/spm/software/spm12)
- GRETNA toolbox v2.0.0 (https://www.nitrc.org/projects/gretna)
- cifti-matlab toolbox v2 (https://github.com/Washington-University/cifti-matlab)
#### for-Population-Level-Atlases
- Atlas_Construction
  - Preparation Information for subjects: data paths, age information, age-specific individual variability map, and age-specific tSNR map.
- Adult-based group atlas
- Atlas_Generation.m
  - To establish a series of age-specific group-level atlases with accurate system correspondences over the lifespan, we proposed a Gaussian-weighted iterative age-specific group atlas (GIAGA) generation approach. For detailed information, please refer to https://www.nature.com/articles/s41593-025-01907-4
  - Before running this code, you need to prepare at least one set of individual BOLD data in the fsaverage4 space.
#### for-Individualized-Atlases
- fun_Run_IndiPara_for_Each_Indi.m
  - Using the individualized parcellation method proposed by Wang et al. [ Wang, D., et al. Parcellating cortical functional networks in individuals. Nature Neuroscience 18, 1853-1860 (2015) ], we generate person-specific parcellation atlas for each individual.
  - Before running this code, you need to prepare at least one set of individual BOLD data in the fsaverage4 space.
#### for-Normative-Modeling
- GAMLSS_model_fitting.ipynb
  - R function for GAMLSS model specification and estimation
  - R v4.2.0 (https://www.r-project.org)
  - GAMLSS package v5.4-3 (https://www.gamlss.com/)
- data.csv
  - The data to be loaded when running GAMLSS_model_fitting.ipynb
- Model_global system segregation.RData
  - Precomputed model
#### for-Visualization
- plot_1_Normative_Growth_Curve.m
  - Plot the normative growth curve
- plot_2_Normative_Growth_Rate.m
  - Plot the growth rate
- plot_3_Normative_Growth_Curve_female_male.m
  - Plot the normative growth curve for famale and male
- MATLAB R2018b (https://www.mathworks.com/products/matlab.html)
- BrainNet Viewer toolbox v 20191031 (https://www.nitrc.org/projects/bnv)
- Connectome Workbench v1.5.0 (https://www.humanconnectome.org/software/connectome-workbench)
- R v4.2.0 (https://www.r-project.org)
- ggplot2 package v3.4.2 (https://ggplot2.tidyverse.org/)
#### Functions_Masks_Templates
- Essential libraries required for running the code

