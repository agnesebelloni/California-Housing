# California Housing Bootstrap Analysis

This project applies the bootstrap method to the California Housing dataset to assess the accuracy of estimates in a linear regression model. The dataset, collected during the 1990 census in California, includes data on various housing and demographic factors across different regions of the state. The primary goal is to analyze how variables like median income, housing age, and geographic location influence the median house value.

## Dataset Overview
The *California Housing* dataset consists of 10 variables and 20,640 observations. The key variables include:

- **longitude**: Geographic longitude in degrees (negative values indicate west of the prime meridian).
- **latitude**: Geographic latitude in degrees (positive values indicate north of the equator).
- **housing median age**: Median age of houses in the region (in years).
- **total rooms**: Total number of rooms in all houses in the region.
- **total bedrooms**: Total number of bedrooms in all houses in the region.
- **population**: Total population in the region.
- **households**: Total number of households (families) in the region.
- **median income**: Median household income (in tens of thousands of dollars).
- **median house value**: Median house value (in dollars).
- **ocean proximity**: Categorical variable indicating proximity to the ocean (`NEAR BAY`, `NEAR OCEAN`, `INLAND`, `ISLAND`, `<1H OCEAN`).

## Project Objectives
1. **Exploratory Data Analysis (EDA)**: Analyze the dataset to detect missing values, outliers, and correlations among variables.
2. **Linear Regression Model**: Build a regression model with `median house value` as the dependent variable and all other variables as predictors.
3. **Bootstrap Application**: Use the bootstrap method to estimate confidence intervals for the regression coefficients, allowing for a robust evaluation of their variability.
4. **Data Visualization**: Use visual tools like boxplots, histograms, and correlation heatmaps to facilitate the understanding of the relationships between variables.

## Analysis Process
### 1. Exploratory Data Analysis
- Identified 207 missing values in the `total bedrooms` variable, which were removed due to their small proportion of the total data.
- Boxplots were used to identify outliers, particularly in the variables `households`, `total rooms`, `total bedrooms`, and `population`.
- Correlation analysis showed strong positive correlations among variables related to population and housing (e.g., `total rooms`, `total bedrooms`, `households`), and a moderate positive correlation between `median house value` and `median income`.

### 2. Linear Regression Model
- A linear regression model was built to predict the median house value based on the other variables.
- Significant positive effects were observed for `median income`, while `longitude` and `latitude` had negative effects, highlighting the importance of geographic location on house prices.
- The model achieved an R² value of 0.65, explaining 65% of the variance in house values.

### 3. Bootstrap Method
- The bootstrap technique was applied to estimate the variability of the regression coefficients.
- Confidence intervals (95%) were computed for each coefficient to assess the precision of the estimates.
- The bootstrap results confirmed that variables like `median income`, `latitude`, and `longitude` had significant and stable effects on house prices, while others like `population` and `total bedrooms` showed higher variability.

### 4. Visualization
- Boxplots, histograms, and bar charts were used to visualize data distributions and outliers.
- A correlation heatmap was created to highlight the relationships between numerical variables.
- Bootstrap results were visualized using error bars around the original coefficient estimates, showing the confidence intervals for each estimate.

## Key Results
- **Significant Variables**: `median income`, `latitude`, and `longitude` were the most significant predictors of house prices.
- **Geographic Influence**: Locations further inland (lower longitude and latitude) generally had lower house values.
- **Income Influence**: Higher median income was strongly associated with higher house prices.
- **Bootstrap Findings**: The bootstrap method confirmed the robustness of the original regression estimates, providing narrow confidence intervals for key predictors.

## How to Run the Project
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/california-housing-bootstrap.git
