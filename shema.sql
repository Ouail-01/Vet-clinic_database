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