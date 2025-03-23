CREATE DATABASE GameWorld;

BEGIN;

-- TABLES

CREATE TABLE Items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    skill VARCHAR(255) NOT NULL,
    power INT NOT NULL,
    description TEXT,
    stackable BOOLEAN NOT NULL,
    useDialogue TEXT
);

CREATE TABLE Game (
    gameId SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    parentCharacterId INT NOT NULL,
    maxNodes INT NOT NULL
);

CREATE TABLE Nodes (
    id SERIAL PRIMARY KEY,
    gameId INT NOT NULL
);

CREATE TABLE Characters (
    id INT PRIMARY KEY,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    gender VARCHAR(1) NOT NULL,
    description TEXT NOT NULL,
    birthdate DATE NOT NULL,
    parentId INT,
    health INT NOT NULL DEFAULT 5,
    currentNodeId INT
);

CREATE TABLE NodeStatChanges (
    nodeId INT NOT NULL,
    characterId INT,
    stat VARCHAR(30) NOT NULL,
    change INT NOT NULL,
    PRIMARY KEY (nodeId, characterId, stat)
);

CREATE TABLE Locations (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    x INT NOT NULL,
    y INT NOT NULL
);

CREATE TABLE LocationOverrides (
    locationId INT NOT NULL,
    nodeId INT NOT NULL,
    description TEXT NOT NULL
);

CREATE TABLE NodeAction (
    Id SERIAL PRIMARY KEY,
    nodeId INT NOT NULL,
    characterId INT NOT NULL,
    description TEXT NOT NULL
);

CREATE TABLE NodeActionCharacter (
    nodeId INT NOT NULL,
    characterId INT NOT NULL,
    itemId INT NOT NULL,
    quantityChange INT NOT NULL,
    PRIMARY KEY (nodeId, characterId, itemId)
);

CREATE TABLE NodeItemChanges (
    nodeId INT NOT NULL,
    characterId INT NOT NULL,
    itemId INT NOT NULL,
    quantityChange INT NOT NULL,
    PRIMARY KEY (nodeId, characterId, itemId)
);

CREATE TABLE NodeDialogue(
    nodeId INT NOT NULL,
    characterId INT NOT NULL,
    toCharacterId INT NOT NULL,
    message TEXT NOT NULL,
    PRIMARY KEY (nodeId, characterId)
);

CREATE TABLE NodeHealthChanges (
    nodeId INT NOT NULL,
    characterId INT NOT NULL,
    toCharacterId INT NOT NULL,
    healthChange INT NOT NULL,
    PRIMARY KEY (nodeId, characterId, toCharacterId)
);

-- FOREIGN KEYS

ALTER TABLE Game
    ADD CONSTRAINT fk_parentCharacterId FOREIGN KEY (parentCharacterId) REFERENCES Characters(id);

ALTER TABLE Nodes
    ADD CONSTRAINT fk_gameId FOREIGN KEY (gameId) REFERENCES Game(gameId);

ALTER TABLE Characters
    ADD CONSTRAINT fk_currentNodeId FOREIGN KEY (currentNodeId) REFERENCES Nodes(id),
    ADD CONSTRAINT fk_parentId FOREIGN KEY (parentId) REFERENCES Characters(id);

ALTER TABLE NodeStatChanges
    ADD CONSTRAINT fk_characterId FOREIGN KEY (characterId) REFERENCES Characters(id),
    ADD CONSTRAINT fk_nodeId FOREIGN KEY (nodeId) REFERENCES Nodes(id);

ALTER TABLE LocationOverrides
    ADD CONSTRAINT fk_locationId FOREIGN KEY (locationId) REFERENCES Locations(id),
    ADD CONSTRAINT fk_nodeId FOREIGN KEY (nodeId) REFERENCES Nodes(id);

ALTER TABLE NodeAction
    ADD CONSTRAINT fk_nodeId FOREIGN KEY (nodeId) REFERENCES Nodes(id),
    ADD CONSTRAINT fk_characterId FOREIGN KEY (characterId) REFERENCES Characters(id);

ALTER TABLE NodeActionCharacter
    ADD CONSTRAINT fk_nodeId FOREIGN KEY (nodeId) REFERENCES Nodes(id),
    ADD CONSTRAINT fk_characterId FOREIGN KEY (characterId) REFERENCES Characters(id),
    ADD CONSTRAINT fk_itemId FOREIGN KEY (itemId) REFERENCES Items(id);

ALTER TABLE NodeItemChanges
    ADD CONSTRAINT fk_nodeId FOREIGN KEY (nodeId) REFERENCES Nodes(id),
    ADD CONSTRAINT fk_characterId FOREIGN KEY (characterId) REFERENCES Characters(id),
    ADD CONSTRAINT fk_itemId FOREIGN KEY (itemId) REFERENCES Items(id);

ALTER TABLE NodeDialogue
    ADD CONSTRAINT fk_nodeId FOREIGN KEY (nodeId) REFERENCES Nodes(id),
    ADD CONSTRAINT fk_characterId FOREIGN KEY (characterId) REFERENCES Characters(id),
    ADD CONSTRAINT fk_toCharacterId FOREIGN KEY (toCharacterId) REFERENCES Characters(id);

ALTER TABLE NodeHealthChanges
    ADD CONSTRAINT fk_nodeId FOREIGN KEY (nodeId) REFERENCES Nodes(id),
    ADD CONSTRAINT fk_characterId FOREIGN KEY (characterId) REFERENCES Characters(id),
    ADD CONSTRAINT fk_toCharacterId FOREIGN KEY (toCharacterId) REFERENCES Characters(id);

END;
