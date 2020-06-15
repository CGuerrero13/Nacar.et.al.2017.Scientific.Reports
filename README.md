# Nacar.et.al.2017.Scientific.Reports
Code repository and databases of the submitted paper: "You sound familiar to me! Evoked and oscillatory EEG activity differentiates language discrimination in young monolingual and bilingual infants"-Scientific Report.

The scripts (in Matlab) are divided in two parts:
- Stat analysis and plot figures,
- and feature extractions (for ERPs segments)

To visualize statistic results and generate the figures of the paper, you can run just the first groups of scripts and skip the feature extractions task. If you want to extract the segment information from ERPs, you have to start with the second group of scripts first.   

We have also added additional scripts:

- BWAOV2_SAP and errorb. For more information use help command in Matlab.

About the datasets, for each feature (ERPs or TFDs) we have 3 files .mat. 
- Evoked_ERPs are data matrices for each infant (Induced databases are too big). 
- theta_features/ERPs_features are the segments extracted from the data matrices (parameter values are explained in the paper).
- Grand_averages_ERPs, are the averages of all the ERP segments in the region of interest (ROI).

IMPORTANT: Just for improving the data visualization, the theta_features.mat file uploaded here was extracted using another baseline approach and adding more reconstructed EEG channels. Baseline extraction and EEG-preprocessing were independent of our findings.

This work is funded by a project by the Speech Acquisition and Perception Group (SAP, http://www.sap. upf.edu), Universitat Pompeu Fabra, NIF Q-5850017D, Plaça de la Merçè 10-12, 08002 Barcelona


