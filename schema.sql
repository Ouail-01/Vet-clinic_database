/* Create the database */
CREATE DATABASE vet_clinic;

/* Create animals table */
CREATE TABLE animals (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY (id)
);

/* Add a column species of type string to animals table */

ALTER TABLE animals ADD COLUMN species VARCHAR(250);

/* Create owners table */
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(250),
    age INTEGER
);

/* Create species table */
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(250)
);

/* Modify animals table */
  /* Remove column species */
    ALTER TABLE animals DROP COLUMN species;
  /* Add column species_id which is a foreign key referencing species table */
    ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id);
  /* Add column owner_id which is a foreign key referencing the owners table */
    ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners(id);

/* Create vets table */
CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name VARCHAR(150),
  age INTEGER,
  date_of_graduation DATE
);

/* Create "join table" called specializations */
CREATE TABLE specializations (
  vets_id INTEGER REFERENCES vets(id),
  species_id INTEGER REFERENCES species(id)
);

/* Create "join table" called visits */
CREATE TABLE visits (
  animals_id INTEGER REFERENCES animals(id),
  vets_id INTEGER REFERENCES vets(id),
  visits_date DATE
);