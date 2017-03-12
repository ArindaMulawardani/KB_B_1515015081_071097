predicates
nondeterm suami(symbol,symbol)
nondeterm istri(symbol,symbol)
nondeterm ibu(symbol,symbol)
nondeterm ayah(symbol,symbol)
nondeterm adik(symbol,symbol)
nondeterm kaka(symbol,symbol)
nondeterm anak(symbol,symbol)
nondeterm saudara(symbol,symbol)

clauses
suami(boy,monza). 

istri(puza,ponky). 

ibu(puza,pita). 
ibu(puza,ikbal).
ibu(monza,ani). 

ayah(boy,bunga). 
ayah(boy,ani).

adik(bunga,ani).
adik(dina,ikbal). 

kaka(ani,bunga).
kaka(joko,ani).
kaka(yogo,pita).

saudara(X,Y):-
 	adik(X,Y); kaka(X,Y);
 	adik(X,Z),adik(Z,Y); 
 	kaka(X,Z),kaka(Z,Y); 
 	ibu(Z,X),ibu(Z,Y); ayah(Z,X),ayah(Z,Y); 
 	ibu(Z,X),suami(A,Z),ayah(A,Y); ibu(Z,X),istri(Z,A),ayah(A,Y); 
 	ibu(Z,Y),suami(A,Z),ayah(A,X); ibu(Z,Y),istri(Z,A),ayah(A,X) .
 anak(X,Y):-
 	ayah(Y,X); ibu(Y,X); 
 	saudara(X,Z),ayah(Y,Z); saudara(X,Z),ibu(Y,Z); 
 	saudara(Z,X),ayah(Y,Z); saudara(Z,X),ibu(Y,Z).

goal
anak(yogo,puza).