-- Characters Table
CREATE TABLE Characters (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    str INT NOT NULL,
    dex INT NOT NULL,
    int INT NOT NULL,
    con INT NOT NULL,
    cha INT NOT NULL,
    playerCharacter BOOLEAN NOT NULL,
    deathFork INT,
    health INT NOT NULL,
    power INT NOT NULL,
    FOREIGN KEY (deathFork) REFERENCES Forks(id)
);

-- Items Table
CREATE TABLE Items (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    skill VARCHAR(255) NOT NULL,
    power INT NOT NULL,
    description TEXT,
    stackable BOOLEAN NOT NULL,
    useDialogue TEXT
);

-- Inventory Table (for character-item relationships)
CREATE TABLE Inventory (
    characterId INT NOT NULL,
    itemId INT NOT NULL,
    PRIMARY KEY (characterId, itemId),
    FOREIGN KEY (characterId) REFERENCES Characters(id),
    FOREIGN KEY (itemId) REFERENCES Items(id)
);

-- Relationships Table (for character-character relationships)
CREATE TABLE Relationships (
    characterId1 INT NOT NULL,
    characterId2 INT NOT NULL,
    relationshipLevel INT NOT NULL,
    PRIMARY KEY (characterId1, characterId2),
    FOREIGN KEY (characterId1) REFERENCES Characters(id),
    FOREIGN KEY (characterId2) REFERENCES Characters(id)
);

-- Forks Table
CREATE TABLE Forks (
    id INT PRIMARY KEY,
    text TEXT NOT NULL
);

-- Choices Table (for fork choices)
CREATE TABLE Choices (
    id INT PRIMARY KEY,
    forkId INT NOT NULL,
    text VARCHAR(255) NOT NULL,
    nextFork INT,
    skillCheckSkill VARCHAR(255),
    skillCheckDifficulty INT,
    successFork INT,
    failureFork INT,
    relationshipChangeTarget INT,
    relationshipChangeAmount INT,
    itemRequirement INT,
    itemRemoval INT,
    itemAddition INT,
    battleEnemy INT,
    battleWinFork INT,
    battleLoseFork INT,
    updateDeathFork INT,
    powerChange INT,
    FOREIGN KEY (forkId) REFERENCES Forks(id),
    FOREIGN KEY (nextFork) REFERENCES Forks(id),
    FOREIGN KEY (successFork) REFERENCES Forks(id),
    FOREIGN KEY (failureFork) REFERENCES Forks(id),
    FOREIGN KEY (relationshipChangeTarget) REFERENCES Characters(id),
    FOREIGN KEY (itemRequirement) REFERENCES Items(id),
    FOREIGN KEY (itemRemoval) REFERENCES Items(id),
    FOREIGN KEY (itemAddition) REFERENCES Items(id),
    FOREIGN KEY (battleEnemy) REFERENCES Characters(id),
    FOREIGN KEY (battleWinFork) REFERENCES Forks(id),
    FOREIGN KEY (battleLoseFork) REFERENCES Forks(id),
    FOREIGN KEY (updateDeathFork) REFERENCES Forks(id)
);

-- Endings Table
CREATE TABLE Endings (
    id INT PRIMARY KEY,
    text TEXT NOT NULL,
    type VARCHAR(255) NOT NULL
);

-- EndingConditions Table
CREATE TABLE EndingConditions(
    characterId INT NOT NULL,
    condition VARCHAR(255) NOT NULL,
    endingId INT NOT NULL,
    PRIMARY KEY (characterId,condition),
    FOREIGN KEY (characterId) REFERENCES Characters(id),
    FOREIGN KEY(endingId) REFERENCES Endings(id)
);

-- GlobalDeathFork Table.
CREATE TABLE GlobalDeathFork(
    id INT PRIMARY KEY,
    forkID INT NOT NULL,
    FOREIGN KEY (forkID) REFERENCES Forks(id)
);
