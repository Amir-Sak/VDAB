-- Opdracht voor de coach
-- Geef een lijst van de klanten uit Gent of Wetteren met de velden naam, voornaam, postcode, woonplaats en klantstatus. 
-- Sorteer op klantstatus en naam.
SELECT 
    naam, 
    voornaam, 
    postcode, 
    woonplaats, 
    klantstatus
FROM 
    klanten
	WHERE 
		woonplaats IN ('Gent', 'Wetteren')
	ORDER BY 
		klantstatus, 
		naam;
-- Maak een lijst van de klanten waarvan de postcode groter of gelijk is aan 9000 en de klanten waarvan het huuraantal groter is dan 200. 
-- Deze lijst moet gesorteerd worden op postcode 
  SELECT 
    naam, 
    voornaam, 
    postcode, 
    woonplaats, 
    totaalGehuurd
FROM 
    klanten
	WHERE 
		postcode >= '9000' and totaalGehuurd > '200'
	ORDER BY 
		postcode, 
		naam;
   -- Geef een lijst van de klanten wiens naam niet begint met een 'd'.
   SELECT *
   from klanten
		where naam not like 'd%'
		order by naam;
    -- Geef een lijst van klanten waar in de naam van de gemeente op de derde plaats een 'n' staat.    
SELECT *
   from klanten
		where woonplaats like '__n%'
		order by woonplaats;
  -- Bereken voor alle films de prijs incl BTW (21%).
  SELECT *
   from films;
select 
	filmid,
    titel,
    (prijs * 1.21) as prijs_BTW
    from films
    order by prijs_BTW;
   -- Uit welke woonplaatsen komen onze klanten?
    SELECT *
   from klanten;
   -- Maak een lijst van het aantal klanten per gemeente.
SELECT 
    woonplaats,
    COUNT(klantid) AS aantal
FROM 
    klanten
GROUP BY 
    woonplaats
ORDER BY 
    woonplaats;
-- Maak een lijst die het mogelijk maakt een inzicht te krijgen in de verhuringen per gemeente.
-- Op deze lijst moet de gemeente/stad met de meeste verhuringen bovenaan staan.
-- Indien in een bepaalde gemeente geen 200 verhuringen gebeurd zijn, mag deze gemeente niet op de lijst staan.
SELECT 
    woonplaats,
    SUM(totaalGehuurd) AS totaal_verhuringen
FROM 
    klanten
GROUP BY 
    woonplaats
HAVING 
    SUM(totaalGehuurd) >= 200
ORDER BY 
    totaal_verhuringen DESC;

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    