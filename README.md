# 2017_BFRSS_Analysis
Data Analysis on population with Arthritis in Rhode Island and Maine.
Data obtained from the CDC - https://www.cdc.gov/brfss/annual_data/annual_2017.html

Data extrapolated only contains Rhode island and Maine.

## How to run

From terminal run `julia process3.jl`


To run Maine data extraction and export data, change the following lines in `process3.jl`:

line 7   - Rename output file to desired name
line 32  - Set value to `23` for Maine or `44` for Rhode Island (Or any other value for a different state)
line 61  - Rename output file to match line 7
line 70  - Rename output file to match line 7
line 152 - Rename output file to match line 7
