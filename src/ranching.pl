:- dynamic((chicken/1, cow/1, sheep/1, pig/1, ostrich/1, tiger/1, mythical_duck/1, chickenLastTaken/1, cowLastTaken/1, sheepLastTaken/1, ostrichLastTaken/1, duckLastTaken/1)).

chicken(0).
cow(0).
sheep(0).
pig(0).
ostrich(0).
tiger(0).
mythical_duck(0).
chickenLastTaken(0).
cowLastTaken(0).
sheepLastTaken(0).
ostrichLastTaken(0).
duckLastTaken(0).

showChicken :-
    chicken(Chick),
    Chick > 0
    -> write(Chick), write(' chicken\n')
    ; !.

showCow :-
    cow(Cow),
    Cow > 0 
    -> write(Cow), write(' cow\n')
    ; !. 

showSheep :-
    sheep(Sheep),
    Sheep > 0
    -> write(Sheep), write(' sheep\n')
    ; !. 

showPig :-
    pig(Pig),
    Pig > 0 
    -> write(Pig), write(' pig\n')
    ; !.

showOstrich :-
    ostrich(Ostrich),
    Ostrich > 0
    -> write(Ostrich), write(' ostrich\n')
    ; !.

showTiger :-
    tiger(Tiger),
    Tiger > 0
    -> write(Tiger), write(' tiger\n')
    ; !.

showMythicalDuck :-
    mythical_duck(MythicalDuck),
    MythicalDuck > 0
    -> write(MythicalDuck), write(' mythical duck\n')
    ; !.

validasi_ranching :-
    scan_player(_, X, Y),
    ranch_position(XR, YR),
    X == XR,
    Y == YR.

showRanch(Day, Lvranching, ExpOut) :-
    chicken(Chick),
    cow(Cow),
    sheep(Sheep),
    pig(Pig),
    ostrich(Ostrich),
    tiger(Tiger),
    mythical_duck(MythicalDuck),
    (
        ((Chick + Cow + Sheep + Pig + Ostrich + Tiger + MythicalDuck) > 0)
            -> write('\nSelamat datang di Ranch! Kamu memiliki:\n'), showChicken, showCow, showSheep, showPig, showOstrich, showTiger, showMythicalDuck, write('\nApa yang mau kamu lakukan?\n'), chooseRanch(Day, Lvranching, ExpOut), !
            ; write('\nAnda tidak memiliki hewan ternak di Ranch. Silakan coba membeli hewan ternak di Marketplace.\n'), !, fail
    ).

ranch(Day, Lvranching, ExpOut) :-
    (
        validasi_ranching
        -> showRanch(Day, Lvranching, ExpOut), !
        ; write('Tile ini bukan Ranch. Silakan pergi ke Ranch untuk melakukan kegiatan ranch.\n'), !, fail
    ). 

chooseRanch(Day, Lvranching, ExpOut) :-
    read(Animal),
    (
        (
            Animal == 'chicken',
                chicken(Chick),
                (
                    (Chick > 0)
                    -> chickenEgg(Day, Lvranching, ExpOut)
                    ; write('Kamu tidak memiliki chicken pada ranch')
                ), !
        );
        (
            Animal == 'cow',
                cow(Cow),
                (
                    (Cow > 0)
                    -> cowMilk(Day, Lvranching, ExpOut)
                    ; write('Kamu tidak memiliki cow pada ranch')
                ), !
        );
        (
            Animal == 'sheep',
                sheep(Sheep),
                (
                    (Sheep > 0)
                    -> woolSheep(Day, Lvranching, ExpOut)
                    ; write('Kamu tidak memiliki sheep pada ranch')
                ), !
        );
        (
            Animal == 'pig',
                pig(Pig),
                (
                    (Pig > 0)
                    -> pigMeat(Lvranching, ExpOut)
                    ; write('Kamu tidak memiliki pig pada ranch')
                ), !
        );
        (
            Animal == 'ostrich',
                ostrich(Ostrich),
                (
                    (Ostrich > 0)
                    -> ostrichFeather(Day, Lvranching, ExpOut)
                    ; write('Kamu tidak memiliki ostrich pada ranch')
                ), !
        );
        (
            Animal == 'tiger',
                tiger(Tiger),
                (
                    (Tiger > 0)
                    -> tigerSkin(Lvranching, ExpOut)
                    ; write('Kamu tidak memiliki tiger pada ranch')
                ), !
        );
        (
            Animal == 'mythical_duck',
                mythical_duck(MythicalDuck),
                (
                    (MythicalDuck > 0)
                    -> duckGoldenEgg(Day, Lvranching, ExpOut)
                    ; write('Kamu tidak memiliki mythical duck pada ranch')
                ), !
        )
    ).


