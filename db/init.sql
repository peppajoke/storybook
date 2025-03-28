CREATE TABLE Items (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    skill VARCHAR(30) NOT NULL,
    power INT NOT NULL,
    description TEXT,
    useDialogue TEXT
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
    FOREIGN KEY (parentId) REFERENCES Characters(id)
);

CREATE TABLE Nodes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    gameId INT NOT NULL,
    FOREIGN KEY (gameId) REFERENCES Game(id)
);

CREATE TABLE NodeStatChanges (
    nodeId INT NOT NULL,
    characterId INT,
    stat VARCHAR(30) NOT NULL,
    change INT NOT NULL,
    PRIMARY KEY (nodeId, characterId, stat),
    FOREIGN KEY (characterId) REFERENCES Characters(id),
    FOREIGN KEY (nodeId) REFERENCES Nodes(id)
);

CREATE TABLE Locations (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    x INT NOT NULL,
    y INT NOT NULL
);

CREATE TABLE LocationOverrides (
    locationId INT NOT NULL,
    nodeId INT NOT NULL,
    description TEXT NOT NULL,
    FOREIGN KEY (nodeId) REFERENCES Nodes(id),
    FOREIGN KEY (locationId) REFERENCES Locations(id)
);

CREATE TABLE NodeAction (
    Id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nodeId INT NOT NULL,
    characterId INT NOT NULL,
    description TEXT NOT NULL,
    FOREIGN KEY (nodeId) REFERENCES Nods(id),
    FOREIGN KEY (characterId) REFERENCES Characters(id)
);

CREATE TABLE NodeActionCharacter (
    nodeId INT NOT NULL,
    characterId INT NOT NULL,
    itemId INT NOT NULL,
    quantityChange INT NOT NULL,
    PRIMARY KEY (nodeId, characterId, itemId),
    FOREIGN KEY (nodeId) REFERENCES Nodes(id),
    FOREIGN KEY (characterId) REFERENCES Characters(id),
    FOREIGN KEY (itemId) REFERENCES Items(id)
);

CREATE TABLE NodeItemChanges (
    nodeId INT NOT NULL,
    characterId INT NOT NULL,
    itemId INT NOT NULL,
    quantityChange INT NOT NULL,
    PRIMARY KEY (nodeId, characterId, itemId),
    FOREIGN KEY (nodeId) REFERENCES Nodes(id),
    FOREIGN KEY (characterId) REFERENCES Characters(id),
    FOREIGN KEY (itemId) REFERENCES Items(id)
);

CREATE TABLE NodeDialogue(
    nodeId INT NOT NULL,
    characterId INT NOT NULL,
    toCharacterId INT NOT NULL,
    message TEXT NOT NULL,
    PRIMARY KEY (nodeId, characterId),
    FOREIGN KEY (nodeId) REFERENCES Nodes(id),
    FOREIGN KEY (CharacterId) REFERENCES Characters(id),
    FOREIGN KEY (toCharacterId) REFERENCES Characters(id)
);

CREATE TABLE NodeHealthChanges (
    nodeId INT NOT NULL,
    characterId INT NOT NULL,
    toCharacterId INT NOT NULL,
    healthChange INT NOT NULL,
    PRIMARY KEY (nodeId, characterId, toCharacterId),
    FOREIGN KEY (nodeId) REFERENCES Nodes(id),
    FOREIGN KEY (characterId) REFERENCES Characters(id)
    FOREIGN KEY (toCharacterId) REFERENCES Characters(id)
);

CREATE TABLE Game (
    gameId INT PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    parentCharacterId INT NOT NULL,
    maxNodes INT NOT NULL,
    FOREIGN KEY (parentCharacterId) REFERENCES Characters(id),
);

CREATE TABLE NodeHealthChanges (
    nodeId INT NOT NULL,
    characterId INT NOT NULL,
    toCharacterId INT NOT NULL,
    healthChange INT NOT NULL,
    PRIMARY KEY (nodeId, characterId),
    FOREIGN KEY (nodeId) REFERENCES Nodes(id),
    FOREIGN KEY (characterId) REFERENCES Characters(id),
    FOREIGN KEY (toCharacterId) REFERENCES Characters(id)
);
