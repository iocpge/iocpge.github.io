-- Échauffement

SELECT KW_text
FROM keyword;

SELECT PH_id, PH_date
FROM photo
WHERE PH_date < 2001;

SELECT DISTINCT KW_text
FROM keyword
         JOIN describe on keyword.KW_id = describe.KW_id;

SELECT DISTINCT PH_author
FROM photo;

SELECT DISTINCT PE_name
FROM person
         JOIN photo on person.PE_id = photo.PH_author;

SELECT DISTINCT PE_name
FROM person
         JOIN photo on person.PE_id = photo.PH_author
WHERE PH_date > 2001;

SELECT photo.PH_id, COUNT(PE_id)
FROM photo
         JOIN presence ON photo.PH_id = presence.PH_id
GROUP BY photo.PH_id
ORDER BY COUNT(PE_id) ASC;

SELECT PE_name, COUNT(presence.PE_id)
FROM presence
         JOIN person ON presence.PE_id = person.PE_id
GROUP BY person.PE_id
ORDER BY PE_name DESC;

-- On est chaud !

SELECT PH_id
FROM photo
WHERE 3 * PH_width = 4 * photo.PH_height;

SELECT COUNT(*)
FROM photo
WHERE PH_author NOT IN (SELECT PE_id
                        FROM person
                        WHERE PE_name = "Alix"
                           OR PE_name = "Guillaume");

-- idem avec IN
SELECT COUNT(*)
FROM photo
WHERE PH_author NOT IN (SELECT PE_id
                        FROM person
                        WHERE PE_name IN ("Alix", "Guillaume"));

SELECT photo.PH_id, PH_author, PH_date
FROM photo
         JOIN describe ON photo.PH_id = describe.PH_id
         JOIN keyword ON describe.KW_id = keyword.KW_id
         JOIN person ON photo.PH_author = person.PE_id
WHERE PH_date < "20060101"
  AND keyword.KW_text = "chat";


SELECT photo.PH_id, person.PE_name
FROM photo
         JOIN presence ON photo.PH_author = presence.PE_id
    AND photo.PH_id = presence.PH_id
         JOIN person ON photo.PH_author = person.PE_id
GROUP BY photo.PH_id;

-- idem avec INTERSECT
-- l'identifiant d'une photo et son auteur
-- intersect
-- l'identifiant d'une photo et le nom d'une personne présente
SELECT photo.PH_id, person.PE_name
FROM photo
         JOIN person ON photo.PH_author = person.PE_id
INTERSECT
SELECT presence.PH_id, person.PE_name
FROM presence
         JOIN person ON presence.PE_id = person.PE_id;


-- Good luck !
-- les photos sur lesquelles figure Alix
-- intersect
-- les photos sur lesquelles figure Guillaume
-- intersect
-- les photos sur lesquelles ne figurent ni Alix ni Guillaume
SELECT photo.PH_id
FROM photo
         JOIN presence ON photo.PH_id = presence.PH_id
         JOIN person ON presence.PE_id = person.PE_id
WHERE person.PE_name = "Alix"
INTERSECT
SELECT photo.PH_id
FROM photo
         JOIN presence ON photo.PH_id = presence.PH_id
         JOIN person ON presence.PE_id = person.PE_id
WHERE person.PE_name = "Guillaume"
EXCEPT
SELECT photo.PH_id
FROM photo
         JOIN presence ON photo.PH_id = presence.PH_id
         JOIN person ON presence.PE_id = person.PE_id
WHERE person.PE_name NOT IN ("Alix", "Guillaume");
