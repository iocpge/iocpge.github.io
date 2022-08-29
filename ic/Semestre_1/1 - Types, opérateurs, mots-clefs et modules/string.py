print((("0" * 5) + "1" * 3) * 3)
print((((((("A" * 2) + "C") * 2) + "G") * 2) + "T") * 2)

from random import choice

s = ""
for i in range(50000):
    s += choice("ACGT")
print(s)

from random import shuffle, sample

deck = "78910VDRA"
print(sample(deck, k=len(deck)))

from random import randint

for k in range(6):
    print("<D1 :", randint(1, 6),", D2 : ", randint(1,6), ", D3 : ", randint(1,6), ">")

from random import randrange  # borne sup exclue

s = ""
for k in range(5):
    s += str(randrange(1, 50, 1)) + "-"  # str concatenation
s = s[:-1]  # remove last - symbol !
s += "+" + str(randrange(1, 10, 1))
print(s)

from random import uniform

keys = ["BRENT", "ONCE D'OR", "EUR/USD", "VIX INDEX", "BITCOIN/USD"]
s = ""
vinf, vsup = -8.1, 7.9
for k in range(len(keys)):
    s += str(keys[k]) + " " + str(uniform(vinf, vsup)) +"%\n"
    #s += f"{keys[k]} {uniform(vinf, vsup):.2f}%\n" # Formatted string
print(s)


s = "CPGE"
print(s[1])  # indexing --> P
print(s[0] + s[2])  # concatenation --> CG
print(s[1:3])  # slicing --> PG
print(s[-1])  # negative indexing --> E
print(s[-3:-1])  # negative slicing --> PG
print(s[::-1])  # reverse string --> EGPC
print(s[0:-1:2])  # slicing start stop step string --> CG

s = "L3kedf pppzcyqbthhhguodinol huc5n'ryeztsyrtuj xdbbiongnfc oo!ze"
print(s[0:-1:3])  # Le python c'est bon !


# function which return reverse of a string

def is_palindrome(s):
    return s == s[::-1]


def simple_is_palindrome(s):
    deb = 0
    fin = len(s) - 1
    while deb < fin and s[deb] == s[fin]:
        deb += 1
        fin -= 1
    return fin <= deb


# Driver code
test_words = ["ressasser", "hannah", "citrouille", "elle", "radar", "rotor", "bob", "PHP", "SOS", "FIN"]
for w in test_words:
    print(w, is_palindrome(w))
    print(w, simple_is_palindrome(w))
