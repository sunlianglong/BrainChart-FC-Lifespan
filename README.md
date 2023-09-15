## BrainChart-FC-Lifespan


First revision date 15/9/2023


E-mail: lianglongsun@mail.bnu.edu.cn


This repository provides code and source data that support the findings of the article entitled "Functional connectome through the human life span" by Sun et al. (2023) bioRxiv. https://www.biorxiv.org/content/10.1101/2023.09.12.557193v1


### Brain-Charts Folder

- Trajectory_whole-brain_mean_FC.mat
  - The lifespan normative trajectory of the mean functional connectivity across the entire brain
- Trajectory_whole-brain_variance_FC.mat
  - The lifespan normative trajectory of the variance of functional connectivity across the entire brain
- Trajectory_whole-brain_atlas_similarity.mat
  - The lifespan normative trajectory of the whole-brain individualized atlas similarity
- Trajectory_whole-brain_system_segregation.mat
  - The lifespan normative trajectory of the whole-brain system segregation
- Trajectory_VIS_system_segregation.mat
  - The lifespan normative trajectory of the system segregation of VIS network
- Trajectory_SM_system_segregation.mat
  - The lifespan normative trajectory of the system segregation of SM network
- Trajectory_DA_system_segregation.mat
  - The lifespan normative trajectory of the system segregation of DA network
- Trajectory_VA_system_segregation.mat
  - The lifespan normative trajectory of the system segregation of VA network
- Trajectory_LIM_system_segregation.mat
  - The lifespan normative trajectory of the system segregation of LIM network
- Trajectory_FP_system_segregation.mat
  - The lifespan normative trajectory of the system segregation of FP network
- Trajectory_DM_system_segregation.mat
  - The lifespan normative trajectory of the system segregation of DM network

&nbsp;

- Lifespan_axis.fs4.L.func.gii & Lifespan_axis.fs4.R.func.gii
  - The life-cycle developmental axis across the whole cortical brain in fsaverage4 space
- Lifespan_axis.fsLR32k.L.func.gii & Lifespan_axis.fsLR32k.R.func.gii
  - The life-cycle developmental axis across the whole cortical brain in fs_LR_32k space
- S-A_axis.fsLR32k.L.func.gii & S-A_axis.fsLR32k.R.func.gii
  - The sensorimotor-association axis across the whole cortical brain in fs_LR_32k space, as formulated by Sydnor et al. [ Sydnor, V.J., et al. Neurodevelopment of the association cortices: Patterns, mechanisms, and implications for psychopathology. Neuron (2021) ]
- S-A_axis.fs4.L.func.gii & S-A_axis.fs4.R.func.gii
  - The sensorimotor-association axis across the whole cortical brain in fsaverage4 space, ressampled from S-A_axis.fsLR32k.L.func.gii & S-A_axis.fsLR32k.R.func.gii

&nbsp;

- plot_Normative_Trajectory.m
  - Plot the normative trajectory
- plot_Normative_Trajectory_female_male.m
  - Plot the normative trajectory of famale and male, respectively
- plot_Rate_of_Change.m
  - Plot the growth rate

&nbsp;

### Population-level-Atlas Folder

