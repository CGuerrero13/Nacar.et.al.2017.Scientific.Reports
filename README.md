# Nacar.et.al.2017.Scientific.Reports
Code repository and databases of the submitted paper: "You sound familiar to me! Evoked and oscillatory EEG activity differentiates language discrimination in young monolingual and bilingual infants"-Scientific Report.

The scripts (in Matlab) are divided in two parts:
- Stat analysis and plot figures,
- and feature extractions (ERPs and TFD segments)

To visualize statistic results and generate the figures of the paper, you can run just the first groups of scripts and skip the feature extractions task. If you want to extract the segment information from ERPs and TFDs, you have to start with the second group of scripts first.   

We have also added additional scripts:

- plotTFR_SAP, BWAOV2_SAP and errorb. For more information use help command in Matlab.

About the datasets, for each feature (ERPs or TFDs) we have 3 files .mat. 
- Induced theta/evoked_ERPs are data matrices for each infant. 
- theta_features/ERPs_features are the segments extracted from the data matrices (parameter values are explained in the paper).
- Grand_averages_TFDs/Grand_averages_ERPs, are the averages of all the segments in the region of interest (ROI).

###############
Speech Acquisition and Perception (SAP)

Center for Brain and Cognition

Universitat Pompeu Fabra

Web page: http://cbc.upf.edu

#############
