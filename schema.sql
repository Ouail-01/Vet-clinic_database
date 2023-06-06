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