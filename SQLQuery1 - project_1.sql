--select * from PortfolioProject..CovidDeaths
--order by 3,4

--select * from PortfolioProject..CovidVaccinations$
--order by 3,4

-- select the data we are going to use

--select location,date,total_cases,new_cases,total_deaths,population 
--from PortfolioProject..CovidDeaths
--order by 1,2 

-- looking at total cases vs total deaths
-- shows liklihood of dying if you cintract covid in your country 

--select location,date,total_cases,total_deaths,(total_deaths/total_cases) *100 death_per
--from PortfolioProject..CovidDeaths
--where location like '%israel%'
--order by 1,2 

-- looking at total cases vs population 

--select location,date,total_cases,population,(total_cases/population) *100 case_per_pop
--from PortfolioProject..CovidDeaths
--where location like '%israel%'
--order by 1,2 

-- looking at countries with highest infection rate compared to population

--select location,max(total_cases) highest_infec_count,population,max((total_cases/population)) *100 case_per_pop
--from PortfolioProject..CovidDeaths
--group by location,population
----where location like '%israel%'
--order by case_per_pop desc

--LETS BREAK THINGS DOWN BY CONTINENT
--select continent,max(cast(total_deaths as int)) as totaldeathcount
--from PortfolioProject..CovidDeaths
--where  continent is not null
--group by continent
--order by totaldeathcount desc

--showing continents with the highest death count per population:
--select continent ,max(cast(total_deaths as int)) as totaldeathcount
--from PortfolioProject..CovidDeaths
--where  continent is not null
--group by continent  
--order by totaldeathcount desc

--breaking global numbers
--select sum(new_cases) total_cases,sum(cast(new_deaths as int)) total_deaths,sum(cast(new_deaths as int))/sum(new_cases) as death_per
--from PortfolioProject..CovidDeaths
----where location like '%israel%'
--where continent is not null
----group by date
--order by 1,2  

--showing country with highest death count per population
-- if we will take a look in the datatype we will see that total_deaths is varchar -> meaning we can tdo a mathmetical moves on him. then, we need to convert him to a number
-- then we will get the right result
--select location,max(cast(total_deaths as int)) as totaldeathcount
--from PortfolioProject..CovidDeaths
--where  continent is not null
--group by location
--order by totaldeathcount desc

--select * from PortfolioProject..CovidDeaths
--where continent is not null -> we need to take care this case
--order by 3,4

-- now we will move to the covid vaccinations table:
-- looking total vaccinations vs total pouplation
--select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, 
--dea.date) as roliing_people_vac -- we cant use a new column that we create to do func with her -> then we need to create a cte
--from PortfolioProject..CovidDeaths dea
--join PortfolioProject..CovidVaccinations vac
--on 
--	dea.location = vac.location
--	and dea.date = vac.date
--where dea.continent is not null
--order by 2,3

--use cte:
--with popvsvac as 
--(select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, 
--dea.date) as roliing_people_vac -- we cant use a new column that we create to do func with her -> then we need to create a cte
--from PortfolioProject..CovidDeaths dea
--join PortfolioProject..CovidVaccinations vac
--on 
--	dea.location = vac.location
--	and dea.date = vac.date
--where dea.continent is not null
----order by 2,3
--)
--select *,(roliing_people_vac/population)*100  from popvsvac

--temp table 
--create table #percentpopulationvaccinated
--(
--continent nvarchar(255),
--location nvarchar(255),
--Date datetime,
--population numeric,
--new_vaccinations numeric,
--roliing_people_vac numeric
--)


--drop table if exists #percentpopulationvaccinated
--insert into #percentpopulationvaccinated
--select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, 
--dea.date) as roliing_people_vac -- we cant use a new column that we create to do func with her -> then we need to create a cte
--from PortfolioProject..CovidDeaths dea
--join PortfolioProject..CovidVaccinations vac
--on 
--	 dea.location = vac.location
--	and dea.date = vac.date
--	where dea.continent is not null

--select *,( roliing_people_vac/population) *100
--from #percentpopulationvaccinated

--creating view to store data for later visualizations
--create view percentpopulationvaccinated as 
--select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, 
--dea.date) as roliing_people_vac -- we cant use a new column that we create to do func with her -> then we need to create a cte
--from PortfolioProject..CovidDeaths dea
--join PortfolioProject..CovidVaccinations vac
--on 
--dea.location = vac.location
--and dea.date = vac.date
--	--where dea.continent is not null

select * from percentpopulationvaccinated 