chickenEgg(Day, Lvranching, ExpOut) :-
    chickenLastTaken(D),
    chicken(Chick),
    (
        (Day > D)
        ->
            generateRandom(N),
            (
                (Lvranching < 10)
                -> 
                    (
                        (N =< 33)
                        -> write('Ayam kamu belum menghasilkan telur\n'), ExpOut is 15 * Chick, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
                        ; (N =< 67)
                        -> insertItem(30, Chick), write('Ayam kamu menghasilkan '), write(Chick), write(' telur.\n'), retract(chickenLastTaken(D)), asserta(chickenLastTaken(Day)), ExpOut is 20 * Chick, write(ExpOut), write(' exp ranching!\n'), !
                        ; NChick is Chick * 2, insertItem(30, NChick), write('Ayam kamu menghasilkan '), write(NChick), write(' telur.\n'), retract(chickenLastTaken(D)), asserta(chickenLastTaken(Day)), ExpOut is 20 * Chick, write(ExpOut), write(' exp ranching!\n'), !
                    )
                ; (Lvranching < 20)
                ->
                    (
                        (N =< 33)
                        -> insertItem(30, Chick), write('Ayam kamu menghasilkan '), write(Chick), write(' telur.\n'), retract(chickenLastTaken(D)), asserta(chickenLastTaken(Day)), ExpOut is 20 * Chick, write(ExpOut), write(' exp ranching!\n'), !
                        ; (N =< 67)
                        -> NChick is Chick * 2, insertItem(30, NChick), write('Ayam kamu menghasilkan '), write(NChick), write(' telur.\n'), retract(chickenLastTaken(D)), asserta(chickenLastTaken(Day)), ExpOut is 20 * Chick, write(ExpOut), write(' exp ranching!\n'), !
                        ; NChick is Chick * 3, insertItem(30, NChick), write('Ayam kamu menghasilkan '), write(NChick), write(' telur.\n'), retract(chickenLastTaken(D)), asserta(chickenLastTaken(Day)), ExpOut is 20 * Chick, write(ExpOut), write(' exp ranching!\n'), !
                    )
                ; (Lvranching < 30)
                -> 
                    (
                        (N =< 33)
                        -> NChick is Chick * 2, insertItem(30, NChick), write('Ayam kamu menghasilkan '), write(NChick), write(' telur.\n'), retract(chickenLastTaken(D)), asserta(chickenLastTaken(Day)), ExpOut is 20 * Chick, write(ExpOut), write(' exp ranching!\n'), !
                        ; (N =< 67)
                        -> NChick is Chick * 3, insertItem(30, NChick), write('Ayam kamu menghasilkan '), write(NChick), write(' telur.\n'), retract(chickenLastTaken(D)), asserta(chickenLastTaken(Day)), ExpOut is 20 * Chick, write(ExpOut), write(' exp ranching!\n'), !
                        ; NChick is Chick * 4, insertItem(30, NChick), write('Ayam kamu menghasilkan '), write(NChick), write(' telur.\n'), retract(chickenLastTaken(D)), asserta(chickenLastTaken(Day)), ExpOut is 20 * Chick, write(ExpOut), write(' exp ranching!\n'), !
                    )
                ;
                    (
                        (N =< 33)
                        -> NChick is Chick * 3, insertItem(30, NChick), write('Ayam kamu menghasilkan '), write(NChick), write(' telur.\n'), retract(chickenLastTaken(D)), asserta(chickenLastTaken(Day)), ExpOut is 20 * Chick, write(ExpOut), write(' exp ranching!\n'), !
                        ; (N =< 67)
                        -> NChick is Chick * 4, insertItem(30, NChick), write('Ayam kamu menghasilkan '), write(NChick), write(' telur.\n'), retract(chickenLastTaken(D)), asserta(chickenLastTaken(Day)), ExpOut is 20 * Chick, write(ExpOut), write(' exp ranching!\n'), !
                        ; NChick is Chick * 5, insertItem(30, NChick), write('Ayam kamu menghasilkan '), write(NChick), write(' telur.\n'), retract(chickenLastTaken(D)), asserta(chickenLastTaken(Day)), ExpOut is 20 * Chick, write(ExpOut), write(' exp ranching!\n'), !
                    )
            )
        ; write('Ayam kamu belum menghasilkan telur\n'), ExpOut is 15 * Chick, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
    ).

