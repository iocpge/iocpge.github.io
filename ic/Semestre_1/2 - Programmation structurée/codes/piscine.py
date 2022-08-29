def get_price(age, reduced=False):
    if age < 4:
        return 0.0
    elif 3 < age < 18:
        return 2.1
    else:
        return 2.75 if reduced else 4.2


if __name__ == "__main__":

    # SCRIPT VERSION
    age = 4
    reduced = False
    if age < 4:
        print(age, "ans --> Tarif : 0.0 euros")
    elif 3 < age < 18:
        print(age, "ans --> Tarif : 2.1 euros")
    else:
        if reduced:
            print(age, "ans --> Tarif : 2.75 euros")
        else:
            print(age, "ans --> Tarif : 4.2 euros")

    # FUNCTION VERSION
    # valid parameters
    print("2 ans --> Tarif : ", get_price(2), " euros")
    print("3 ans --> Tarif : ", get_price(3), " euros")
    print("4 ans --> Tarif : ", get_price(4), " euros")
    print("10 ans --> Tarif : ", get_price(10), " euros")
    print("17 ans --> Tarif : ", get_price(17), " euros")
    print("18 ans --> Tarif : ", get_price(18), " euros")
    print("26 ans --> Tarif : ", get_price(26), " euros")
    print("26 ans & not reduced --> Tarif : ", get_price(26, False), " euros")

    # exotic parameters (tests for robustness)
    print("3 ans & reduced --> Tarif : ", get_price(3, True), " euros")
    print("3 ans & not reduced --> Tarif : ", get_price(3, False), " euros")
    print("10 ans & reduced --> Tarif : ", get_price(10, True), " euros")
    print("10 ans & not reduced --> Tarif : ", get_price(10, False), " euros")

    # wrong parameters (tests for robustness)
    print("3.5 ans --> Tarif : ", get_price(3.5), " euros")
    print("11.5 ans --> Tarif : ", get_price(11.5), " euros")
    print("26.335 ans --> Tarif : ", get_price(11.5), " euros")
