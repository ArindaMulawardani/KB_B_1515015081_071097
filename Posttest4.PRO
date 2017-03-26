/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  
 FileName: CH04E12.PRO
 Purpose: 
 Written by: PDC
 Modifyed by: Eugene Akimov
 Comments: 
******************************************************************************/

trace
domains							%Domains digunakan untuk memberikan nama pada parameter
  name,sex,occupation,object,vice,substance = symbol	%baris pertama ini menggunak tipe data symbol
  age=integer						%umur menggunakan tipe data integer

predicates												%predicates digunakan untuk mendklarasikan relasi	
  person(name,age,sex,occupation) - nondeterm (o,o,o,o), nondeterm (i,o,o,i), nondeterm (i,o,i,o)	%relasi dari orang yaitu nama,umur, jender dan pekerjaan
  had_affair(name,name) - nondeterm (i,i), nondeterm (i,o)						%relasi dari selingkuh yaitu nama dan nama
  killed_with(name,object) - determ (i,o)								%relasi dari terbunuh dengan yaitu nama dengan benda apa
  killed(name) - procedure (o)										%relasi dari tebunuh yaitu nama 
  killer(name) - nondeterm (o)										%relasi dari predikat pembunuh yaitu parameter nama
  motive(vice) - nondeterm (i)										%relasi dari predikat motif adalah parameter alasan
  smeared_in(name,substance) - nondeterm (i,o), nondeterm (i,i)						%relasi dari predikat ternodai yaitu dengan parameter nama dan zat
  owns(name,object) - nondeterm (i,i)									%relasi dari predikat milik yaitu parameter nama dan benda
  operates_identically(object,object) - nondeterm (o,i)							%relasi dari predikat cara  kerjanya mirip yaitu benda dan benda 
  owns_probably(name,object) - nondeterm (i,i)								%relasi dari predikat kemungkinan milik yaitu parameter nama dan benda
  suspect(name) - nondeterm (i)										%relasi dari predikat dicurigai yaitu parameternama

/* * * Facts about the murder * * */
clauses					%clauses berisi fakta
  person(bert,55,m,carpenter).		%bert seorang tukang kayu yang berumur 55 dengan bejender m  
  person(allan,25,m,football_player).	%allan seorang pemain sepak bola yang berumur 25 dengan bejender m  
  person(allan,25,m,butcher).		%allan seorang tukang daging yang berumur 25 dengan bejender m 
  person(john,25,m,pickpocket).		%john seorang tukang daging yang berumur 25 dengan bejender m 

  had_affair(barbara,john).		%barbara selingkuh dengan john
  had_affair(barbara,bert).		%barbara selingkuh dengan bert
  had_affair(susan,john).		%susan selingkuh dengan john

  killed_with(susan,club).		%susan terbunuh dengan stick/pentungan
  killed(susan).			%siti terbunuh/mati

  motive(money).			%motif dari pembunuhan tersebut yaitu uang
  motive(jealousy).			%motif dari pembunuhan tersebut yaitu cemburu
  motive(righteousness).		%motif dari pembunuhan tersebut yaitu kebenaran

  smeared_in(bert,blood).		%bert ternodai dengan darah 
  smeared_in(susan,blood).		%susan ternodai dengan darah 
  smeared_in(allan,mud).		%allan ternodai dengan lumpur 
  smeared_in(john,chocolate).		%john ternodai dengan cokelat 
  smeared_in(barbara,chocolate).	%barbara ternodai dengan cokelat 

  owns(bert,wooden_leg).		%bert punya kaki kayu
  owns(john,pistol).			%john punya pistol

/* * * Background knowledge * * */

  operates_identically(wooden_leg, club).		%cara kerja kaki kayu mirip dengan stick/pentungan 
  operates_identically(bar, club).			%cara kerja balok mirip dengan stick/pentungan
  operates_identically(pair_of_scissors, knife).	%cara kerja sepasang gunting mirip dengan pisau
  operates_identically(football_boot, club).		%cara kerja sepatu bola mirip dengan stick/pentungan

  owns_probably(X,football_boot):-			%kemungkinan sepatu bola milik X jika maka 
	person(X,_,_,football_player).			%X dan orang lainnya pemain sepakbola
  owns_probably(X,pair_of_scissors):-			%kemungkinan gunting milik X jika maka
	person(X,_,_,hairdresser).			%X dan orang lainnya adalah pekerja salon
  owns_probably(X,Object):-				%kemungkinan benda milik X jika maka
	owns(X,Object).					%X memiliki benda itu

/* * * * * * * * * * * * * * * * * * * * * * *
 * Suspect all those who own a weapon with   *
 * which Susan could have been killed.       *
 * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-						%X dicurigai jika maka
	killed_with(susan,Weapon),			%Susan terbunuh dengan senjata dan
	operates_identically(Object,Weapon) ,		%Cara kerja benda tersebut mirip dengan senjata da
	owns_probably(X,Object).			%Kemungkinan X memiliki benda 

/* * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect men who have had an affair with Susan.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-						%X dicurigai jika maka
	motive(jealousy),				%cemburu adalah motifnya dan
	person(X,_,m,_),				%X adalah orang tersebut yang berjender m dan
	had_affair(susan,X).				%susan selingkuh dengan X

/* * * * * * * * * * * * * * * * * * * * *
 * Suspect females who have had an       *
 * affair with someone that Susan knew.  *
 * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-						%X dicurigai jika maka
	motive(jealousy),				%cemburu adalah motifnya dan
	person(X,_,f,_),				%X adalah orang tersebut yang berjender f dan
	had_affair(X,Man),				%X selingkuh dengan pria				
	had_affair(susan,Man).				%susan selingkuh dengan pria

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect pickpockets whose motive could be money.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-							%X dicurigai jika maka
	motive(money),						%uang adalah motifnya dan
	person(X,_,_,pickpocket).				%X adalah seorang pencopet

  killer(Killer):-						%pembunuh tersebut dikatakan pembunuh jika maka
	person(Killer,_,_,_),					%orang tersebut adalah pembunuh dan orang lainnya dan
	killed(Killed),						%jika orang tersebut terbunuh dan
	Killed <> Killer, /* It is not a suicide */		%relasi dari terbunuh adalah pembunuh dan
	suspect(Killer),					%pembunuh tersebut dicurigai dan 
	smeared_in(Killer,Goo),					%pembunuh ternodai oleh goo dan
	smeared_in(Killed,Goo).					%yang terbunuh ternodai oleh goo

goal								%Goal adalah jawaban yang berisi pernyataan dan pertanyaan
  killer(X).							%X adalah pembunuh