cowMilk(Day, Lvranching, ExpOut) :-
    cowLastTaken(D),
    cow(Cow),
    (
        (Day > D)
        ->
            generateRandom(N),
            (
                (Lvranching < 10)
                -> 
                    (
                        (N =< 33)
                        -> write('Sapi kamu belum menghasilkan susu\n'), ExpOut is 15 * Cow, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
                        ; (N =< 67)
                        -> insertItem(31, Cow), write('Sapi kamu menghasilkan '), write(Cow), write(' botol susu.\n'), retract(cowLastTaken(D)), asserta(cowLastTaken(Day)), ExpOut is 25 * Cow, write(ExpOut), write(' exp ranching!\n'), !
                        ; NCow is Cow * 2, insertItem(31, NCow), write('Sapi kamu menghasilkan '), write(NCow), write(' botol susu.\n'), retract(cowLastTaken(D)), asserta(cowLastTaken(Day)), ExpOut is 25 * Cow, write(ExpOut), write(' exp ranching!\n'), !
                    )
                ; (Lvranching < 20)
                ->
                    (
                        (N =< 33)
                        -> insertItem(31, Cow), write('Sapi kamu menghasilkan '), write(Cow), write(' botol susu.\n'), retract(cowLastTaken(D)), asserta(cowLastTaken(Day)), ExpOut is 25 * Cow, write(ExpOut), write(' exp ranching!\n'), !
                        ; (N =< 67)
                        -> NCow is Cow * 2, insertItem(31, NCow), write('Sapi kamu menghasilkan '), write(NCow), write(' botol susu.\n'), retract(cowLastTaken(D)), asserta(cowLastTaken(Day)), ExpOut is 25 * Cow, write(ExpOut), write(' exp ranching!\n'), !
                        ; NCow is Cow * 3, insertItem(31, NCow), write('Sapi kamu menghasilkan '), write(NCow), write(' botol susu.\n'), retract(cowLastTaken(D)), asserta(cowLastTaken(Day)), ExpOut is 25 * Cow, write(ExpOut), write(' exp ranching!\n'), !
                    )
                ; (Lvranching < 30)
                -> 
                    (
                        (N =< 33)
                        -> NCow is Cow * 2, insertItem(31, NCow), write('Sapi kamu menghasilkan '), write(NCow), write(' botol susu.\n'), retract(cowLastTaken(D)), asserta(cowLastTaken(Day)), ExpOut is 25 * Cow, write(ExpOut), write(' exp ranching!\n'), !
                        ; (N =< 67)
                        -> NCow is Cow * 3, insertItem(31, NCow), write('Sapi kamu menghasilkan '), write(NCow), write(' botol susu.\n'), retract(cowLastTaken(D)), asserta(cowLastTaken(Day)), ExpOut is 25 * Cow, write(ExpOut), write(' exp ranching!\n'), !
                        ; NCow is Cow * 4, insertItem(31, NCow), write('Sapi kamu menghasilkan '), write(NCow), write(' botol susu.\n'), retract(cowLastTaken(D)), asserta(cowLastTaken(Day)), ExpOut is 25 * Cow, write(ExpOut), write(' exp ranching!\n'), !
                    )
                ;
                    (
                        (N =< 33)
                        -> NCow is Cow * 3, insertItem(31, NCow), write('Sapi kamu menghasilkan '), write(NCow), write(' botol susu.\n'), retract(cowLastTaken(D)), asserta(cowLastTaken(Day)), ExpOut is 25 * Cow, write(ExpOut), write(' exp ranching!\n'), !
                        ; (N =< 67)
                        -> NCow is Cow * 4, insertItem(31, NCow), write('Sapi kamu menghasilkan '), write(NCow), write(' botol susu.\n'), retract(cowLastTaken(D)), asserta(cowLastTaken(Day)), ExpOut is 25 * Cow, write(ExpOut), write(' exp ranching!\n'), !
                        ; NCow is Cow * 5, insertItem(31, NCow), write('Sapi kamu menghasilkan '), write(NCow), write(' botol susu.\n'), retract(cowLastTaken(D)), asserta(cowLastTaken(Day)), ExpOut is 25 * Cow, write(ExpOut), write(' exp ranching!\n'), !
                    )
            )
        ; write('Sapi kamu belum menghasilkan susu\n'), ExpOut is 15 * Cow, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
    ).

