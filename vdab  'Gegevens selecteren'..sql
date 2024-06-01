-- lijst met de namen van alle brouwerijen.
SELECT 
	brNaam 
FROM 	
	brouwers;
--  lijst met de naam en het alcoholpercentage van alle bieren.
SELECT 
	Naam, 
    Alcohol
from bieren.bieren;
-- lijst met alle gegevens van alle bieren
select *
from  bieren;
-- lijst van gemeentes waar de brouwerijen gevestigd zijn
select distinct 
	Gemeente
from bieren.brouwers;
-- ----------------------------------------------------------------------------------------------------
-- lijst met alle bieren met een alcoholpercentage lager dan 5%.
select Naam,
Alcohol
	from bieren
		where Alcohol <= 5 ;
--  lijst van alle brouwerijen in Beersel.  
select *
	from brouwers
		where Gemeente = 'Beersel';
-- lijst met bieren waarbij de naam de tekst 'ale' bevat.
select *
	from bieren
		where Naam like '%ale%';
-- lijst met alle bieren met een alcoholpercentage tussen 5% en 7%.
select 
	Naam,
	Alcohol
from bieren
	where Alcohol between 5 and 7;
-- lijst met alle bieren met 0%, 5% of 8% als alcoholpercentage.
select 
	Naam,
	Alcohol
from bieren
	where Alcohol in(0, 5, 8);
  --  lijst van de brouwerijen uit Leuven, Genk, Antwerpen, Dendermonde en Wevelgem.
 
SELECT *
FROM brouwers
	WHERE Gemeente IN ('Leuven', 'Genk', 'Antwerpen', 'Dendermonde', 'Wevelgem');
    -- lijst met alle bieren waarbij het alcoholpercentage niet ingevuld is.
    select 
	Naam,
	Alcohol
from bieren
	where Alcohol is null ;
-- --------------------------------------------------------------------------------------------------------
--  lijst met alle bieren waarbij in de naam het woord 'wit' voorkomt en met een alcoholpercentage hoger dan 5.
select * 
from 
	bieren
	where Naam Like '%wit%' and Alcohol >= 5;

 -- lijst met alle bieren waarbij het woord 'wit' niet in de naam voorkomt.
 select * 
from 
	bieren
	where Naam not Like '%wit%';
-- ------------------------------------------------------------------------------
-- alfabetische lijst van de bieren met hun alcoholpercentage.
SELECT 
	Naam,
    Alcohol
from 
	bieren
order by Naam ASC ;
SELECT 
	Naam,
    Alcohol
from 
	bieren
order by 1 ASC ;
-- ijst met alle bieren (naam en alcoholpercentage). De bieren met het hoogste alcoholpercentage staan bovenaan. Zorg ook voor een sortering op naam.
SELECT 
	Naam,
    Alcohol
from 
	bieren
order by Alcohol DESC, Naam ASC ;
-- ----------------------------- -
-- overzicht, met alle gegevens, van de leveranciers uit Aalsmeer.
select *
from leveranciers
where woonplaats = 'AALSMEER';
--  alfabetisch overzicht op plantennaam, met plantId, plantennaam en prijs, van alle planten.
SELECT 
	plantId,
	plantNaam,
    prijs
from planten
order by 2;

-- Welke planten beginnen in de maand maart te bloeien?Toon plantId, plantennaam, en de beginmaand van de bloeiperiode.
SELECT 
	plantId, 
    plantNaam,
    beginBloeiMaand
from 
	planten
WHERE beginBloeiMaand = 3 ;
-- Maak een overzicht uit de table 'artikelsleveranciers', 
-- gesorteerd op plantId en binnen plantId een sortering op artikelcode van de leverancier.Toon alleen de gegevens plantId, artikelcode van de leverancier en leverancierId.
SELECT 
	plantId,
    artikelLeverancierCode,
	leverancierId
FROM artikelsleveranciers
order by plantId, artikelLeverancierCode;
-- gesorteerd overzicht van alle waterplanten. Sorteer op hoogte, grootste voorop.
select *
from planten
where soort = 'water' 
order by hoogte desc ;
-- lijst van de verschillende kleuren die bij de planten uit de table planten horen.
select 	
	plantNaam,
    kleur
FROM planten
order by kleur;
--  lijst van alle planten waarvan de kolom kleur niet ingevuld is.
select 	
	plantNaam,
    kleur
