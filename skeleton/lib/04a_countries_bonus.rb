# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

# BONUS QUESTIONS: These problems require knowledge of aggregate
# functions. Attempt them after completing section 05.

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
  select name
  from countries
  where gdp > (
    select MAX(gdp)
    from countries
    where continent = 'Europe'
  )

  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
  SELECT continent, name, area
  FROM countries
  WHERE area = (
    SELECT MAX(c2.area)
    from countries as c2
    WHERE c2.continent = countries.continent);
    -- =  (
    --   select max(c3.area)
    --   from countries as c3
    --   where c3.continent = c2.continent
    -- )
  -- );
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    select distinct c1.name, c1.continent
    from countries as c1
    where population > 3 *(
      select max(c2.population)
      from countries as c2
      where c2.continent = c1.continent
        and c1.name != c2.name
    )

  SQL
end