woolSheep(Day, Lvranching, ExpOut) :-
    sheepLastTaken(D),
    sheep(Sheep),
    (
        (Day > D)
        ->
            generateRandom(N),
            (
                (Lvranching < 10)
                -> 
                    (
                        (N =< 33)
                        -> write('Domba kamu belum menghasilkan wool\n'), ExpOut is 15 * Sheep, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
                        ; (N =< 67)
                        -> NSheep is Sheep, insertItem(32, NSheep), write('Domba kamu menghasilkan '), write(NSheep), write(' helai wool.\n'), retract(sheepLastTaken(D)), asserta(sheepLastTaken(Day)), ExpOut is 30 * Sheep, write(ExpOut), write(' exp ranching!\n'), !
                        ; NSheep is Sheep * 2, insertItem(32, NSheep), write('Domba kamu menghasilkan '), write(NSheep), write(' helai wool.\n'), retract(sheepLastTaken(D)), asserta(sheepLastTaken(Day)), ExpOut is 30 * Sheep, write(ExpOut), write(' exp ranching!\n'), !
                    )
                ; (Lvranching < 20)
                ->
                    (
                        (N =< 33)
                        -> NSheep is Sheep, insertItem(32, NSheep), write('Domba kamu menghasilkan '), write(NSheep), write(' helai wool.\n'), retract(sheepLastTaken(D)), asserta(sheepLastTaken(Day)), ExpOut is 30 * Sheep, write(ExpOut), write(' exp ranching!\n'), !
                        ; (N =< 67)
                        -> NSheep is Sheep*2, insertItem(32, NSheep), write('Domba kamu menghasilkan '), write(NSheep), write(' helai wool.\n'), retract(sheepLastTaken(D)), asserta(sheepLastTaken(Day)), ExpOut is 30 * Sheep, write(ExpOut), write(' exp ranching!\n'), !
                        ; NSheep is Sheep*3, insertItem(32, NSheep), write('Domba kamu menghasilkan '), write(NSheep), write(' helai wool.\n'), retract(sheepLastTaken(D)), asserta(sheepLastTaken(Day)), ExpOut is 30 * Sheep, write(ExpOut), write(' exp ranching!\n'), !
                    )
                ; (Lvranching < 30)
                -> 
                    (
                        (N =< 33)
                        -> NSheep is Sheep*2, insertItem(32, NSheep), write('Domba kamu menghasilkan '), write(NSheep), write(' helai wool.\n'), retract(sheepLastTaken(D)), asserta(sheepLastTaken(Day)), ExpOut is 30 * Sheep, write(ExpOut), write(' exp ranching!\n'), !
                        ; (N =< 67)
                        -> NSheep is Sheep*3, insertItem(32, NSheep), write('Domba kamu menghasilkan '), write(NSheep), write(' helai wool.\n'), retract(sheepLastTaken(D)), asserta(sheepLastTaken(Day)), ExpOut is 30 * Sheep, write(ExpOut), write(' exp ranching!\n'), !
                        ; NSheep is Sheep*4, insertItem(32, NSheep), write('Domba kamu menghasilkan '), write(NSheep), write(' helai wool.\n'), retract(sheepLastTaken(D)), asserta(sheepLastTaken(Day)), ExpOut is 30 * Sheep, write(ExpOut), write(' exp ranching!\n'), !
                    )
                ;
                    (
                        (N =< 33)
                        -> NSheep is Sheep*3, insertItem(32, NSheep), write('Domba kamu menghasilkan '), write(NSheep), write(' helai wool.\n'), retract(sheepLastTaken(D)), asserta(sheepLastTaken(Day)), ExpOut is 30 * Sheep, write(ExpOut), write(' exp ranching!\n'), !
                        ; (N =< 67)
                        -> NSheep is Sheep*4, insertItem(32, NSheep), write('Domba kamu menghasilkan '), write(NSheep), write(' helai wool.\n'), retract(sheepLastTaken(D)), asserta(sheepLastTaken(Day)), ExpOut is 30 * Sheep, write(ExpOut), write(' exp ranching!\n'), !
                        ; NSheep is Sheep*5,insertItem(32, NSheep), write('Domba kamu menghasilkan '), write(NSheep), write(' helai wool.\n'), retract(sheepLastTaken(D)), asserta(sheepLastTaken(Day)), ExpOut is 30 * Sheep, write(ExpOut), write(' exp ranching!\n'), !
                    )
            )
        ; write('Domba kamu belum menghasilkan wool.\n'), ExpOut is 15 * Sheep, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
    ).

