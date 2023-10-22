CREATE TABLE Военкомат
(
    Код_военкомата SERIAL,
    Адрес VARCHAR,
    Телефоно VARCHAR,

    PRIMARY KEY (Код_военкомата)
);
CREATE TABLE Персонал
(
    Код_военкомата SERIAL,
    Код_сотрудника SERIAL,
    Фамилия VARCHAR,
    Имя VARCHAR,
    Отчество VARCHAR,
    Пол VARCHAR,
    CHECK (ПОЛ = 'МУЖСКОЙ' OR ПОЛ = 'ЖЕНСКИЙ'),
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
    Код_гражданина SERIAL,
    Код_категории SERIAL,
    Фамилия VARCHAR,
    Имя VARCHAR,
    Отчество VARCHAR,
    Пол VARCHAR,
    CHECK (ПОЛ = 'МУЖСКОЙ' OR ПОЛ = 'ЖЕНСКИЙ'),
    Дата_рождения DATE,
    Серия_паспорта VARCHAR,
    Номер_паспорта VARCHAR,
    Прописка VARCHAR,
    Адрес_проживания VARCHAR,
    Номер_телефона VARCHAR,

    PRIMARY KEY (Код_гражданина, Код_категории),

    FOREIGN KEY (Код_категории) REFERENCES Категория (Код_категории)
);
CREATE TABLE Медкомиссия
(
    Код_медкомиссии SERIAL,
    Код_военкомата SERIAL,
    Дата_приёма DATE,

    PRIMARY KEY (Код_военкомата, Код_медкомиссии),

    FOREIGN KEY (Код_военкомата) REFERENCES Военкомат (Код_военкомата)
);
CREATE TABLE Врач
(
    Код_медкомиссии SERIAL,
    Код_врача SERIAL,
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
    Код_заключения SERIAL,
    Код_врача SERIAL,
    Код_гражданина SERIAL,
    Должность_врача VARCHAR,
    Результат VARCHAR,

    PRIMARY KEY (Код_гражданина, Код_врача, Код_заключения),

    FOREIGN KEY (Код_врача) REFERENCES Врач (Код_врача),
    FOREIGN KEY (Код_гражданина) REFERENCES Гражданин (Код_гражданина),
    FOREIGN KEY (Должность_врача) REFERENCES Врач (Должность)
);
CREATE TABLE Категория
(
    Код_категории SERIAL,
    Код_гражданина SERIAL,
    Код_сотрудника SERIAL,
    Тип VARCHAR,

    PRIMARY KEY (Код_гражданина, Код_категории),

    FOREIGN KEY (Код_гражданина) REFERENCES Гражданин (Код_гражданина),
    FOREIGN KEY (Код_сотрудника) REFERENCES Персонал (Код_сотрудника)
);
CREATE TABLE "Род войск"
(
    Код_войска SERIAL,
    Код_приказа SERIAL,
    Название VARCHAR,

    PRIMARY KEY (Код_войска),

    FOREIGN KEY (Код_приказа) REFERENCES "Приказ на отправку" (Код_приказа)
);
CREATE TABLE "Приказ на отправку"
(
    Код_приказа SERIAL,
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
