/* To Do: */
/* Masukkan barang yang dibeli ke inventory atau ranch */

/* Barang yang dijual: */
/* 1. Lv Up Potion */
/* 2. Mythical Duck */

/* Kata kunci parameter (Alc) */
/* 1 : Tersisa Lv Up Potion */
/* 2 : Tersisa Mythical Duck */
/* 3 : Tersedia kedua-duanya */
/* 4 : Tidak tersedia apa-apa */

alc_intro(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc) :-
	write('*Tiba-tiba sekeliling menjadi gelap*'), nl,
	write('Brianaldo            : Nani is going on?!'), nl,
	write('Alchemist Legendaris : Selamat datang di toko ku.'), nl,
	write('Alchemist Legendaris : Sudah lama aku tidak mendapat pengunjung'), nl,
	write('Alchemist Legendaris : Silahkan memilih barang yang diinginkan'), nl,
	alc_shop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc).

alc_shop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc) :-
	nl, nl, nl,
	(
        (Alc =:= 1) ->
            write('Legendary Alchemist Shop'), nl,
            write('========================'), nl,
            write('1x Lv Up Potion  >> 5000'), nl,
            write('Apakah anda ingin membeli item ini?'), nl,
            write('1. Yes'), nl,
            write('0. No'), nl,
            read(Buy),
            (
            	(Buy =:= 1) ->
            		(
			            GoldX is Gold - 5000,
			            (GoldX >= 0) ->
			            	(
				            	write('Pembelian telah berhasil dilakukan'), nl,

				            	write("*Tiba-tiba potionnya jatuh dan pecah*"), nl,
								write("Brianaldo : Apa yang terjadi, aku tiba tiba merasa berbeda"), nl,

								BoostLv is Lv+1,
								ExpcurrNew is Expcap,
								ExpcapNew is Expcap*2,

				            	AlcX is 4,
				            	mainLoop(Job, BoostLv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, ExpcurrNew, ExpcapNew, GoldX, Day, Hour, Qharvest, Qfish, Qranch, AlcX)
			            	);
			            (GoldX < 0) ->
			            	(
			            		write('Uang anda tidak cukup untuk melakukan pembelian'), nl,
			            		mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
			            	)
			        );

		        (Buy =:= 0) ->
		            write('Alchemist Legendaris : Adios anak muda'), nl,
		            write('*Tiba-tiba Alchemist Legendaris dan tokonya hilang*'), nl,
		            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

		        write('Invalid Input'),
		        alc_shop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
            );

        (Alc =:= 2) ->
            write('Legendary Alchemist Shop'), nl,
            write('========================='), nl,
            write('1x Mythical Duck >> 20000'), nl,
            write('Apakah anda ingin membeli item ini?'), nl,
            write('1. Yes'), nl,
            write('0. No'), nl,
            read(Buy),
            (
            	(Buy =:= 1) ->
            		(
			            GoldX is Gold - 20000,
			            (GoldX >= 0) ->
			            	(
				            	write('Pembelian telah berhasil dilakukan'), nl,

								retractall(mythical_duck(_)),
								asserta(mythical_duck(1)),

				            	AlcX is 4,
				            	mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, GoldX, Day, Hour, Qharvest, Qfish, Qranch, AlcX)
			            	);
			            (GoldX < 0) ->
			            	(
			            		write('Uang anda tidak cukup untuk melakukan pembelian'), nl,
			            		mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
			            	)
			        );

		        (Buy =:= 0) ->
		            write('Alchemist Legendaris : Adios anak muda'), nl,
		            write('*Tiba-tiba Alchemist Legendaris dan tokonya hilang*'), nl,
		            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

		        write('Invalid Input'),
		        alc_shop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
            );

        (Alc =:= 3) ->
            write('Legendary Alchemist Shop'), nl,
            write('========================='), nl,
            write('1x Lv Up Potion  >> 5000'), nl,
            write('1x Mythical Duck >> 20000'), nl,
            write('Item mana yang ingin dibeli?'), nl,
            write('1. Potion'), nl,
            write('2. Duck'), nl,
            write('3. Harga apaan ini?!'), nl,
            read(Opt),
            (
            	(Opt =:= 1) ->
            		write('Apakah anda ingin potion ini?'), nl,
		            write('1. Yes'), nl,
		            write('0. No'), nl,
		            read(Buy),
		            (
		            	(Buy =:= 1) ->
		            		(
					            GoldX is Gold - 5000,
					            (GoldX >= 0) ->
					            	(
						            	write('Pembelian telah berhasil dilakukan'), nl,

						            	write('*Tiba-tiba potionnya jatuh dan pecah*'), nl,
										write('Brianaldo : Apa yang terjadi, aku tiba tiba merasa berbeda'), nl,

										BoostLv is Lv+1,
										ExpcurrNew is Expcap,
										ExpcapNew is Expcap*2,

						            	AlcX is 2,
						            	mainLoop(Job, BoostLv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, ExpcurrNew, ExpcapNew, GoldX, Day, Hour, Qharvest, Qfish, Qranch, AlcX)
					            	);
					            (GoldX < 0) ->
					            	(
					            		write('Uang anda tidak cukup untuk melakukan pembelian'), nl,
					            		mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
					            	)
					        );

				        (Buy =:= 0) ->
				            write('Alchemist Legendaris : Adios anak muda'), nl,
				            write('*Tiba-tiba Alchemist Legendaris dan tokonya hilang*'), nl,
				            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

				        write('Invalid Input'),
				        alc_shop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
		            );

		        (Opt =:= 2) ->
		        	write('Apakah anda ingin membeli bebek ini?'), nl,
		            write('1. Yes'), nl,
		            write('0. No'), nl,
		            read(Buy),
		            (
		            	(Buy =:= 1) ->
		            		(
					            GoldX is Gold - 20000,
					            (GoldX >= 0) ->
					            	(
						            	write('Pembelian telah berhasil dilakukan'), nl,

						            	retractall(mythical_duck(_)),
										asserta(mythical_duck(1)),

						            	AlcX is 1,
						            	mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, GoldX, Day, Hour, Qharvest, Qfish, Qranch, AlcX)
					            	);
					            (GoldX < 0) ->
					            	(
					            		write('Uang anda tidak cukup untuk melakukan pembelian'), nl,
					            		mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
					            	)
					        );

				        (Buy =:= 0) ->
				            write('Alchemist Legendaris : Adios anak muda'), nl,
				            write('*Tiba-tiba Alchemist Legendaris dan tokonya hilang*'), nl,
				            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

				        write('Invalid Input'),
				        alc_shop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
		            );

		        (Opt =:= 3) ->
		        	write('*Tiba-tiba Alchemist Legendaris dan tokonya hilang*'), nl,
		        	mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

		        write('Invalid Input'),
		        alc_shop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
            );

        (Alc =:= 4) ->
            write('Alchemist Legendaris : Hohoho.. tidak ada lagi barang yang bisa dibeli'), nl,
            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

        write('\n')
    ).