pigMeat(Lvranching, ExpOut) :-
    pig(Pig),
    (
        searchEquipment(38, _, LvSamurai)
        ->  write('Masukkan jumlah pig yang akan di-kill!\n'), read(Jumlah),
                (
                    (Jumlah =< Pig)
                    -> Npig is Pig - Jumlah, retract(pig(Pig)), asserta(pig(Npig)), killPig(Lvranching, LvSamurai, Jumlah, ExpOut)
                    ; write('Jumlah yang dimasukkan melebihi jumlah pig pada ranch.\n')
                )

        ; write('Kamu tidak memiliki samurai untuk memotong hewan ternak.\n'), !
    ).

killPig(Lvranching, LvSamurai, Jumlah, ExpOut) :-
    (
        (Lvranching < 10)
        -> tier1PigKill(LvSamurai, Jumlah, ExpOut)
        ; (Lvranching < 20)
        -> tier2PigKill(LvSamurai, Jumlah, ExpOut)
        ; (Lvranching < 30)
        -> tier3PigKill(LvSamurai, Jumlah, ExpOut)
        ; tier4PigKill(LvSamurai, Jumlah, ExpOut)
    ).

tier1PigKill(LvSamurai, Jumlah, ExpOut) :-
    generateRandom(N),
    (
        (LvSamurai > 20)
        -> NN is ((LvSamurai - (mod(LvSamurai, 20))) / 2), !
        ; NN is 0, !
    ),
    (
        (N < (25 - NN))
        -> write('Yah, sepertinya babi-babi Anda tidak menghasilkan daging.\n'), ExpOut is 15 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
        ; (N < 50)
        -> Hasil is Jumlah, insertItem(29, Hasil), write('Wah, Anda mendapat '),  write(Hasil), write(' daging!\n'), ExpOut is 40 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
        ; (N < (75 - NN))
        -> Hasil is Jumlah*2, insertItem(29, Hasil), write('Wah, Anda mendapat '), write(Hasil), write(' daging!\n'), ExpOut is 40 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
        ; Hasil is Jumlah*3, insertItem(29, Hasil), write('Wah, Anda mendapat '), write(Hasil), write(' daging!\n'), ExpOut is 40 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
    ).

tier2PigKill(LvSamurai, Jumlah, ExpOut) :-
    generateRandom(N),
    (
        (LvSamurai > 20)
        -> NN is ((LvSamurai - (mod(LvSamurai, 20))) / 2), !
        ; NN is 0, !
    ),
    (
        (N < (25 - NN))
        -> Hasil is Jumlah*1, insertItem(29, Hasil), write('Wah, Anda mendapat '), write(Hasil), write(' daging!\n'), ExpOut is 40 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
        ; (N < 50)
        -> Hasil is Jumlah*2, insertItem(29, Hasil), write('Wah, Anda mendapat '), write(Hasil), write(' daging!\n'), ExpOut is 40 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
        ; (N < (75 - NN))
        -> Hasil is Jumlah*3, insertItem(29, Hasil), write('Wah, Anda mendapat '), write(Hasil), write(' daging!\n'), ExpOut is 40 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
        ; Hasil is Jumlah*4, insertItem(29, Hasil), write('Wah, Anda mendapat '), write(Hasil), write(' daging!\n'), ExpOut is 40 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
    ).

tier3PigKill(LvSamurai, Jumlah, ExpOut) :-
    generateRandom(N),
    (
        (LvSamurai > 20)
        -> NN is ((LvSamurai - (mod(LvSamurai, 20))) / 2), !
        ; NN is 0, !
    ),
    (
        (N < (25 - NN))
        -> Hasil is Jumlah*2, insertItem(29, Hasil), write('Wah, Anda mendapat '), write(Hasil), write(' daging!\n'), ExpOut is 40 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
        ; (N < 50)
        -> Hasil is Jumlah*3, insertItem(29, Hasil), write('Wah, Anda mendapat '), write(Hasil), write(' daging!\n'), ExpOut is 40 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
        ; (N < (75 - NN))
        -> Hasil is Jumlah*4, insertItem(29, Hasil), write('Wah, Anda mendapat '), write(Hasil), write(' daging!\n'), ExpOut is 40 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
        ; Hasil is Jumlah*5, insertItem(29, Hasil), write('Wah, Anda mendapat '), write(Hasil), write(' daging!\n'), ExpOut is 40 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
    ).

