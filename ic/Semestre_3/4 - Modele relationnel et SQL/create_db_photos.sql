DROP TABLE IF EXISTS presence;
DROP TABLE IF EXISTS describe;
DROP TABLE IF EXISTS keyword;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS photo;

CREATE TABLE "keyword"
(
    "KW_id" INTEGER,
    "KW_text"  VARCHAR(80),
    PRIMARY KEY ("KW_id")
);


CREATE TABLE "person"
(
    "PE_id" INTEGER,
    "PE_name"  VARCHAR(80),
    PRIMARY KEY ("PE_id")
);


CREATE TABLE "photo"
(
    "PH_id"     INTEGER,
    "PH_date"   TEXT,
    "PH_width"  INTEGER,
    "PH_height" INTEGER,
    "PH_author" INTEGER,
    PRIMARY KEY ("PH_id"),
    FOREIGN KEY ("PH_author") REFERENCES person (PE_id)
);

CREATE TABLE "describe"
(
    "KW_id" INTEGER,
    "PH_id" INTEGER,
    PRIMARY KEY ("KW_id", "PH_id"),
    FOREIGN KEY ("KW_id") REFERENCES keyword (KW_id),
    FOREIGN KEY ("PH_id") REFERENCES photo (PH_id)
);
CREATE TABLE "presence"
(
    "PE_id" INTEGER,
    "PH_id" INTEGER,
    PRIMARY KEY ("PE_id", "PH_id"),
    FOREIGN KEY ("PE_id") REFERENCES keyword (KW_id),
    FOREIGN KEY ("PH_id") REFERENCES photo (PH_id)
);



INSERT INTO keyword(KW_id, KW_text)
VALUES (1, "montagne"),
       (11, "mer"),
       (23, "iceberg"),
       (39, "joujou"),
       (43, "chat")
;

INSERT INTO person(PE_id, PE_name)
VALUES (2, "Alix"),
       (12, "Guillaume"),
       (24, "Hannah"),
       (40, "Goulven"),
       (44, "Sterenn")
;

INSERT INTO photo(PH_id, PH_date, PH_width, PH_height, PH_author)
VALUES (3, "2008-12-24", 960, 720, 24),
       (13, "1998-01-11", 480, 360, 40),
       (25, "1999-05-31", 720, 540, 40),
       (41, "2008-10-04", 540, 1080, 24),
       (45, "2012-09-04", 960, 1080, 12),
       (57, "2013-08-07", 1080, 1960, 2),
       (61, "2012-02-05", 540, 720, 2),
       (73, "2013-03-13", 960, 1470, 12),
       (87, "2019-04-19", 960, 1080, 12),
       (91, "2019-06-23", 1080, 1960, 2),
       (101, "2019-07-25", 720, 540, 2),
       (103, "2021-11-30", 960, 1470, 12)
;

INSERT INTO describe(KW_id, PH_id)
VALUES (1, 3),
       (11, 13),
       (23, 25),
       (39, 41),
       (43, 57),
       (1, 13),
       (11, 3),
       (23, 13),
       (39, 3),
       (43, 13),
       (1, 25),
       (11, 41),
       (23, 45),
       (39, 25),
       (43, 41),
       (1, 57),
       (11, 61),
       (23, 73),
       (39, 87),
       (43, 91),
       (1, 101),
       (11, 103),
       (23, 101),
       (39, 103),
       (43, 101)
;

INSERT INTO presence(PE_id, PH_id)
VALUES (2, 3),
       (12, 3),
       (24, 3),
       (40, 3),
       (44, 3),
       (2, 13),
       (12, 25),
       (24, 13),
       (44, 25),
       (44, 13),
       (24, 41),
       (12, 45),
       (40, 57),
       (24, 61),
       (44, 73),
       (40, 87),
       (2, 91),
       (2, 101),
       (2, 103),
       (12, 103)
;
--
-- INSERT INTO supplier(id_supplier, name, country)
-- VALUES (145, "World Wide Materials", "USA"),
--        (15, "Minerais de Paris", "France"),
--        (42, "Minereizh", "France"),
--        (66, "Mineral Gesellshaft", "Allemagne");
--
-- INSERT INTO price(id_price, id_material, id_supplier, kg_price)
-- VALUES (1, 4534, 145, 50.40),
--        (22, 4534, 15, 52.34),
--        (111, 4534, 42, 49.40),
--        (13, 4534, 66, 49.97),
--        (501, 1254, 145, 83.97),
--        (5, 1254, 15, 100.4),
--        (99, 1254, 66, 86.45),
--        (751, 8713, 145, 27.57),
--        (983, 8713, 66, 25.4),
--        (35, 8713, 15, 25.4),
--        (85, 8713, 42, 31.62),
--        (97, 8284, 145, 1247.57),
--        (485, 8284, 15, 1025.4),
--        (685, 8284, 42, 1031.62);
--
