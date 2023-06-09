/* Find all animals whose name ends in "mon". */

SELECT * FROM animals WHERE name like '%mon';

/* List the name of all animals born between 2016 and 2019. */

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

/* List the name of all animals that are neutered and have less than 3 escape attempts. */

SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

/* List the date of birth of all animals named either "Agumon" or "Pikachu". */

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

/* List name and escape attempts of animals that weigh more than 10.5kg */

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

/* Find all animals that are neutered. */

SELECT * FROM animals WHERE neutered = true;

/* Find all animals not named Gabumon. */

SELECT * FROM animals WHERE name <> 'Gabumon';

/* Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg) */

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* ROLLBACK */

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/* COMMIT */

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

/* ROLLBACK after delete all records at animals */

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/* Transaction */

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01_01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO SP1;
SELECT * FROM animals;
UPDATE animals SET weight_kg = weight_kg * -1 where weight_kg < 0;
SELECT * FROM animals;
COMMIT;

/* How many animals are there? */

SELECT COUNT(*) FROM animals;

/* How many animals have never tried to escape? */

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

/* What is the average weight of animals? */

SELECT AVG(weight_kg) FROM animals;

/* Who escapes the most, neutered or not neutered animals? */

SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

/* What is the minimum and maximum weight of each type of animal? */

SELECT species, min(weight_kg) AS min_weight, max(weight_kg) AS max_weight FROM animals GROUP BY species;

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */

SELECT species, AVG(escape_attempts) AS average_escape FROM animals 
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/* What animals belong to Melody Pond? */

SELECT name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon). */

SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.id = 1;

/* List all owners and their animals, remember to include those that don't own any animal. */

SELECT full_name, name FROM animals RIGHT JOIN owners ON animals.owner_id = owners.id;

/* How many animals are there per species? */

SELECT species.name, COUNT(*) FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.id;

/* List all Digimon owned by Jennifer Orwell. */

SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id Join species ON animals.species_id = species.id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

/* List all animals owned by Dean Winchester that haven't tried to escape. */

SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id Join species ON animals.species_id = species.id WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

/* Who owns the most animals? */

SELECT full_name, COUNT(*) AS animal_count FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY full_name ORDER BY COUNT(*) DESC LIMIT 1;

-- Who was the last animal seen by William Tatcher?

SELECT animals.name, vets.name AS vets_last_visit FROM animals JOIN visits ON visits.animals_id = animals.id JOIN vets ON vets.id = visits.vets_id WHERE vets.name = 'William Tatcher' ORDER BY visits.visits_date DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?

SELECT vets.name, count(animals.name) AS vets_check FROM animals JOIN visits ON visits.animals_id = animals.id JOIN vets ON vets.id = visits.vets_id WHERE vets.name = 'Stephanie Mendez' GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.

SELECT vets.name, species.name AS specializations FROM vets LEFT JOIN specializations ON vets.id = specializations.vets_id LEFT JOIN species ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT animals.name, vets.name AS vets_name, visits.visits_date FROM animals JOIN visits ON visits.animals_id = animals.id JOIN vets ON vets.id = visits.vets_id WHERE vets.name = 'Stephanie Mendez' AND visits.visits_date BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?

SELECT animals.name, count(animals_id) AS most_visits from animals JOIN visits ON animals.id = visits.animals_id GROUP BY animals.name ORDER BY count(animals_id) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?

SELECT animals.name, vets.name AS vets_name, visits_date AS first_visit FROM animals JOIN visits ON visits.animals_id = animals.id JOIN vets ON vets.id = visits.vets_id WHERE vets.name = 'Maisy Smith' ORDER BY visits.visits_date ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT animals.name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg, vets.name AS vets_name, vets.age, species.name AS vets_species, visits_date AS most_recent_visit FROM animals JOIN visits ON visits.animals_id = animals.id 
JOIN vets ON vets.id = visits.vets_id Join species ON vets.id = species.id ORDER BY visits.visits_date DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(visits.vets_id) FROM vets LEFT JOIN specializations ON specializations.vets_id = vets.id JOIN visits ON visits.vets_id = vets.id WHERE specializations.species_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT species.name, COUNT(species.name)  AS most_species FROM animals JOIN visits ON visits.animals_id = animals.id JOIN species ON species.id = animals.species_id JOIN vets ON vets.id = visits.vets_id LEFT JOIN specializations ON specializations.vets_id = vets.id WHERE vets.name = 'Maisy Smith' GROUP BY species.name ORDER BY count(*) DESC;
