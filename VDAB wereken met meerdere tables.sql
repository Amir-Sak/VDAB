--  lijst van alle bieren met daarbij de naam van de brouwerij.
select 
	bieren.Naam,
    brouwers.BrNaam
from 
	bieren
inner join
	brouwers
on bieren.BrouwerNr = brouwers.BrouwerNr ;
-- Geef een lijst van alle bieren met de velden 'naam', 'brouwerij' en 'soort'. 
select 
	bieren.Naam,
    brouwers.BrNaam,
    soorten.soort
from 
	bieren
inner join
	soorten
on bieren.SoortNr = soorten.SoortNr
inner join
	brouwers
on  bieren.BrouwerNr = brouwers.BrouwerNr;
-- Maak een lijst van brouwers die in dezelfde gemeente wonen.
-- Aan de table 'brouwers' wordt telkens een aliasnaam gegeven. Als je een kolomnaam gebruikt, ben je verplicht om die aliasnaam te gebruiken.
SELECT
    t1.BrNaam AS Brouwer1,
    t2.BrNaam AS Brouwer2,
    t1.Gemeente
FROM 
    brouwers AS t1
JOIN
    brouwers AS t2
ON t1.Gemeente = t2.Gemeente
AND t1.BrouwerNr < t2.BrouwerNr; 
-- -----------------
-- Maak een overzicht van de bestellingen met het bestelnummer, de naam van de leverancier en de leverdatum.

SELECT 
    bestellingen.bestelId,
    leveranciers.leveranciernaam,
    leveranciers.leverancierId,
	bestellingen.leveringsDatum
FROM 
    bestellingen
INNER JOIN 
    leveranciers
ON 
    bestellingen.leverancierId = leveranciers.leverancierId;
-- planten hebben een levertijd van maximum 10 dagen?

SELECT 
    planten.plantId, 
    artikelsleveranciers.artikelLeverancierCode, 
    planten.plantNaam, 
    artikelsleveranciers.levertijd
FROM 
    artikelsleveranciers 
INNER JOIN 
    planten
ON 
    artikelsleveranciers.plantId = planten.plantId
WHERE 
    artikelsleveranciers.levertijd <= 10;
-- Geef een overzicht waaruit blijkt bij welke leverancier(s) de planten besteld kunnen worden.
-- In het overzicht moeten de volgende gegevens staan: plantid, plantennaam, leverancierscode, naam van de leverancier, levertijd en offerteprijs.
-- Sorteer het overzicht op plantennaam. 
SELECT 
    planten.plantId, 
    planten.plantNaam, 
    leveranciers.leverancierId, 
    leveranciers.leverancierNaam, 
    artikelsleveranciers.levertijd, 
    artikelsleveranciers.offerteprijs 
FROM 
    planten
INNER JOIN 
    artikelsleveranciers 
ON 
    planten.plantId = artikelsleveranciers.plantId
INNER JOIN 
    leveranciers 
ON 
    artikelsleveranciers.leverancierId = leveranciers.leverancierId
ORDER BY 
    plantNaam;
-- Maak een overzicht van die planten die een prijs hebben die minstens 50% boven de offerteprijs ligt.
-- Geef plantId, plantennaam, prijs van de plant, leveranciersId en offerteprijs.
-- Sorteer je lijst op plantennaam.

select 
	planten.plantId,
    planten.plantNaam,
    planten.prijs,
    artikelsleveranciers.plantId,
    artikelsleveranciers.leverancierId,
    artikelsleveranciers.offertePrijs
from 
	planten 
inner JOIN
	artikelsleveranciers
ON planten.plantId = artikelsleveranciers.plantId
WHERE prijs >= (offertePrijs * 1.5)
order by plantNaam;
-- Hoeveel verschillen de gehanteerde bestelprijzen met de huidige offerteprijzen?
-- Presenteer in de lijst de gegevens bestelnummer, artikelcode van de leverancier en het positieve of negatieve verschil.
SELECT 
    bestellijnen.bestelId, 
    artikelsleveranciers.artikelLeverancierCode, 
    bestellijnen.bestelPrijs - artikelsleveranciers.offertePrijs AS verschil
FROM 
    artikelsleveranciers 
INNER JOIN 
    bestellijnen
ON 
    artikelsleveranciers.artikelLeverancierId = bestellijnen.artikelLeverancierId;

-- In welke plaatsen kan het tuincentrum vaste planten bestellen?
select 
	planten.plantId,
    planten.plantNaam,
    planten.soort,
    leveranciers.woonplaats
    
from 
	planten
inner join 
	leveranciers
on planten.leverancierid = leveranciers.leverancierId
where soort = 'vast';
SELECT DISTINCT 
    leveranciers.woonplaats 
FROM 
    leveranciers
INNER JOIN 
    artikelsleveranciers 
ON 
    leveranciers.leverancierId = artikelsleveranciers.leverancierId
INNER JOIN 
    planten 
ON 
    artikelsleveranciers.plantId = planten.plantId
WHERE 
    planten.soort = 'vast';
-- Maak een overzicht van alle rode planten geleverd door leveranciers die niet in Aalsmeer wonen.
-- Vermeld de gegevens plantId, plantennaam, soort, naam van de leverancier, woonplaats.
-- Sorteer op soort en plantennaam.
SELECT 
    planten.plantId, 
    planten.plantNaam, 
    planten.soort, 
    leveranciers.leverancierNaam, 
    leveranciers.woonplaats 
FROM 
    planten
INNER JOIN 
    artikelsleveranciers 
ON 
    planten.plantId = artikelsleveranciers.plantId
INNER JOIN 
    leveranciers 
ON 
    artikelsleveranciers.leverancierId = leveranciers.leverancierId
WHERE 
    leveranciers.woonplaats <> 'Aalsmeer' 
    AND planten.kleur = 'rood'
ORDER BY 
    planten.soort, 
    planten.plantNaam;
-- Bepaal voor iedere artikelcode de laagste offerteprijs.
-- Vermeld in het overzicht plantId, plantennaam en de bijbehorende offerteprijs.
-- Sorteer het overzicht op plantennaam.
SELECT 
    planten.plantId, 
    planten.plantNaam, 
    MIN(artikelsleveranciers.offertePrijs) AS minimum 
FROM 
    planten 
INNER JOIN 
    artikelsleveranciers
ON 
    planten.plantId = artikelsleveranciers.plantId
GROUP BY 
    planten.plantNaam, 
    planten.plantId
ORDER BY 
    2;
-- Zoek de bestellingen welke een besteldatum hebben die gelijk is aan de leverdatum van één of meer andere bestellingen.
-- Geef bestelnummer 1e bestelling, besteldatum 1e bestelling, bestelnummer 2e bestelling, leveringsdatum 2e bestelling.
SELECT 
    e.bestelId as eerstenr, 
    e.bestelDatum as eerstedatum, 
    t.bestelId as tweedenr, 
    t.leveringsDatum as tweededatum
FROM 
    bestellingen e 
INNER JOIN 
    bestellingen t
ON 
    e.bestelDatum = t.leveringsDatum 
    AND e.bestelId <> t.bestelId;

























