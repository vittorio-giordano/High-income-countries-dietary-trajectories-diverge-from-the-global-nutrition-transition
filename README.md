# High-income countries dietary trajectories diverge from the global nutrition transition
This repository contains the code and the data used to perform the analyses of the work *Giordano, V., Tuninetti, M., Laio, F., (2025). High-income countries dietary trajectories diverge from the global nutrition transition*, which analyzes historical data of dietary composition to investigate transitions in the global food system.

## Table of Contents
- [Data Overview](#data-overview)
- [Scripts](#scripts)
- [Requirements](#requirements)
- [Usage](#usage)
- [License](#license)

## Data Overview
Dietary Energy Supply (DES) reflects the food supply available for human consumption, converted to per capita energy supply and expressed as a share of the total dietary caloric supply (% Kcal/capita/day). DES data is available for 15 food-items: animal fats, bovine Meat, pig-meat, poultry Meat, eggs, milk (excluding butter), fish, seafood, cereals (excluding beer), legumes, fruits (excluding wine), starchy roots, treenuts, vegetables, vegetable oils, sugar & sweeteners; and aggregated into 4 main food groups: animal products, plant-based products, cereals and sugars. Per capita food supply data has been sourced from the FAOSTAT database through Countries’ Food Balances and has been processed according to the methodology described in the original publication.

- DES_data.nc - contains the Dietary Energy Supply (DES) data for 196 countries (on the rows), from 1960 to 2021 (on the columns), relative to 4 food categories (3rd dimension);
- DES_data_15.nc - contains the Dietary Energy Supply (DES) data for 196 countries (on the rows), from 1960 to 2021 (on the columns), relative to 15 food items (3rd dimension);
- country_name.csv - contains the names of the 196 countries for which DES data is available. They are listed in the same order as the rows of DES_data.nc and DES_data_15.nc; the first three columns store corresponding names of Countries, with slight different nomenclatures to match national statistics datasets. The following columns contain: FAO country code, ISO3 code, Region, Continent, Region code, Income Group;
- food_categories.csv - contains the names of the 15 individual food items for which DES data is available (1st column), listed in the same order as the 3rd dimension of DES_data_15.nc; the names of the 4 aggregated food categories for which DES data is available (2nd column), listed in the same order as the 3rd dimension of DES_data.nc;
- GDP_standard_2015_prices_capita.csv - contains Gross Domestic Product (GDP) data for 219 countries, from 1970 to 2021, at constant 2015 US dollars value;
- country_name_GDP.csv - contains the names of the 219 countries for which GDP data is available, listed in the same order as the rows of GDP_standard_2015_prices_capita.csv;

## Scripts
- ### DES_distributions_regressions.R
  This script reads the data described above, organizes it in DES - GDP (log10 scale) distributions relative to each food category/item, and computes a second-order linear regression as well as multiple-quantile regressions for each distribution. The code contains the libraries necessary to run the script.

## Requirements

- R environment (The authors used R version 4.3.3);
- 'ncdf4' library (The authors used ncdf4 version 1.23)
- 'quantreg' library (the authors used quantreg version 5.97)

## Usage

### Set Up the Environment: 
Ensure you have a R environment with the required packages as pointed out in the subsection Requirements.

### Run the Scripts:

- Set a working directory where the data can be accessed;
- Set variables that store the data generated in each loop and do not get overwritten, where indicated in the code;
- Save your files at the end;

## License

This project is licensed under the MIT License.
