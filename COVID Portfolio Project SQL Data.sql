select *
from PortfolioProjects..CovidDeaths
where continent is not null
order by 3,4


--select *
--from PortfolioProjects..CovidVaccinations
--order by 3,4

-- Select Data that we are goinh to be using
select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProjects..CovidDeaths
where continent is not null
order by 1,2

--looking at total cases vs total deaths
--Shows likelihood of dying if you contract covid in Japan
select location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProjects..CovidDeaths
where location like 'Japan' and continent is not null
order by 1,2

--Looking at total cases vs population
--Show percentage of population got Covid
select location, date,population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
from PortfolioProjects..CovidDeaths
where location like 'Japan' and continent is not null
order by 1,2

--Looking at countries with highest infection rate compared to population
select location,population,max( total_cases) as highestInfectionCount,max((total_cases/population))*100 as PercentPopulationInfected,
 rank ()over (order by (max((total_cases/population))*100) desc) as ranking
from PortfolioProjects..CovidDeaths
where continent is not null
group by location, population

--Showing countries with highest Death count per Population
select location,max( cast (total_deaths as int)) as TotalDeathCount
from PortfolioProjects..CovidDeaths
where continent is not null
group by location
order by TotalDeathCount desc
--Showing continents with the highest death count per population
select continent,max( cast (total_deaths as int)) as TotalDeathCount
from PortfolioProjects..CovidDeaths
where continent is not null
group by continent
order by TotalDeathCount desc

--Global Numbers
select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/
sum(new_cases)*100 as DeathPercentage
from PortfolioProjects..CovidDeaths
where continent is not null
order by 1,2


--Looking at Total Population vs Vaccinations
select dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations
, sum(convert (int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date)
as RollingPeopleVaccinated
from PortfolioProjects..CovidDeaths dea
join PortfolioProjects..CovidVaccinations vac
   on dea.location=vac.location and dea.date=vac.date
where dea.continent is not null
order by 1,2,3

--USE CTE
with PopVsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations
, sum(convert (int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date)
as RollingPeopleVaccinated
from PortfolioProjects..CovidDeaths dea
join PortfolioProjects..CovidVaccinations vac
   on dea.location=vac.location and dea.date=vac.date
where dea.continent is not null
)
select *, (RollingPeopleVaccinated/Population)*100
from PopVsVac

--TEMP TABLE
DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(Continent nvarchar(225),
Location nvarchar(225),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations
, sum(convert (int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date)
as RollingPeopleVaccinated
from PortfolioProjects..CovidDeaths dea
join PortfolioProjects..CovidVaccinations vac
   on dea.location=vac.location and dea.date=vac.date
--where dea.continent is not null

select *, (RollingPeopleVaccinated/Population)*100
from #PercentPopulationVaccinated


--Creating View to store data for later visualizations
Create View PercentPopulationVaccinaed as
select dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations
, sum(convert (int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date)
as RollingPeopleVaccinated
from PortfolioProjects..CovidDeaths dea
join PortfolioProjects..CovidVaccinations vac
   on dea.location=vac.location and dea.date=vac.date
where dea.continent is not null


select *
from PercentPopulationVaccinaed