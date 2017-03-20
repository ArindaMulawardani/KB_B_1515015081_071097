domains
kakek,ayah = symbol

predicates
nondeterm ayah(symbol,symbol)
nondeterm kakek(symbol,symbol)

clauses
ayah(adam,herman).
ayah(adam,nando).
ayah(herman,willyardo).
ayah(herman,doni).
ayah(nando,hendrawan).
ayah(nando,iyoo).

kakek(Kakek,Cucu) :-
ayah(Ayah,Cucu),
ayah(Kakek,Ayah).

goal
kakek(adam,Cucu).
