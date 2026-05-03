# Final Report

## Project Description

This repository contains the final report and Shiny app for the VTPEH 6270 final project. The project examines the association between exercise participation and self-reported general health among adults in New York using BRFSS data.

## Author

Yuan Jingxin

## Files Included

- `Final_Report.Rmd`: R Markdown file used to generate the final report.
- `Final_Report.pdf`: Knitted PDF version of the final report.
- `app.R`: Shiny app code.
- `brfss_subset_small.csv`: Dataset used for the analysis.

## Research Question

Is exercise participation associated with self-reported general health among adults in New York?

## Data Source

The analysis uses a subset of Behavioral Risk Factor Surveillance System (BRFSS) data. The variables used include exercise participation in the past 30 days and self-reported general health.

## How to Reproduce the Final Report

1. Download or clone this repository.
2. Open `Final_Report.Rmd` in RStudio.
3. Make sure the data file `brfss_subset_small.csv` is in the same folder.
4. Install the required R packages if needed:

```r
install.packages(c("tidyverse", "kableExtra", "ggpattern"))
