# COVID-19 Data Exploration and Visualization
## Project Overview
This project aims to analyze COVID-19 data, specifically focusing on death and vaccination statistics worldwide. The data was sourced from [Our World in Data](https://ourworldindata.org/covid-deaths) and includes two datasets: COVID-19 Deaths and COVID-19 Vaccinations. The analysis was conducted using SQL Server, and the results were visualized using Tableau.

## Data Sources
- **COVID-19 Deaths:** [Download Link](https://ourworldindata.org/covid-deaths)
- **COVID-19 Vaccinations:** [Download Link](https://ourworldindata.org/covid-deaths)
## Tools and Technologies
- **SQL Server:** For data analysis and querying.
- **Tableau:** For data visualization.
- **GitHub:** For storing SQL queries and sharing project documentation.
## SQL Analysis
The SQL queries used for data exploration and analysis are available on my [GitHub repository](https://github.com/DiepKhuat/PortfolioProjects/blob/main/COVID%20Portfolio%20Project%20-%20SQL%20Data%20Exploration.sql).

### Key SQL Queries
1. **Total Deaths by Country:**

```sql
SELECT location, SUM(new_deaths) AS total_deaths
FROM covid_deaths
GROUP BY location
ORDER BY total_deaths DESC;
```
2. **Vaccination Rate by Country:**

```sql
SELECT location, MAX(total_vaccinations) AS total_vaccinations, MAX(population) AS population, 
       (MAX(total_vaccinations) / MAX(population)) * 100 AS vaccination_rate
FROM covid_vaccinations
GROUP BY location
ORDER BY vaccination_rate DESC;
```
3. **Monthly Deaths Trend:**

```sql
SELECT DATEPART(YEAR, date) AS year, DATEPART(MONTH, date) AS month, SUM(new_deaths) AS total_deaths
FROM covid_deaths
GROUP BY DATEPART(YEAR, date), DATEPART(MONTH, date)
ORDER BY year, month;
```
## Data Visualization
The visualizations created in Tableau include:

- **Global Deaths and Vaccinations Overview:** A dashboard summarizing total deaths and vaccinations by country.
- **Monthly Deaths Trend:** A line chart showing the trend of deaths over time.
- **Vaccination Rate Comparison:** A bar chart comparing vaccination rates across countries.
You can view the Tableau dashboard [here](https://public.tableau.com/app/profile/diep.khuat/viz/CovidDashboard_17192173893080/Dashboard1).

### Findings
1. **Total Deaths:** The countries with the highest total deaths are the United States, Brazil, and India.
2. **Vaccination Rates:** Countries with the highest vaccination rates include the United Arab Emirates, Malta, and Israel.
3. **Monthly Trend:** There was a significant spike in deaths during the early months of 2021.

### Conclusion
The analysis and visualizations provide valuable insights into the impact of COVID-19 across different regions and the progress of vaccination efforts. These findings can help inform public health decisions and strategies to combat the pandemic.

## Future Work
- **Data Update:** Continuously update the data to reflect the latest COVID-19 statistics.
- **In-depth Analysis:** Perform more detailed analysis on the correlation between vaccination rates and the reduction in death rates.
- **Predictive Modeling:** Develop predictive models to forecast future trends in COVID-19 cases and deaths.
