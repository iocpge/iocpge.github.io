DROP TABLE IF EXISTS material;
DROP TABLE IF EXISTS price;
DROP TABLE IF EXISTS supplier;


CREATE TABLE "material"
(
    "id_material" INTEGER,
    "name"        VARCHAR(80),
    "curie_temp"  REAL,
    "density"     REAL,
    PRIMARY KEY ("id_material")
);


CREATE TABLE "supplier"
(
    "id_supplier" INTEGER,
    "name"        VARCHAR(80),
    "country"     VARCHAR(80),
    PRIMARY KEY ("id_supplier")
);


CREATE TABLE "price"
(
    "id_price"    INTEGER,
    "id_material" INTEGER,
    "id_supplier" INTEGER,
    "kg_price"    REAL,
    PRIMARY KEY ("id_price"),
    FOREIGN KEY ("id_material") REFERENCES material (id_material),
    FOREIGN KEY ("id_supplier") REFERENCES supplier (id_supplier)
);

INSERT INTO material(id_material, name, curie_temp, density)
VALUES (4534, "cobalt", 1388, 8.9),
       (1254, "dioxyde de chrome", 386, 4.89),
       (8713, "nickel", 627, 8.902),
       (8284, "yig", 560, 5.17)
;

INSERT INTO supplier(id_supplier, name, country)
VALUES (145, "World Wide Materials", "USA"),
       (15, "Minerais de Paris", "France"),
       (42, "Minereizh", "France"),
       (66, "Mineral Gesellshaft", "Allemagne");

INSERT INTO price(id_price, id_material, id_supplier, kg_price)
VALUES (1, 4534, 145, 50.40),
(22, 4534, 15, 52.34),
(111, 4534, 42, 49.40),
(13, 4534, 66, 49.97),
(501, 1254, 145, 83.97),
(5, 1254, 15, 100.4),
(99, 1254, 66, 86.45),
(751, 8713, 145, 27.57),
(983, 8713, 66, 25.4),
(35, 8713, 15, 25.4),
(85, 8713, 42, 31.62),
(97, 8284, 145, 1247.57),
(485, 8284, 15, 1025.4),
(685, 8284, 42, 1031.62);

