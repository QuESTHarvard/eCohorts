# eCohorts

# People's Voice Survey (PVS) Data Processing Code
Neena R Kapoor, Shalom Sabwa, Mia Yu

**This repository contains the .do files used to process and analyze data from the People's Voice Survey.** 

## About the survey: 
The People’s Voice Survey is a new instrument to integrate people’s voices into health system measurement, with a focus on population health needs and expectations as well as people’s perspectives on processes of care and confidence in the health system. It enables a rapid assessment of health system performance from the population perspective to inform health system planning.

## Countries: 
Currently, the PVS has been conducted in 3 countries: Kenya, South Africa, and Ethiopia 

## Files in this repository: 
The "mainPVS.do" file sets globals and runs all .do files for data cleaning and preparation. Each country-specific creation file (e.g., crECo_cln_ET.do) cleans country data. The "crEco_der.do" file creates derived variables for analysis. The "anEco_mtbl.do" file creates weighted descriptive tables from these data. 
