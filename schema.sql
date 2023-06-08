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