% Tier4 bisa mendapatkan 5 daging secara terus menerus jika level Samurai cukup tinggi dan ada chance 5% mendapat 6 daging
tier4PigKill(LvSamurai, Jumlah, ExpOut) :-
    generateRandom(N),
    (
        (LvSamurai > 20)
        -> NN is ((LvSamurai - (mod(LvSamurai, 20))) / 2), !
        ; NN is 0, !
    ),
    (
        (N < (25 - NN))
        -> Hasil is Jumlah*2, insertItem(29, Hasil), write('Wah, Anda mendapat '), write(Hasil), write(' daging!\n'), ExpOut is 40 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
        ; (N < (50 - NN))
        -> Hasil is Jumlah*3, insertItem(29, Hasil), write('Wah, Anda mendapat '), write(Hasil), write(' daging!\n'), ExpOut is 40 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
        ; (N < (75 - NN))
        -> Hasil is Jumlah*4, insertItem(29, Hasil), write('Wah, Anda mendapat '), write(Hasil), write(' daging!\n'), ExpOut is 40 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
        ; (N < 95)
        -> Hasil is Jumlah*5, insertItem(29, Hasil), write('Wah, Anda mendapat '), write(Hasil), write(' daging!\n'), ExpOut is 40 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
        ; Hasil is Jumlah*6, insertItem(29, Hasil), write('Wah, Anda mendapat '), write(Hasil), write(' daging!\n'), ExpOut is 40 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
    ).

% Maksimal 4 feather per ostrich
ostrichFeather(Day, Lvranching, ExpOut) :-
    ostrich(Ostrich),
    ostrichLastTaken(D),
    (Day > D + 2)
    -> (
            generateRandom(N),
            (Lvranching < 10)
            -> (
                    (N < 25)
                    -> write('Maaf, bulu ostrich Anda belum ada yang rontok'), ExpOut is 40 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !, fail
                    ; (N < 50)
                    -> insertItem(33, Ostrich), write('Wah, Anda mendapat '), write(Ostrich), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), ExpOut is 50 * Ostrich, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
                    ; (N < 50)
                    -> NOstrich is Ostrich * 2, insertItem(33, NOstrich), write('Wah, Anda mendapat '), write(NOstrich), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), ExpOut is 50 * Ostrich, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
                    ; NOstrich is Ostrich * 3, insertItem(33, NOstrich), write('Wah, Anda mendapat '), write(NOstrich), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), ExpOut is 50 * Ostrich, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
                )
            ; (Lvranching < 20)
            -> (
                    (N < 33)
                    -> insertItem(33, Ostrich), write('Wah, Anda mendapat '), write(Ostrich), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), ExpOut is 50 * Ostrich, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
                    ; (N < 67)
                    -> NOstrich is Ostrich * 2, insertItem(33, NOstrich), write('Wah, Anda mendapat '), write(NOstrich), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), ExpOut is 50 * Ostrich, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
                    ; NOstrich is Ostrich * 3, insertItem(33, NOstrich), write('Wah, Anda mendapat '), write(NOstrich), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), ExpOut is 50 * Ostrich, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
                )
            ; (Lvranching < 30)
            -> (
                    (N < 33)
                    -> NOstrich is Ostrich * 2, insertItem(33, NOstrich), write('Wah, Anda mendapat '), write(NOstrich), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), ExpOut is 50 * Ostrich, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
                    ; (N < 67)
                    -> NOstrich is Ostrich * 3, insertItem(33, NOstrich), write('Wah, Anda mendapat '), write(NOstrich), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), ExpOut is 50 * Ostrich, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
                    ; NOstrich is Ostrich * 4, insertItem(33, NOstrich), write('Wah, Anda mendapat '), write(NOstrich), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), ExpOut is 50 * Ostrich, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
                )
            ;   (
                    (N < 50)
                    -> NOstrich is Ostrich * 3, insertItem(33, NOstrich), write('Wah, Anda mendapat '), write(NOstrich), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), ExpOut is 50 * Ostrich, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
                    ; NOstrich is Ostrich * 4, insertItem(33, NOstrich), write('Wah, Anda mendapat '), write(NOstrich), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), ExpOut is 50 * Ostrich, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
                )
        )
    ; write('Maaf, bulu ostrich Anda belum ada yang rontok'), ExpOut is 40 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !, fail.

