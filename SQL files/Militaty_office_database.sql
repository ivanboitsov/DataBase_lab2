CREATE TABLE Военкомат
(
    Код_военкомата SERIAL UNIQUE,
    Адрес VARCHAR,
    Телефон VARCHAR,

    PRIMARY KEY (Код_военкомата)
);
CREATE TABLE Персонал
(
    Код_военкомата SERIAL,
    Код_сотрудника SERIAL UNIQUE,
    Фамилия VARCHAR,
    Имя VARCHAR,
    Отчество VARCHAR,
    Пол VARCHAR,
    CHECK (Пол = 'МУЖСКОЙ' OR Пол = 'ЖЕНСКИЙ'),
    Дата_рождения DATE,
    Должность VARCHAR,
    CHECK (Должность = 'Сотрудник'), /* Дописать чекер */
    Адрес_проживания VARCHAR,
    Номер_телефона VARCHAR,

    PRIMARY KEY (Код_военкомата, Код_сотрудника),

    FOREIGN KEY (Код_военкомата) REFERENCES Военкомат (Код_военкомата)
);

CREATE TABLE Гражданин
(
    Код_гражданина SERIAL UNIQUE,
    Фамилия VARCHAR,
    Имя VARCHAR,
    Отчество VARCHAR,
    Пол VARCHAR,
    CHECK (Пол = 'МУЖСКОЙ' OR Пол = 'ЖЕНСКИЙ'),
    Дата_рождения DATE,
    Серия_паспорта VARCHAR,
    Номер_паспорта VARCHAR,
    Прописка VARCHAR,
    Адрес_проживания VARCHAR,
    Номер_телефона VARCHAR,

    PRIMARY KEY (Код_гражданина)
);
CREATE TABLE Категория
(
    Код_категории SERIAL UNIQUE,
    Код_гражданина SERIAL,
    Код_сотрудника SERIAL,
    Тип VARCHAR,

    PRIMARY KEY (Код_гражданина, Код_категории),

    FOREIGN KEY (Код_сотрудника) REFERENCES Персонал (Код_сотрудника)
);

CREATE TABLE Медкомиссия
(
    Код_медкомиссии SERIAL UNIQUE,
    Код_военкомата SERIAL,
    Дата_приёма DATE,

    PRIMARY KEY (Код_военкомата, Код_медкомиссии),

    FOREIGN KEY (Код_военкомата) REFERENCES Военкомат (Код_военкомата)
);
CREATE TABLE Врач
(
    Код_медкомиссии SERIAL,
    Код_врача SERIAL UNIQUE,
    Фамилия VARCHAR,
    Имя VARCHAR,
    Отчество VARCHAR,
    Должность VARCHAR,
    CHECK (Должность = 'Должность'), /* Дописать чекер */

    PRIMARY KEY (Код_врача),

    FOREIGN KEY (Код_медкомиссии) REFERENCES Медкомиссия (Код_медкомиссии)
);
CREATE TABLE "Заключение врача"
(
    Код_заключения SERIAL UNIQUE,
    Код_врача SERIAL,
    Код_гражданина SERIAL,
    Должность_врача VARCHAR,
    Результат VARCHAR,

    PRIMARY KEY (Код_гражданина, Код_врача, Код_заключения),

    FOREIGN KEY (Код_врача) REFERENCES Врач (Код_врача),
    FOREIGN KEY (Код_гражданина) REFERENCES Гражданин (Код_гражданина),
    FOREIGN KEY (Должность_врача) REFERENCES Врач (Должность)
);

CREATE TABLE "Род войск"
(
    Код_войска SERIAL UNIQUE,
    Код_приказа SERIAL,
    Название VARCHAR,

    PRIMARY KEY (Код_войска),

    FOREIGN KEY (Код_приказа) REFERENCES "Приказ на отправку" (Код_приказа)
);
CREATE TABLE "Приказ на отправку"
(
    Код_приказа SERIAL UNIQUE,
    Код_военкомата SERIAL,
    Код_сотрудника SERIAL,
    Название VARCHAR,
    Дата DATE,

    PRIMARY KEY (Код_военкомата, Код_приказа),

    FOREIGN KEY (Код_военкомата) REFERENCES Военкомат (Код_военкомата),
    FOREIGN KEY (Код_сотрудника) REFERENCES Персонал (Код_сотрудника)
);
CREATE TABLE "Персонал-Приказы"
(
    Код_сотрудника SERIAL,
    Код_приказа SERIAL,

    PRIMARY KEY (Код_приказа, Код_сотрудника),

    FOREIGN KEY (Код_сотрудника) REFERENCES Персонал (Код_сотрудника),
    FOREIGN KEY (Код_приказа) REFERENCES "Приказ на отправку" (Код_приказа)
);
CREATE TABLE "Род войск-Гражданин"
(
    Код_приказа SERIAL,
    Код_гражданина SERIAL,

    PRIMARY KEY (Код_приказа, Код_гражданина),

    FOREIGN KEY (Код_приказа) REFERENCES "Приказ на отправку" (Код_приказа),
    FOREIGN KEY (Код_гражданина) REFERENCES Гражданин (Код_гражданина)
);
CREATE TABLE "Медкомиссия-Врач"
(
    Код_медкомиссии SERIAL,
    Код_врача SERIAL,

    PRIMARY KEY (Код_медкомиссии, Код_врача),

    FOREIGN KEY (Код_медкомиссии) REFERENCES Медкомиссия (Код_медкомиссии),
    FOREIGN KEY (Код_врача) REFERENCES Врач (Код_врача)
);
