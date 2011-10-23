DROP TABLE degrees;
DROP TABLE applicants;
DROP TABLE universities;
DROP TABLE disciplines;
DROP TABLE countries;
DROP TABLE specializations;

CREATE TABLE universities (
	ID SERIAL PRIMARY KEY,
	location TEXT NOT NULL,
	name TEXT NOT NULL
);

CREATE TABLE disciplines (
	ID SERIAL PRIMARY KEY,
	name TEXT NOT NULL
);

CREATE TABLE countries (
	ID SERIAL PRIMARY KEY,
	name TEXT NOT NULL
);

CREATE TABLE specializations (
	ID SERIAL PRIMARY KEY,
	name TEXT NOT NULL
);

CREATE TABLE applicants (
	ID SERIAL PRIMARY KEY ,
	firstName TEXT NOT NULL,
	middleName TEXT NOT NULL,
	lastName TEXT NOT NULL,
	
	streetAddress TEXT NOT NULL,
	city TEXT NOT NULL,
	state TEXT, -- Only US Residents need to enter state
	zipCode INTEGER NOT NULL,

	countryCode INTEGER, -- Only Non US Residents need to enter country code
	areaCode INTEGER NOT NULL,
	number INTEGER NOT NULL,
	
	residencyStatus TEXT, -- Only Non US citizens have a residency status
	countryOfCitizenship INTEGER REFERENCES countries (ID) NOT NULL,
	countryOfResidence INTEGER REFERENCES countries (ID) NOT NULL,
	specialization INTEGER REFERENCES specializations (ID) NOT NULL
);

CREATE TABLE degrees (
	ID SERIAL PRIMARY KEY,
	applicant INTEGER REFERENCES applicants (ID) NOT NULL,
	awardMonth INTEGER NOT NULL,
	awardYear INTEGER NOT NULL,
	title TEXT NOT NULL,
	university INTEGER REFERENCES universities (ID) NOT NULL,
	discipline INTEGER REFERENCES disciplines (ID) NOT NULL,
	gpa INTEGER NOT NULL
);

