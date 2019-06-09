# 2017_BFRSS_Analysis
Data Analysis on population with Arthritis in Rhode Island and Maine.
Data obtained from the CDC - https://www.cdc.gov/brfss/annual_data/annual_2017.html

Data extrapolated only contains Rhode island and Maine.
## Requirements
You will need the following packages:
CSV
DataFrames
VegaLite

While in Julia, `] add CSV`, `]add DataFrames`, `] add VegaLite`

## How to run
Run `download_2017brfss.sh` terminal to download the dataset
Then run `julia process3.jl` to extract data from the dataset and create plots.

By default, the script will run to pull Rhode Island Data.<br>
To run Maine data extraction and export data, change the following lines in `process3.jl`:

line 7   - Rename output file to desired name<br>
line 32  - Set value to `23` for Maine or `44` for Rhode Island (Or any other value for a different state)<br>
line 61  - Rename output file to match line 7<br>
line 70  - Rename output file to match line 7<br>
line 152 - Rename output file to match line 7<br>

## Guide

`process3.jl` When running this file,

1) It will create an output file to store extracted data<br>
2) Data values will be replaced with human readable values and be pushed to Dataframe (df)<br>
