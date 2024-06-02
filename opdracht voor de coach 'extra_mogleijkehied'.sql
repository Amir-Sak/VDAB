SELECT * FROM video.films;
-- Geef een lijst van de films die in de titel noch het woord "kill" noch het woord "blood" hebben. We willen enkel de films van de genres griezel en thriller.

SELECT *
FROM 
	films
inner join 
	genres
		on films.genreId = genres.genreId        
where  
	genre in('griezel', 'thriller') 
and  
	titel NOT in('%kill%','%blood%');
-- Maak een lijst van wie welke films huurt. Sorteer oplopend op naam en titel.
select 
	klanten.klantId,
    klanten.naam,
    verhuringen.filmId,
    films.titel
from 
	klanten
inner join
	verhuringen
	on klanten.klantId = verhuringen.klantId 
inner join
	films
    on verhuringen.filmId = films.filmId
order by naam,titel ;
-- Wat is de totale voorraad per genre?
select 
	(voorraad - verhuurd) as totaal,
    genres.genre
from
	films
inner join
	genres
		on films.genreId =genres.genreId
group by genre
order by genre;

SELECT 
	films.filmId,
    films.titel,
    SUM(voorraad - verhuurd) as totaal,
    genres.genre
FROM
    films
INNER JOIN
    genres ON films.genreId = genres.genreId
GROUP BY genre
ORDER BY genre;
SELECT 
    films.filmId,
    films.titel,
    films.verhuurd,
    films.voorraad,
    (films.voorraad - films.verhuurd) as totaal,
    genres.genre
FROM
    films
INNER JOIN
    genres ON films.genreId = genres.genreId
ORDER BY genre;
-- Geef alle gegevens van de duurste film
select *
from
	films
where prijs = (select max(prijs) from films);


    
