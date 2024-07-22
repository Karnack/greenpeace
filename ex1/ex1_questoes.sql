--  Esse teste foi feito com pressa. Por isso, peço para relevar caso veja o uso de "ORDER BY N" ou "GROUP BY N", assim como nomes de variáveis que possam estar não explicitando seu conteúdo apropriadamente
-----------------------------------------
------------- Exercício 1 ---------------
-----------------------------------------
-- QUESTÃO 2. QUANTIDADE DE REAÇÕES DISTINTAS

-- 2.1. SEM LEVAR EM CONSIDERAÇÕES MULTIPLOS VALORES
SELECT reactions, count(reactions) FROM `bigquery-public-data.fda_food.food_events` group by reactions order by 2 desc limit 10

-- 2.2. LEVANDO EM CONSIDERAÇÕES MULTIPLOS VALORES
WITH 

reactions_clean AS (
  SELECT TRIM(reaction) AS reaction_clean
  FROM `bigquery-public-data.fda_food.food_events`,
  UNNEST(SPLIT(replace(reactions, ';', ','))) AS reaction
)

SELECT reaction_clean, count(reaction_clean) 
FROM reactions_clean 
GROUP BY reaction_clean ORDER BY 2 DESC 
LIMIT 10

-- QUESTÃO 3. NOME DA INDUSTRIA COM MAIOR NUMERO DE MORTES
WITH 

reactions_clean AS (
  SELECT products_industry_name
       , TRIM(reaction) AS reaction_clean
  FROM `bigquery-public-data.fda_food.food_events`,
  UNNEST(SPLIT(REPLACE(reactions, ';', ','))) AS reaction
)

SELECT products_industry_name, reaction_clean, count(reaction_clean) 
FROM reactions_clean 
WHERE reaction_clean = 'Death'  
GROUP BY 1,2
ORDER BY 3 DESC 
LIMIT 10

-- QUESTÃO 4. QUANTIDADE DE REAÇÕES PELA INDUSTRIA DE COSMÉTICOS PARA PESSOAS ENTRE 18 E 25 ANOS.
WITH 

reactions_clean AS (
  SELECT consumer_age
       , TRIM(reaction) AS reaction_clean
  FROM `bigquery-public-data.fda_food.food_events`,
  UNNEST(SPLIT(REPLACE(reactions, ';', ','))) AS reaction
  
  WHERE consumer_age BETWEEN 18 AND 25 
   AND products_industry_name = 'Cosmetics' 
)

