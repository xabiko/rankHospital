#Hospital ranking scripts
	Ranking Hospitals by mortality rates on Heart Attack, Heart Failure & Pneumonia.

###This repo contains 6 files:
	* Hospital_Revised_Flatfiles.pdf : document describing the 30 different tables provided by the Hospital Compare database. We'll be using Outcome of Care Measures.csv
	* outcome-of-care-measures.csv : **table used in the scripts**. Provides each hospital's risk-adjusted 30-day death (mortality) and 30-day readmission category and rate.
	* hospital-data.csv : **table not be used in the scripts**. Provides general hospital information.
	* best.R : retrieves the name of the best hospital in 'state' for a certain 'outcome'/type of death.
	* rankhospital.R : retrieves the name of the nth best hospital in 'state' for a certain 'outcome'/type of death.
	* rankall.R : retrieves a list of hospital names, containing the nth best hospital for each state for a certain 'outcome'/type of death.

