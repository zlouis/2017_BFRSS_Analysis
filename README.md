# 2017_BRFSS_Analysis
Data Analysis on population with Arthritis in Rhode Island and Maine.
Data obtained from the CDC - https://www.cdc.gov/brfss/annual_data/annual_2017.html


## Requirements
You will need the following packages:<br>
CSV<br>
DataFrames<br>
VegaLite<br>

While in Julia, `] add CSV`, `] add DataFrames`, `] add VegaLite`

## How to run
Run `download_2017brfss.sh` in terminal to download BRFSS dataset<br>
<br>
Then run `julia brfss_analysis.jl` which will extract the data from the dataset and create plots.<br>
*Note, adjust the file locations to read from the raw dataset accordingly. See below for details.<br>


To run Maine data extraction and export data, change the following lines in `brfss_analysis.jl`:<br>

line 7   - Rename output file to desired name<br>
line 32  - Set value to `23` for Maine or `44` for Rhode Island (Or any other value for a different state)<br>
line 61  - Rename output file to match line 7<br>
line 70  - Rename output file to match line 7<br>
line 152 - Rename output file to match line 7<br>

## Guide

1) It will create an output file to store extracted data, adjust the file output location accordingly<br>
2) Data values will be replaced with readable values and be pushed to Dataframe (df)<br>
3) A copy of Rhode island and Maine extracted dataset are included in the repository<br>
4) To run graph 5 for Maine, uncomment line 255 - 268<br>
5) By default, the script will run to pull Rhode Island data <br>
