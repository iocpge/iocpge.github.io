# In extenso
L = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
print(L)

# for loop
L = []
for i in range(15):
    L.append(i)
print(L)

# comprehension list
L = [i for i in range(15)]
print(L)

print(L[4], L[8])  # indexing

if 5 in L:
    print("5 is in list")

if 42 not in L:
    print("42 is not in list")

L.append(42)  # append to the list
print(L)

L.pop()  # remove last element
print(L)

# slicing - un sur deux à partir du premier
print(L[1:-1:2])

L += L  # concatenation
print(L)

L *= 5  # demultiplication
print(len(L))