FROM planten
where kleur is null
order by kleur;
-- Toon de verschillende soorten planten in de table 'planten'.
select distinct	
	plantNaam,
    soort
FROM planten
order by soort;
--  overzicht van alle vaste planten met gele bloemen. Van iedere plant toon je de volgende gegevens: plantId, plantennaam, hoogte en de beginmaand van de bloeiperiode.
SELECT 
	plantId, 
	plantNaam, 
	hoogte, 
	beginBloeiMaand
FROM planten
	WHERE kleur='geel' and soort='vast';
-- alle planten met een prijs boven de 10 € die niet tot de soort bomen behoren.
SELECT *
FROM planten
	WHERE prijs > 10 and soort <> 'boom';
   -- lijst van alle planten die in juni beginnen te bloeien en witte bloemen geven en tevens van alle planten die in augustus voor het eerst bloeien en gele bloemen hebben.
   -- Plaats alle beschikbare gegevens in het overzicht. 
select *
from planten
	where (beginBloeiMaand = '6' and kleur = 'wit')
    or (beginBloeiMaand = '8' and kleur = 'gele');
   
-- Welke planten met gemengde bloeikleuren worden maximum 60 cm hoog?  
select *
from planten
	where  hoogte <= '60' and kleur = 'gemengd';
-- overzicht van alle leveranciers die niet in Hillegom wonen.
select *
FROM leveranciers    
   where woonplaats not like 'hillegom';
   -- welke planten is de kleur onbekend? Geef plantId en plantennaam.
SELECT 
	plantId, 	
    plantNaam,
    kleur
FROM planten
	WHERE kleur is Null;
    -- Welke planten bloeien in ieder geval in de ganse periode augustus tot en met oktober? 
SELECT 
	*
FROM planten
	WHERE eindBloeiMaand >= 10 and beginBloeiMaand <= 8 ;
--  planten bloeien in ieder geval in de maand september
SELECT *
FROM planten
	WHERE eindBloeiMaand >= 9 and beginBloeiMaand <= 9 ;
-- overzicht van alle vaste planten met een prijs tussen €3 en €5.
SELECT *
FROM planten
	WHERE soort = 'vast' and (prijs between 3 and 5 );
-- verzicht van alle planten die in maart, april, september of oktober beginnen te bloeien.
SELECT *
FROM planten
	WHERE beginBloeiMaand in (4, 3, 10 , 9);
-- welke planten is zowel de kleur als de hoogte onbekend? Geef plantId, plantennaam, kleur en hoogte.
SELECT *
FROM planten
	WHERE kleur is null and hoogte is null;
-- Bij welke planten komt het woord BOOM voor?
select *
FROM planten
	WHERE plantNaam like '%boom%';
-- Geef plantId en plantennaam van alle planten die als derde letter een 'N' hebben.
SELECT *
FROM planten
	WHERE plantNaam like '___n%';
-- Welke 1- en 2-jarige planten staan er in de table 'planten'?Probeer deze vraag met en zonder de operator like op te lossen.
SELECT *
FROM planten
	WHERE soort in ('1-jarig', '2-jarig');
SELECT *
FROM planten
	WHERE soort like '_-jarig';
-- Geef een overzicht van alle planten, behalve de bomen en de heesters, die tussen de 100 en 200 cm hoog zijn, rode of blauwe bloemen geven, en vóór augustus beginnen te bloeien.
-- Alle gegevens behalve de prijs zijn belangrijk.
-- Sorteer de lijst op 'soort' en binnen soort op 'plantennaam'.
SELECT 
	plantId, 
    plantNaam, 
    soort, 
    kleur, 
    hoogte, 
    beginBloeiMaand, 
    eindBloeiMaand
FROM planten
WHERE soort not in ('boom', 'heester') and hoogte between 100 and 200 and kleur in ('rood', 'blauw') and beginBloeiMaand<8
ORDER BY soort, plantNaam ;
-- plantId en plantennaam van alle planten die beginnen met de letter 'L' en eindigen met de letter 'E'.
SELECT *
FROM planten
WHERE plantNaam like 'l%e';
-- Welke planten hebben een plantennaam van precies 5 letters lang? 
SELECT *
FROM planten
WHERE plantNaam like '_____';
-- planten hebben een plantennaam van minimum 5 letters lang? 
SELECT *
FROM planten
WHERE plantNaam like '_______%';
-- -------------------------------------------------------------------------------------------
-- Aggregate functie-----
-- het totaal aantal bieren kennen
select distinct 
	count(Naam) as antaal 
