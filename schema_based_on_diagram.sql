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

-- Create invoices table

CREATE TABLE invoices (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history__id INTEGER REFERENCES medical_histories(id),
    PRIMARY KEY (id)
);

-- Create treatments table

CREATE TABLE treatments (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    type VARCHAR(250),
    name VARCHAR(250),
    PRIMARY KEY (id)
);
