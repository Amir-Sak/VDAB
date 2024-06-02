-- opdrachten 1
-- Het tuincentrum wil graag een lijst waarop is aangegeven welke bomen in Aalsmeer en welke buiten Aalsmeer verkrijgbaar zijn. 
-- Op het overzicht moeten de volgende gegevens verschijnen: plantId, plantennaam, 
-- artikelcode van de leverancier, alsmede een aanduiding 'AALSMEER' of 'BUITEN AALSMEER'.Sorteer de lijst op plantId.
SELECT 
    planten.plantId, 
    planten.plantNaam, 
    artikelsleveranciers.artikelLeverancierCode, 
    CASE 
        WHEN leveranciers.woonplaats = 'Aalsmeer' THEN 'AALSMEER'
        ELSE 'BUITEN AALSMEER'
    END as plaats
FROM 
    planten
INNER JOIN 
    artikelsleveranciers ON planten.plantId = artikelsleveranciers.plantId
INNER JOIN 
    leveranciers ON artikelsleveranciers.leverancierId = leveranciers.leverancierId
WHERE 
    planten.soort = 'boom'
ORDER BY 
    planten.plantId;
    -- -------------------------------
-- Je wil een overzicht waarop is aangegeven welke bestellijnen te laat zijn. Voor de bestellijnen die te laat zijn moet in een extra kolom de opmerking 'TE LAAT' worden geplaatst; voor de andere bestellijnen wordt in die kolom een aantal streepjes geplaatst.
-- Sorteer het overzicht op 'bestelId'.
-- Geef bestelId, artikelLeverancierId, besteldatum, leveringsdatum, levertijd, bericht 'TE LAAT' of '-------'.
SELECT
	bestellingen.bestelId, 
	bestellijnen.artikelLeverancierId, 
	bestelDatum, 
	leveringsDatum, 
	levertijd, 'TE LAAT' as bericht
FROM bestellingen
INNER JOIN bestellijnen ON bestellingen.bestelId=bestellijnen.bestelId
INNER JOIN artikelsleveranciers ON artikelsleveranciers.artikelLeverancierId=bestellijnen.artikelLeverancierId
WHERE datediff(leveringsDatum,bestelDatum) > levertijd
UNION
SELECT bestellingen.bestelId, bestellijnen.artikelLeverancierId, bestelDatum, leveringsDatum, levertijd, '-------' as bericht
FROM bestellingen
INNER JOIN bestellijnen ON bestellingen.bestelId=bestellijnen.bestelId
INNER JOIN artikelsleveranciers ON artikelsleveranciers.artikelLeverancierId=bestellijnen.artikelLeverancierId
WHERE datediff(leveringsDatum,bestelDatum) <= levertijd
ORDER BY bestelId ;
-- my solution 
SELECT 
    bestellingen.bestelId, 
    bestellijnen.artikelLeverancierId, 
    bestellingen.bestelDatum, 
    bestellingen.leveringsDatum, 
    bestellingen.levertijd,
    CASE 
        WHEN DATEDIFF(bestellingen.leveringsDatum, bestellingen.bestelDatum) > bestellingen.levertijd THEN 'TE LAAT'
        ELSE '-------'
    END AS bericht
FROM 
    bestellingen
INNER JOIN 
    bestellijnen ON bestellingen.bestelId = bestellijnen.bestelId
INNER JOIN 
    artikelsleveranciers ON bestellijnen.artikelLeverancierId = artikelsleveranciers.artikelLeverancierId
ORDER BY 
    bestellingen.bestelId;

-- Welke planten zijn hoger dan de gemiddelde hoogte van alle planten samen? Toon alle gegevens. 
SELECT *
FROM 
	planten
	WHERE hoogte > (SELECT AVG(hoogte) FROM planten);
-- Welke planten zijn duurder dan de gemiddelde prijs van de bomen? Toon alle gegevens.
SELECT *
FROM 
	planten
WHERE prijs > (
    SELECT AVG(prijs)
    FROM planten
    WHERE soort = 'boom'
);
-- Maak een overzicht van de leveranciers (alle gegevens) waar nog bestellingen uitstaan met een leverdatum die vóór 1 april 2016 ligt.
SELECT *
FROM leveranciers
WHERE leverancierId IN (
    SELECT leverancierId 
    FROM bestellingen 
    WHERE leveringsDatum < '2016-04-01')
order by leverancierId;
-- Welke rijen hebben de laagste offerteprijs van alle offertes in de table artikelsleveranciers? Geef alle gegevens
select *
from 
	artikelsleveranciers
where  offertePrijs = (select min(offertePrijs) from artikelsleveranciers) ;

-- Welke planten zijn lager dan de laagste vaste plant?Toon alle gegevens.
-- Planten waar de hoogte 0 is, worden niet meegerekend.

SELECT *
FROM planten
WHERE hoogte > 0 AND hoogte < (
    SELECT min(hoogte)
    FROM planten
    WHERE soort = 'vast' AND hoogte > 0
);
-- Welke planten zijn hoger dan de gemiddelde hoogte van vaste planten en tevens goedkoper dan de gemiddelde prijs van vaste planten? Geef alle gegevens.
select *

from 
	planten

where hoogte and prijs > ( 
	select avg(hoogte) and avg(prijs) 
    from planten
    where soort = 'vast');
    

SELECT *
FROM planten
WHERE hoogte > (
    SELECT AVG(hoogte) 
    FROM planten
    WHERE soort = 'vast'
)
AND prijs > (
    SELECT AVG(prijs) 
    FROM planten
    WHERE soort = 'vast'
);
-- Welke planten hebben een prijs die tussen de laagste en hoogste prijs van de klimplanten ligt? Geef alle gegevens.
SELECT *
FROM planten
WHERE prijs > (
    SELECT MIN(prijs)
    FROM planten
    WHERE soort = 'klim'
)
AND prijs < (
    SELECT MAX(prijs)
    FROM planten
    WHERE soort = 'klim'
);
-- Maak een overzicht van de plantIds die een lagere offerteprijs hebben dan de gemiddelde offerteprijs voor de betreffende plantId.
-- Plaats de gegevens plantId, leveranciersnaam en offerteprijs op het overzicht. Sorteer op 'plantId'.

 SELECT 
    artikelsleveranciers.plantId,
    leveranciers.leverancierNaam,
    artikelsleveranciers.offertePrijs
FROM 
    artikelsleveranciers
INNER JOIN 
    leveranciers ON artikelsleveranciers.leverancierId = leveranciers.leverancierId
WHERE 
    artikelsleveranciers.offertePrijs < (
        SELECT 
            AVG(offertePrijs) 
        FROM 
            artikelsleveranciers AS avg_prices 
        WHERE 
            avg_prices.plantId = artikelsleveranciers.plantId
    )
ORDER BY 
    artikelsleveranciers.plantId;



 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

















        
    