tigerSkin(Lvranching, ExpOut) :-
    tiger(Tiger),
    (
        searchEquipment(38, _, LvSamurai)
        ->  write('Masukkan jumlah tiger yang akan di-kill!\n'), read(Jumlah),
                (
                    (Jumlah =< Tiger)
                    -> Ntiger is Tiger - Jumlah, retract(tiger(Tiger)), asserta(tiger(Ntiger)), killTiger(Lvranching, LvSamurai, Jumlah, ExpOut)
                    ; write('Jumlah yang dimasukkan melebihi jumlah tiger pada ranch.\n')
                )
        ; write('Kamu tidak memiliki samurai untuk memotong hewan ternak.\n'), !
    ).

killTiger(Lvranching, LvSamurai, Jumlah, ExpOut) :-
    (
        (Lvranching < 20)
        -> tier1TigerKill(LvSamurai, Jumlah, ExpOut)
        ; tier2TigerKill(LvSamurai, Jumlah, ExpOut)
    ).

tier1TigerKill(LvSamurai, Jumlah, ExpOut) :-
    generateRandom(N),
    (
        (LvSamurai > 20)
        -> NN is ((LvSamurai - (mod(LvSamurai, 20))) / 2), write(NN),!
        ; NN is 0, !
    ),
    (
        (N < (50 - NN))
        -> insertItem(34, Jumlah), write('Wah, Anda mendapat '), write(Jumlah), write(' tiger skin!\n'), ExpOut is 65 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
        ; NJumlah is Jumlah * 2, insertItem(34, NJumlah), write('Wah, Anda mendapat '), write(NJumlah), write(' tiger skin!\n'), ExpOut is 65 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
    ),
    generateRandom(N2),
    (
        (N2 < 33)
        -> !
        ; (N2 < 67)
        -> insertItem(29, Jumlah), write('Anda juga mendapat '), write(Jumlah), write(' daging.\n')
        ; NJumlah is Jumlah * 2, insertItem(29, NJumlah), write('Anda juga mendapat '), write(NJumlah), write(' daging.\n')
    ).

tier2TigerKill(LvSamurai, Jumlah, ExpOut) :-
    generateRandom(N),
    (
        (LvSamurai > 20)
        -> NN is ((LvSamurai - (mod(LvSamurai, 20))) / 2), !
        ; NN is 0, !
    ),
    (
        (N < (50 - NN))
        -> NJumlah is Jumlah * 2, insertItem(34, NJumlah), write('Wah, Anda mendapat '), write(NJumlah), write(' tiger skin!\n'), ExpOut is 65 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
        ; NJumlah is Jumlah * 3, insertItem(34, NJumlah), write('Wah, Anda mendapat '), write(NJumlah), write(' tiger skin!\n'), ExpOut is 65 * Jumlah, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
    ),
    generateRandom(N2),
    (
        (N2 < 33)
        -> insertItem(29, Jumlah), write('Anda juga mendapat '), write(Jumlah), write(' daging.\n')
        ; (N2 < 67)
        -> NJumlah is Jumlah * 2, insertItem(29, NJumlah), write('Anda juga mendapat '), write(NJumlah), write(' daging.\n')
        ; NJumlah is Jumlah * 3, insertItem(29, NJumlah), write('Anda juga mendapat '), write(NJumlah), write(' daging.\n')
    ).

duckGoldenEgg(Day, Lvranching, ExpOut) :-
    duckLastTaken(D),
    (Day > D + 3)
    -> (
        (Lvranching < 20)
        -> insertItem(35, 1), write('Wah, Anda mendapat 1 golden egg!\n'), insertItem(29, 3), write('Anda juga mendapat 3 daging.\n'), ExpOut is 80, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
        ; insertItem(35, 1), write('Wah, Anda mendapat 1 golden egg!\n'), insertItem(29, 4), write('Anda juga mendapat 4 daging.\n'), ExpOut is 80, write('Kamu mendapat '), write(ExpOut), write(' exp ranching!\n'), !
    ).