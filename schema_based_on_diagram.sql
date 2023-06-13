-- Create patients table:

CREATE TABLE patients (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    date_of_birth DATE,
    PRIMARY KEY (id)
);

-- Create medical_histories table:

CREATE TABLE medical_histories (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    admitted_at TIMESTAMP,
    patient_id INTEGER REFERENCES patients(id),
    status VARCHAR(250),
    PRIMARY KEY (id)
);
