predicates 
nondeterm binatang(symbol,symbol)
nondeterm warna(symbol,symbol)
nondeterm gelap(symbol,symbol)

clauses
binatang(beruang,besar).
binatang(gajah,besar).
binatang(kucing,kecil).
warna(beruang,coklat).
warna(kucing,hitam).
warna(gajah,abuabu).

gelap(Hewan,Tubuh):-
	warna(Hewan,Tubuh);
	binatang(Hewan,Tubuh).
	
	
goal
warna(Hewan,hitam);
binatang(Hewan,besar).

%dalam program diatas saya membuat program tentang pernyataan hewan apa yg bebulu hitam atau hewan yang berbadan besar. dengan predicates berupa binatang, warna, dan gelap. dimana masin-masing menggunakan tipe data symbol.


