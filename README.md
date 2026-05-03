# Final Report

## Project Description

This repository contains the final report and Shiny app for the VTPEH 6270 final project. The project examines the association between exercise participation and self-reported general health among adults in New York using BRFSS data.

## Author

Puying Li

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
```

## Outputs

- [Final Report PDF](Final_Report.pdf)
- [Final Report R Markdown](Final_Report.Rmd)
- [Shiny App Code](app.R)

## Motivation

This project was completed for the VTPEH 6270 final project. The goal of this analysis is to examine whether exercise participation is associated with self-reported general health among adults in New York. Understanding this relationship can help describe patterns between health behavior and perceived health status.

## Data Source and Citation

The dataset used in this project is a subset of the Behavioral Risk Factor Surveillance System (BRFSS). The analysis focuses on adults in New York and includes variables related to exercise participation in the past 30 days and self-reported general health.

Centers for Disease Control and Prevention. Behavioral Risk Factor Surveillance System (BRFSS). https://www.cdc.gov/brfss/

## Shiny App

The Shiny app code is included in this repository as `app.R`. To run the app locally, open `app.R` in RStudio and click **Run App**.

## AI Tool Disclosure

I used ChatGPT as a support tool to help troubleshoot R code, improve formatting, and revise README documentation. All final analyses, interpretations, and submitted materials were reviewed and edited by me.
