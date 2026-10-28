-- ============================================================
-- BANCO WORLD - EXEMPLOS DA AULA
-- Conteúdos:
-- BOOLEAN (conceitual/adaptado), BETWEEN, >= e <=,
-- ALIAS, ORDER BY, GROUP BY, DISTINCT e SUBQUERY
-- ============================================================

USE world;

-- ============================================================
-- 1. BOOLEAN - ADAPTAÇÃO CONCEITUAL
-- ============================================================
-- O banco WORLD não possui uma coluna BOOLEAN nativa adequada
-- para este exemplo. Por isso, usamos uma condição que resulta
-- em verdadeiro (1) ou falso (0).

-- Exemplo 1: Mostrar se a cidade possui mais de 1 milhão de habitantes


SELECT
    Name AS cidade,
    Population AS populacao,
    Population > 1000000 AS mais_de_um_milhao
FROM city;

-- Exemplo 2: Mostrar se o país possui população acima de 100 milhões
SELECT
    Name AS pais,
    Population AS populacao,
    Population > 100000000 AS populacao_acima_100_milhoes
FROM country;


-- ============================================================
-- 2. BETWEEN
-- ============================================================

-- Exemplo 1: Países com população entre 10 e 50 milhões
SELECT
    Name,
    Population
FROM country
WHERE Population BETWEEN 10000000 AND 50000000;

-- Exemplo 2: Cidades com população entre 500 mil e 1 milhão
SELECT
    Name,
    Population
FROM city
WHERE Population BETWEEN 500000 AND 1000000;


-- ============================================================
-- 3. BETWEEN X >= E <=
-- ============================================================

-- Mesma consulta utilizando BETWEEN
SELECT
    Name,
    Population
FROM country
WHERE Population BETWEEN 10000000 AND 50000000;

-- Mesma consulta utilizando >=, <= e AND
SELECT
    Name,
    Population
FROM country
WHERE Population >= 10000000
AND Population <= 50000000;


-- ============================================================
-- 4. ALIAS
-- ============================================================

-- Exemplo 1: Renomeando colunas
SELECT
    Name AS pais,
    Continent AS continente,
    Population AS populacao
FROM country;

-- Exemplo 2: Renomeando colunas da tabela city
SELECT
    Name AS cidade,
    District AS distrito,
    Population AS populacao
FROM city;


-- ============================================================
-- 5. ORDER BY
-- ============================================================

-- Exemplo 1: Países em ordem alfabética
SELECT
    Name,
    Population
FROM country
ORDER BY population DESC;

-- Exemplo 2: Países mais populosos primeiro
SELECT
    Name,
    Population
FROM country
ORDER BY Population DESC;

-- Exemplo 3: Cidades menos populosas primeiro
SELECT
    Name,
    Population
FROM city
ORDER BY Population ASC;


-- ============================================================
-- 6. DISTINCT
-- ============================================================

-- Exemplo 1: Continentes existentes no banco
SELECT DISTINCT
    Continent
FROM country;

-- Exemplo 2: Regiões existentes no banco
SELECT DISTINCT
    Region
FROM country;

-- Exemplo 3: Distritos únicos da tabela city
SELECT DISTINCT
    District
FROM city
ORDER BY District ASC;


-- ============================================================
-- 7. COUNT + GROUP BY
-- ============================================================

-- Quantidade de países por continente
SELECT
    Continent AS continente,
    COUNT(*) AS quantidade_paises
FROM country
GROUP BY Continent;

-- Quantidade de cidades por código de país
SELECT
    CountryCode AS codigo_pais,
    COUNT(*) AS quantidade_cidades
FROM city
GROUP BY CountryCode;


-- ============================================================
-- 8. GROUP BY + ORDER BY
-- ============================================================

-- Ranking dos continentes com mais países
SELECT
    Continent AS continente,
    COUNT(*) AS quantidade_paises
FROM country
GROUP BY Continent
ORDER BY quantidade_paises DESC;

-- Ranking dos países com mais cidades cadastradas
SELECT
    CountryCode AS codigo_pais,
    COUNT(*) AS quantidade_cidades
FROM city
GROUP BY CountryCode
ORDER BY quantidade_cidades DESC;


-- ============================================================
-- 9. SUM + GROUP BY
-- ============================================================

-- População total por continente
SELECT
    Continent AS continente,
    SUM(Population) AS populacao_total
FROM country
GROUP BY Continent;

-- População total das cidades por país
SELECT
    CountryCode AS codigo_pais,
    SUM(Population) AS populacao_total_cidades
FROM city
GROUP BY CountryCode;


-- ============================================================
-- 10. GROUP BY + SUM + ORDER BY
-- ============================================================

-- Ranking dos continentes por população total
SELECT
    Continent AS continente,
    SUM(Population) AS populacao_total
