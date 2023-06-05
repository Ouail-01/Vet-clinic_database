/* Create the database */
CREATE DATABASE vet_clinic;

/* Create animals table */
CREATE TABLE animals (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutred BOOLEAN,
    decimal DECIMAL,
    PRIMARY KEY (id)
);