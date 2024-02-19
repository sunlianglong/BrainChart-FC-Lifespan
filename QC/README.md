


## Purpose
This document is designed to give a detailed description of the visual-check imaging quality control process. By Lianglong Sun, used in his paper: Functional connectome through the human life span (2023) bioRxiv. https://www.biorxiv.org/content/10.1101/2023.09.12.557193v1.

## Overall image quality control process


![image](https://github.com/sunlianglong/BrainChart-FC-Lifespan/blob/main/QC/png/SI_Figure1_QC.png)



## Visual-check QC Details

To achieve a comprehensive quality control (QC), we employed a four-step data QC framework, integrating automated tools and expert manual evaluations for both structural and functional images across 46,870 scans. During the first three steps of quality control (QC) process (see Figure above), we have excluded 5,865 scans with structural imaging issues and 7,505 scans with functional imaging problems. To further ensure the quality of the remaining scans, we performed a detailed and comprehensive visual-check QC by convening a team of four anatomy-trained experts: Qian Wang, Qian Yu, Chenxuan Pang, and Lianglong Sun. For each participant who passed the first three steps of QC, we generated three 2-D pictures (one for structural images and two for functional images). Based on these images, Lianglong Sun undertook the initial visual QC of both structural and functional data for all participants, recording the IDs of those with quality issues. Subsequently, Qian Wang, Qian Yu, Chenxuan Pang performed a secondary visual review of all images, also documenting participants' IDs with observed quality issues. The union of these records determined the final list of excluded participants. Throughout the process, the QC team engaged in thorough discussions to ensure consistency in exclusion criteria among members. Participants were excluded if any of the following issues were present. Throughout the process, the QC team engaged in thorough discussions to ensure consistency in exclusion criteria among members.

The **structural images** were primarily checked for:
- artifacts
- quality of cortical segmentation
- quality of cortical reconstruction
- quality of myelination (measured by T1/T2 ratio) 
    - For participants with T2-weighted images, those exhibiting abnormal distribution (measured by T1/T2 ratio) were also excluded. 

The **functional images** were primarily checked for:
- incomplete brain coverage
- quality of functional registration
- quality of volume-to-surface mapping

### Instances of subjects with good quality

![image](https://github.com/sunlianglong/BrainChart-FC-Lifespan/blob/main/QC/png/QC_Example_1.PNG)

![image](https://github.com/sunlianglong/BrainChart-FC-Lifespan/blob/main/QC/png/QC_Example_2.PNG)

![image](https://github.com/sunlianglong/BrainChart-FC-Lifespan/blob/main/QC/png/QC_Example_3.PNG)

![image](https://github.com/sunlianglong/BrainChart-FC-Lifespan/blob/main/QC/png/QC_Example_4.PNG)

## Visual-check QC for structural images
### Structural images with artifacts
Subjects will be excluded if artifacts interfere with brain tissue segmentation. Blue lines represent the gray matter boundary, green lines represent the white-gray matter interface.

![image](https://github.com/sunlianglong/BrainChart-FC-Lifespan/blob/main/QC/png/QC_anat_1.PNG)

### Issues with quality of tissue segmentation
Examples of subjects with quality issues in cortical segmentation/reconstruction. Common issues include unrecognizable brain tissues, missing brain tissues, indistinguishable gray and white matter, indistinguishable gray matter and skull, and problems with surface-to-volume mapping.

![image](https://github.com/sunlianglong/BrainChart-FC-Lifespan/blob/main/QC/png/QC_anat_2.PNG)

### Issues with quality of surface reconstruction
Examples of subjects with quality issues in cortical surface. Each subplot is the visualization of the mid-thickness surface across four views: left lateral, right lateral, left medial, and right medial.

![image](https://github.com/sunlianglong/BrainChart-FC-Lifespan/blob/main/QC/png/QC_anat_3.PNG)

### Issues with quality of myelination distribution 
Examples of subjects with problematic myelination distribution.

![image](https://github.com/sunlianglong/BrainChart-FC-Lifespan/blob/main/QC/png/QC_anat_4.PNG)

## Visual-check QC for functional images
### incomplete brain coverage
Examples of subjects with incomplete BOLD signal coverage.

![image](https://github.com/sunlianglong/BrainChart-FC-Lifespan/blob/main/QC/png/QC_func_1.PNG)

### quality of functional registration
Individual fMRI data were first registered to each subject's structural space, then to standard space. The registration quality was assessed by visualizing the averaged fMRI images (background), fMRI image masks (purple outlines), and the boundaries of gray and white matter in structural images. Subjects failing to pass quality control are depicted.

![image](https://github.com/sunlianglong/BrainChart-FC-Lifespan/blob/main/QC/png/QC_func_2.PNG)

### quality of volume-to-surface mapping
Visualization of mean BOLD data mapped from volume space to the surface, showcasing examples that failed the quality check.

![image](https://github.com/sunlianglong/BrainChart-FC-Lifespan/blob/main/QC/png/QC_func_3.PNG)