from bieren;
-- het gemiddelde, het grootste, het kleinste en het totale alcoholpercentage uit de table 'bieren'. 
SELECT 
	avg(Alcohol) as gem,
    max(Alcohol) as max ,
    min(Alcohol) as min,
    sum(Alcohol) as som
from bieren;
-- het antaal tafelbieren 
select*
from bieren;
-- Berekeningen: voorbeeld-------
 -- lijst van alle brouwerijen met hun omzet in dollar en in yen. 
 select *
 from brouwers ;
 -- Hoeveel leveranciers telt ons tuincentrum?
 select 
	count(*)
 from leveranciers;
-- gemiddelde prijs van alle waterplanten.
SELECT 
	plantNaam,
	avg(prijs) as gem
from planten
where soort = 'water'
group by plantNaam;
-- Geef de gemiddelde, de laagste en de hoogste offerteprijs van leverancier 4. 
select 
	avg(offertePrijs),
    min(offertePrijs),
    max(offertePrijs)
 from artikelsleveranciers
 where leverancierId = 4;
-- Geef bestelnummer, artikelLeverancierId en het totale bestelbedrag per bestelrij uit de table 'bestellijnen'.
 SELECT 
	bestelId,
    artikelLeverancierId,
    (aantal * bestelPrijs) as bedrag
 from bestellijnen;
-- een overzicht van de heesters uit de table 'planten', waarbij je de prijzen met 5% verhoogt.
select 
	plantNaam,
    plantId,
    (prijs*1.05) as nieuw_prijz
from planten
where soort = 'heester';
--  Hoeveel stuks van leveranciersartikelnummer 59 zijn er besteld?
select 
	sum(aantal)
from bestellijnen
where artikelLeverancierId = '59';
-- Bereken het gemiddelde alcoholpercentage per brouwer
select 
	avg(Alcohol) as gem ,
    BrouwerNr
from bieren
group by BrouwerNr
order by BrouwerNr ;
-- Bepaal het minimum alcoholpercentage per brouwernr. De lijst toont enkel de brouwernr's en percentages die kleiner zijn dan 5%.
select BrouwerNr,
		min(Alcohol) as min
from bieren
group by BrouwerNr
having min < '5'
order by BrouwerNr;
-- Bereken het gemiddelde alcoholpercentage per brouwernr voor alle brouwers die meer dan 10 bieren produceren.
 
 SELECT 
	BrouwerNr,
    avg(Alcohol) as gem
 from bieren
 group by BrouwerNr
 having count(BierNr) > 50
 order by BrouwerNr;
 select distinct Naam
 from bieren
 where BierNr> 50;
-- Tel het aantal planten per plantensoort uit de table 'planten'. 
SELECT distinct
	soort,
	count(soort) as aantal  
FROM planten
group by soort ;
-- Tel het aantal bestelregels per bestelling.
select 
	bestelId,
    count(*)
from bestellijnen
group by bestelId;
-- Wat is de gemiddelde prijs per plantensoort?
SELECT 
    soort,
    AVG(prijs) AS gem 
FROM 
    palnten
GROUP BY  
    soort;
-- Hoeveel planten zijn er per plantensoort-kleurgroep?
select 
	soort,
    kleur,
    count(soort) as aantal
from planten
group by soort, kleur; 
-- overzicht zodat duidelijk is welke kleur van de vaste planten de hoogste gemiddelde prijs heeft. 

SELECT 
    kleur,
    AVG(prijs) AS gem 
FROM 
    planten
WHERE 
    soort = 'vast'
GROUP BY 
    kleur
ORDER BY 
    AVG(prijs) DESC;
-- Laat per leveranciersId het aantal artikelen zien dat de leverancier aanbiedt onder voorwaarde dat de levertijd van het artikel minder dan 18 dagen is.
 select 
	leverancierId,
    count(artikelLeverancierId) as aantal 
 from artikelsleveranciers 
 where levertijd < '18'
 group by leverancierId
 order by leverancierId;
 -- gemiddelde prijs per plantensoort, exclusief de geelbloemige planten?
 SELECT 
    soort,
    avg(prijs) as gem 
 from planten
 where kleur not like 'geel'
 group by soort
 order by soort asc;
 -- Tel het aantal planten per prijs. De prijs moet je afronden op een geheel getal.
 select 
	round(prijs,0) as afgerond,
    count(*)
 from planten
 group by afgerond ;
 
 
 
 
 
 
 
 