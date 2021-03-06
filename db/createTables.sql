BEGIN;

CREATE TABLE UserAccount (
	id SERIAL,
	firstName VARCHAR(255) NOT NULL,
	lastName VARCHAR(255) NOT NULL,
	email VARCHAR(255) UNIQUE NOT NULL,
	password VARCHAR(255) NOT NULL,
	dateOfBirth DATE NOT NULL,

	CONSTRAINT PK_UserAccount PRIMARY KEY (id)
);

CREATE TABLE Category (
	id SERIAL,
	name VARCHAR(255) UNIQUE NOT NULL,
	img BYTEA NOT NULL,

	CONSTRAINT PK_Category PRIMARY KEY (id)
);

CREATE TABLE CompanyAccount (
	id SERIAL,
	name VARCHAR(255) NOT NULL,
	email VARCHAR(255) UNIQUE NOT NULL,
	password VARCHAR(255) NOT NULL,
	staffEmail VARCHAR(255) UNIQUE NOT NULL,
	staffPassword VARCHAR(255) NOT NULL,

	CONSTRAINT PK_CompanyAccount PRIMARY KEY (id)
);

CREATE TABLE Store (
	id SERIAL,
	name VARCHAR(255) UNIQUE NOT NULL,
	img BYTEA NOT NULL,
	address VARCHAR(255) NOT NULL,
	categoryId INT NOT NULL,
	companyId INT NOT NULL,

	CONSTRAINT PK_Store PRIMARY KEY (id),
	CONSTRAINT FK_Store_Category FOREIGN KEY (categoryId) REFERENCES Category(id) ON DELETE CASCADE,
	CONSTRAINT FK_Company FOREIGN KEY (companyId) REFERENCES CompanyAccount(id) ON DELETE CASCADE
);

CREATE TABLE Counter (
	id SERIAL,
	name VARCHAR(255) UNIQUE NOT NULL,
	storeId INT NOT NULL,
	hasStaff BOOLEAN NOT NULL,

	CONSTRAINT PK_Counter PRIMARY KEY (id),
	CONSTRAINT FK_Counter_Store FOREIGN KEY (storeId) REFERENCES Store(id) ON DELETE CASCADE
);

CREATE TABLE Ticket (
	id SERIAL,
	storeId INT NOT NULL,
	counterId INT NOT NULL,
	userId INT NOT NULL,
	canceled BOOLEAN NOT NULL,
	enteringTime TIMESTAMP NOT NULL,
	leavingTime TIMESTAMP,
	staffCounter VARCHAR(255),

	CONSTRAINT PK_Ticket PRIMARY KEY (id),
	CONSTRAINT FK_Ticket_Store FOREIGN KEY (storeId) REFERENCES Store(id) ON DELETE CASCADE,
	CONSTRAINT FK_Ticket_Counter FOREIGN KEY (counterId) REFERENCES Counter(id) ON DELETE CASCADE,
	CONSTRAINT FK_Ticket_User FOREIGN KEY (userId) REFERENCES UserAccount(id) ON DELETE CASCADE
);

CREATE TABLE Schedule (
	id SERIAL,
	storeId INT NOT NULL,
	day VARCHAR(255) NOT NULL,
	openingTime TIME NOT NULL,
	closingTime TIME NOT NULL,

	CONSTRAINT PK_Schedule PRIMARY KEY (id),
	CONSTRAINT FK_Schedule_Store FOREIGN KEY (storeId) REFERENCES Store(id) ON DELETE CASCADE
);

COMMIT;