FROM country
GROUP BY Continent
ORDER BY populacao_total DESC;

-- Ranking dos países pela soma da população das cidades cadastradas
SELECT
    CountryCode AS codigo_pais,
    SUM(Population) AS populacao_total_cidades
FROM city
GROUP BY CountryCode
ORDER BY populacao_total_cidades DESC;


-- ============================================================
-- 11. COUNT + GROUP BY - LÍNGUAS
-- ============================================================

-- Quantidade de idiomas registrados por país
SELECT
    CountryCode AS codigo_pais,
    COUNT(*) AS quantidade_idiomas
FROM countrylanguage
GROUP BY CountryCode;

-- Ranking dos países com mais idiomas registrados
SELECT
    CountryCode AS codigo_pais,
    COUNT(*) AS quantidade_idiomas
FROM countrylanguage
GROUP BY CountryCode
ORDER BY quantidade_idiomas DESC;


-- ============================================================
-- 12. SUBQUERY - INTRODUÇÃO
-- ============================================================

-- Primeiro: descobrir a população média dos países
SELECT
    AVG(Population) AS media_populacao
FROM country;

-- Depois: listar países com população acima da média
SELECT
    Name,
    Population
FROM country
WHERE Population > (
    SELECT AVG(Population)
    FROM country
);


-- ============================================================
-- 13. SUBQUERY COM CIDADES
-- ============================================================

-- Cidades com população acima da média das cidades
SELECT
    Name,
    Population
FROM city
WHERE Population > (
    SELECT AVG(Population)
    FROM city
);


-- ============================================================
-- 14. SUBQUERY + ORDER BY
-- ============================================================

-- Países acima da população média, do mais populoso para o menos populoso
SELECT
    Name AS pais,
    Population AS populacao
FROM country
WHERE Population > (
    SELECT AVG(Population)
    FROM country
)
ORDER BY Population DESC;


-- ============================================================
-- 15. DESAFIO GUIADO
-- ============================================================

-- Primeiro: descobrir a expectativa média de vida
SELECT
    AVG(LifeExpectancy) AS media_expectativa_vida
FROM country
WHERE LifeExpectancy IS NOT NULL;

-- Países com expectativa de vida acima da média
SELECT
    Name AS pais,
    LifeExpectancy AS expectativa_vida
FROM country
WHERE LifeExpectancy > (
    SELECT AVG(LifeExpectancy)
    FROM country
    WHERE LifeExpectancy IS NOT NULL
)
ORDER BY LifeExpectancy DESC;


-- ============================================================
-- 16. EXEMPLO FINAL - INTEGRAÇÃO DOS CONTEÚDOS
-- ============================================================

-- Filtra países com população entre 10 e 200 milhões,
-- agrupa por continente,
-- conta quantos países existem em cada grupo,
-- soma a população desses países
-- e ordena do continente com maior população para o menor.
SELECT
    Continent AS continente,
    COUNT(*) AS quantidade_paises,
    SUM(Population) AS populacao_total
FROM country
WHERE Population BETWEEN 10000000 AND 200000000
GROUP BY Continent
ORDER BY populacao_total DESC;


-- ============================================================
-- 17. EXEMPLO EXTRA - DISTINCT + ORDER BY
-- ============================================================

-- Listar todos os tipos de governo sem repetição
SELECT DISTINCT
    GovernmentForm AS forma_governo
FROM country
ORDER BY GovernmentForm ASC;


-- ============================================================
-- 18. EXEMPLO EXTRA - SUBQUERY COM VALOR DE REFERÊNCIA
-- ============================================================

-- Países com população maior que a população do Brasil
SELECT
    Name AS pais,
    Population AS populacao
FROM country
WHERE Population > (
    SELECT Population
    FROM country
    WHERE Name = 'Brazil'
)
ORDER BY Population DESC;




select 
	Name as nome_cidade, 
	(SELECT AVG (population) FROM city) AS media_populacao
from city c1;





SELECT 
	nome_cidade
FROM 
(
	select 
		id ,
		name AS nome_cidade,
		population 
	from city
	Where Population < 10000
) as cidades


-- ============================================================
-- FIM DOS EXEMPLOS
-- ============================================================

select CEILING(55.5) as arredondado;











-- Aruba -> Arubaa
SELECT
    name as pais
    ,continent as continente 
    ,region as regiao
FROM country
where name like "A%"
and continent = "North America"
and code = "ABW";



UPDATE country -- nome da tabela
SET name = 'Aruba',  -- atualize para esse valor
    continent = 'Africa'
WHERE code = 'ABW';


SHOW COLUMNS FROM country LIKE 'Continent';



SELECT 
	concat(" - teste",Name)  
from country
where name like "A%"
and continent = "Africa"
and code = "ABW";


