SELECT *
FROM material;

SELECT *
FROM supplier;

SELECT *
FROM price;

SELECT name
FROM material
WHERE curie_temp < 500;

SELECT *
FROM material
WHERE curie_temp < 600
   or density < 8;

SELECT MIN(kg_price), AVG(kg_price), MAX(kg_price)
FROM price;

SELECT DISTINCT material.name
FROM material
         JOIN price ON price.id_material = material.id_material
ORDER BY material.name DESC;

SELECT name, 1000 * kg_price
FROM supplier
         JOIN price ON supplier.id_supplier = price.id_supplier
WHERE price.id_material = 8713;

SELECT name, id_material, kg_price
FROM supplier
         JOIN price ON supplier.id_supplier = price.id_supplier
ORDER BY name, kg_price;

SELECT supplier.name, material.name, kg_price
FROM supplier
         JOIN price ON supplier.id_supplier = price.id_supplier
         JOIN material on price.id_material = material.id_material
ORDER BY supplier.name, kg_price DESC;

SELECT material.name
FROM material
         JOIN price on price.id_material = material.id_material
         JOIN supplier on price.id_supplier = supplier.id_supplier
WHERE supplier.country = "France";


SELECT kg_price
FROM price
WHERE id_material = (SELECT id_material
                     FROM material
                     WHERE name = "nickel");

SELECT name
FROM supplier
WHERE id_supplier IN (SELECT id_supplier
                      FROM price
                      WHERE id_material = (SELECT id_material
                                           FROM material
                                           WHERE name = "nickel"));

SELECT name, 1000 * kg_price
FROM supplier
         JOIN price ON supplier.id_supplier = price.id_supplier
WHERE price.id_material = (SELECT id_material
                           FROM material
                           WHERE name = "nickel");

SELECT name, 1000 * kg_price
FROM supplier
         JOIN price ON supplier.id_supplier = price.id_supplier
WHERE price.id_material = 8713
  and price.kg_price = (SELECT MIN(kg_price)
                        FROM price
                        WHERE id_material = 8713);

SELECT name, 1000 * kg_price
FROM supplier
         JOIN price ON supplier.id_supplier = price.id_supplier
WHERE price.id_material = (SELECT id_material
                           FROM material
                           WHERE name = "nickel")
  and price.kg_price = (SELECT MIN(kg_price)
                        FROM price
                        WHERE id_material = (SELECT id_material
                                             FROM material
                                             WHERE name = "nickel"));

SELECT name, AVG(kg_price)
FROM material
         JOIN price ON material.id_material = price.id_material
GROUP BY price.id_material
ORDER BY price.kg_price DESC;

SELECT name, AVG(kg_price)
FROM material
         JOIN price ON material.id_material = price.id_material
GROUP BY price.id_material
HAVING AVG(price.kg_price) < 100
ORDER BY price.kg_price ASC;


SELECT material.name, supplier.name, price.kg_price
FROM material
         JOIN price ON price.id_material = material.id_material
         JOIN supplier ON price.id_supplier = supplier.id_supplier
GROUP BY material.name, supplier.name
ORDER BY price.kg_price;

SELECT material.name, COUNT(supplier.id_supplier), AVG(price.kg_price)
FROM material
         JOIN price ON price.id_material = material.id_material
         JOIN supplier ON price.id_supplier = supplier.id_supplier
GROUP BY material.name
HAVING COUNT(supplier.id_supplier) > 3
   and AVG(kg_price < 100)
ORDER BY AVG(kg_price) DESC;