def get_frequency(day, hour=0):
    if day == "Samedi" or day == "Dimanche":
        return 30
    #elif 1 <= hour <= 4:
    #    raise Exception("Le bus ne circule pas !")
    else:
        if 7 <= hour < 9 or 16 <= hour < 18:
            return 5
        else:
            return 10


if __name__ == "__main__":

    #  SCRIPT VERSION
    day = "Lundi"
    hour = 15
    if day == "Samedi" or day == "Dimanche":
        print(day, hour, " --> le bus passe toutes les 30 minutes.")
    elif 1 <= hour < 4:
        print(day, hour, " --> le bus ne circule pas.")
    else:
        if 7 <= hour < 9 or 16 <= hour < 18:
            print(day, hour, " --> le bus passe toutes les 5 minutes.")
        else:
            print(day, hour, " --> le bus passe toutes les 10 minutes.")

    #  FUNCTION VERSION

    days = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"]
    hours = [h for h in range(24)]

    for day in days:
        for hour in hours:
            print(day, hour, " --> Le bus passe toutes les ", get_frequency(day, hour), " minutes.")

    print("Mercredi", 7.75, " --> Le bus passe toutes les ", get_frequency("Mercredi", 7.75), " minutes.")
