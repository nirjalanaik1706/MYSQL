CREATE Database TFLMentoringDB;
USE TFLMentoringDB;


CREATE TABLE repositories (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE topics (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Url VARCHAR(500),
    RepositoryId INT,
    FOREIGN KEY (RepositoryId) REFERENCES repositories(Id)
);
INSERT INTO repositories (Id, Name) VALUES
(1, 'TFLSoftwareTesting'),
(2, 'SDM'),
(3, 'weekendjune25'),
(4, 'TFLAgile'),
(5, 'angularjs'),
(6, 'TFLCPP'),
(7, 'AspnetMarchWeekend25'),
(8, 'Craftsmanship'),
(9, 'TAP'),
(10, 'mysql'),
(11, 'TFLJAVA'),
(12, 'TFLNodeJS'),
(13, 'TFLdotNET');
select * from  repositories;