| Atlas                  | Age Range                | Atlas file in fsaverage4 space        | Atlas file in fs_LR_32k space          |
| ---------------------- | -------------------------- | ----------------------------------- | -------------------------------------- |
| 34-week atlas          | 32-35 postmenstrual weeks  | Atlas1_FinalAtlas_fs4_L(R).label.gii  | Atlas1_FinalAtlas_fsLR32k_L(R).label.gii  |
| 36-week atlas          | 35-37 postmenstrual weeks  | Atlas2_FinalAtlas_fs4_L(R).label.gii  | Atlas2_FinalAtlas_fsLR32k_L(R).label.gii  |
| 38-week atlas          | 37-39 postmenstrual weeks  | Atlas3_FinalAtlas_fs4_L(R).label.gii  | Atlas3_FinalAtlas_fsLR32k_L(R).label.gii  |
| 0-year (40-week) atlas | 39-41 postmenstrual weeks  | Atlas4_FinalAtlas_fs4_L(R).label.gii  | Atlas4_FinalAtlas_fsLR32k_L(R).label.gii  |
| 1-month atlas          | 0.25-1.5 months           | Atlas5_FinalAtlas_fs4_L(R).label.gii  | Atlas5_FinalAtlas_fsLR32k_L(R).label.gii  |
| 3-month atlas          | 1.5-4.5 months            | Atlas6_FinalAtlas_fs4_L(R).label.gii  | Atlas6_FinalAtlas_fsLR32k_L(R).label.gii  |
| 6-month atlas          | 4.5-7.5 months            | Atlas7_FinalAtlas_fs4_L(R).label.gii  | Atlas7_FinalAtlas_fsLR32k_L(R).label.gii  |
| 9-month atlas          | 7.5-10.5 months           | Atlas8_FinalAtlas_fs4_L(R).label.gii  | Atlas8_FinalAtlas_fsLR32k_L(R).label.gii  |
| 12-month atlas         | 10.5-13.5 months          | Atlas9_FinalAtlas_fs4_L(R).label.gii  | Atlas9_FinalAtlas_fsLR32k_L(R).label.gii  |
| 18-month atlas         | 13.5-21 months            | Atlas10_FinalAtlas_fs4_L(R).label.gii | Atlas10_FinalAtlas_fsLR32k_L(R).label.gii |
| 24-month atlas         | 21-27 months              | Atlas11_FinalAtlas_fs4_L(R).label.gii | Atlas11_FinalAtlas_fsLR32k_L(R).label.gii |
| 4-year atlas           | 2.25-5 years              | Atlas12_FinalAtlas_fs4_L(R).label.gii | Atlas12_FinalAtlas_fsLR32k_L(R).label.gii |
| 6-year atlas           | 5-7 years                 | Atlas13_FinalAtlas_fs4_L(R).label.gii | Atlas13_FinalAtlas_fsLR32k_L(R).label.gii |
| 8-year atlas           | 7-9 years                 | Atlas14_FinalAtlas_fs4_L(R).label.gii | Atlas14_FinalAtlas_fsLR32k_L(R).label.gii |
| 10-year atlas          | 9-11 years                | Atlas15_FinalAtlas_fs4_L(R).label.gii | Atlas15_FinalAtlas_fsLR32k_L(R).label.gii |
| 12-year atlas          | 11-13 years               | Atlas16_FinalAtlas_fs4_L(R).label.gii | Atlas16_FinalAtlas_fsLR32k_L(R).label.gii |
| 14-year atlas          | 13-15 years               | Atlas17_FinalAtlas_fs4_L(R).label.gii | Atlas17_FinalAtlas_fsLR32k_L(R).label.gii |
| 16-year atlas          | 15-17 years               | Atlas18_FinalAtlas_fs4_L(R).label.gii | Atlas18_FinalAtlas_fsLR32k_L(R).label.gii |
| 18-year atlas          | 17-19 years               | Atlas19_FinalAtlas_fs4_L(R).label.gii | Atlas19_FinalAtlas_fsLR32k_L(R).label.gii |
| 20-year atlas          | 19-21 years               | Atlas20_FinalAtlas_fs4_L(R).label.gii | Atlas20_FinalAtlas_fsLR32k_L(R).label.gii |
| 30-year atlas          | 25-35 years               | Atlas21_FinalAtlas_fs4_L(R).label.gii | Atlas21_FinalAtlas_fsLR32k_L(R).label.gii |
| 40-year atlas          | 35-45 years               | Atlas22_FinalAtlas_fs4_L(R).label.gii | Atlas22_FinalAtlas_fsLR32k_L(R).label.gii |
| 50-year atlas          | 45-55 years               | Atlas23_FinalAtlas_fs4_L(R).label.gii | Atlas23_FinalAtlas_fsLR32k_L(R).label.gii |
| 60-year atlas          | 55-65 years               | Atlas24_FinalAtlas_fs4_L(R).label.gii | Atlas24_FinalAtlas_fsLR32k_L(R).label.gii |
| 70-year atlas          | 65-75 years               | Atlas25_FinalAtlas_fs4_L(R).label.gii | Atlas25_FinalAtlas_fsLR32k_L(R).label.gii |
| 80-year atlas          | 75-80 years               | Atlas26_FinalAtlas_fs4_L(R).label.gii | Atlas26_FinalAtlas_fsLR32k_L(R).label.gii |

### Code Folder
