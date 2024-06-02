-- Selecteer alle bieren met soortnr 3 of 5.
select *
from 
	bieren
where 
	SoortNr = 3
union
select *
from
	bieren
where 
	SoortNr = 5;
    -- Je wil een lijst met alle bieren. Elk bier krijgt de vermelding 'Alcoholvrij', 'Alcoholarm', 'Bevat alcohol' of 'Niet gekend'.
-- De juiste boodschap kan je bepalen op basis van het alcoholpercentage (<0,2; <0,5; >0,5 en IS NULL).
-- Sorteer op alcoholpercentage.
SELECT naam, alcohol, 'Alcoholvrij' AS type FROM bieren WHERE alcohol<0.2
UNION
SELECT naam, alcohol, 'Alcoholarm' AS type FROM bieren WHERE alcohol>=0.2 and alcohol <0.5
UNION
SELECT naam, alcohol, 'Bevat alcohol' AS type FROM bieren WHERE alcohol>=0.5
UNION
SELECT naam, alcohol, 'Niet gekend' AS type FROM bieren WHERE alcohol IS NULL
ORDER BY alcohol;
-- mjin methode case statment 
SELECT 
    naam,
    alcohol,
    CASE 
        WHEN alcohol < 0.2 THEN 'Alcoholvrij'
        WHEN alcohol >= 0.2 AND alcohol < 0.5 THEN 'Alcoholarm'
        WHEN alcohol >= 0.5 THEN 'Bevat alcohol'
        ELSE 'Niet gekend'
    END AS type
FROM 
    bieren
ORDER BY 
    alcohol;
-- Je wil weten welke brouwers bieren brouwen met een alcoholpercentage van 12.
-- met subqueries
SELECT *
FROM brouwers
WHERE BrouwerNr IN (
    SELECT BrouwerNr
    FROM bieren
    WHERE Alcohol = 12
);

-- met join

SELECT *
FROM 
    bieren
INNER JOIN 
    brouwers
ON 
    bieren.BrouwerNr = brouwers.BrouwerNr
WHERE 
    bieren.Alcohol = 12;
    --  lijst van alle bieren met het hoogste alcoholpercentage. 
SELECT 
	naam,
    Alcohol
FROM bieren
WHERE alcohol = (SELECT max(alcohol) FROM bieren);
-- Geef een lijst van alle bieren die in Oudenaarde gebrouwen worden. 
SELECT 
    *
FROM 
    bieren
WHERE 
    BrouwerNr IN (
        SELECT BrouwerNr
        FROM brouwers
        WHERE gemeente = 'Oudenaarde'
    );
-- geef de soortnr van de soorten die maar door 1 brouwerij gebrouwen worden.


SELECT 
    SoortNr
FROM 
    bieren
GROUP BY 
    SoortNr
HAVING 
    COUNT(DISTINCT BrouwerNr) = 1;
    -- ----
SELECT soortnr FROM (SELECT DISTINCT soortnr, brouwernr FROM bieren) as lijst
GROUP BY soortnr
HAVING count(*)=1;
-- Maak een lijst met het gemiddelde alcoholpercentage per soort.

SELECT
    bieren.BierNr,
    bieren.Naam,
    soorten.Soort,
    soorten.SoortNr,
    bieren.alcohol,
    AVG(bieren.Alcohol) AS gem
FROM
    bieren
inner join 
    soorten ON bieren.SoortNr = soorten.SoortNr
GROUP BY 
    soorten.SoortNr, soorten.Soort, bieren.BierNr, bieren.Naam, bieren.alcohol;
SELECT
    soorten.Soort,
    r1.gemiddelde
FROM
    (SELECT SoortNr, AVG(Alcohol) AS gemiddelde FROM bieren GROUP BY SoortNr) AS r1
INNER JOIN
    soorten ON r1.SoortNr = soorten.SoortNr;

-- Maak een lijst van alle bieren met een lager alcoholpercentage dan het gemiddelde alcoholpercentage van zijn eigen soort.

SELECT
    b.Naam,
    b.Alcohol,
    s.Soort,
    s.SoortNr,
    (SELECT AVG(b2.Alcohol) FROM bieren b2 WHERE b2.SoortNr = b.SoortNr) AS gemiddelde_soort
FROM
    bieren b
JOIN
    soorten s 
		ON b.SoortNr = s.SoortNr
WHERE
    b.Alcohol < (SELECT AVG(b2.Alcohol) FROM bieren b2 WHERE b2.SoortNr = b.SoortNr);



