:- dynamic((dataHarvest/5)).

% Jika galian, IDSeed = 0
% dataHarvest(X, Y, IDSeed, DayHarvest, HourHavest)

% carrot 1 Day
% potato 2 Day
% wheat 3 Day
% melon 4 Day
% pumpkin 5 Day
% beet_root 6 Day
% golden_apple 7 Day

searchDataHarvest(X, Y, IDSeed, DayHarvest, HourHavest) :-
    (
        dataHarvest(X, Y, IDSeed, DayHarvest, HourHavest)
        -> !
        ; fail
    ).

validasi_lokasi_dig :- 
    scan_player(_,X,Y),
    (
        (quest_position(XQ, YQ), XQ == X, YQ == Y) 
        -> write('Anda tidak dapat melakukan penggalian di tile ini!\n'), !, fail
        ; (ranch_position(XR, YR), XR == X, YR == Y)
        -> write('Anda tidak dapat melakukan penggalian di tile ini!\n'), !, fail
        ; (house_position(XH, YH), XH == X, YH == Y)
        -> write('Anda tidak dapat melakukan penggalian di tile ini!\n'), !, fail
        ; (market_position(XM, YM),XM == X, YM == Y)
        -> write('Anda tidak dapat melakukan penggalian di tile ini!\n'), !, fail
        ; searchDataHarvest(X, Y, _, _, _)
        -> write('Anda tidak dapat melakukan penggalian di tile ini!\n'), !, fail
        ; !
    ).

% Tier 1 hanya menggali 1 tile
% Tier 2 juga menggali tile di sebalah kanan dan kiriny
% Tier 3 menggali tile di depan, belakang, kanan, dan, kirinya
validasi_shovel :-
    (
        searchEquipment(36, _, LvShovel)
        -> scan_player(_, X, Y),
            (
                (LvShovel < 15)
                -> tier1Dig(X, Y)
                ; (LvShovel < 30)
                -> tier2Dig(X, Y)
                ; tier3Dig(X, Y)
            )
        ; write('Anda tidak mempunyai shovel untuk melakukan penggalian.\n'), !, fail
    ).

tier1Dig(X, Y) :-
    assertz(dataHarvest(X, Y, 0, 1, 1)),
    write('Anda menggali tile ini.\n').

tier2Dig(X, Y) :-
    assertz(dataHarvest(X, Y, 0, 1, 1)),
    (
        (validasi_lokasi_dig_2(X + 1, Y))
        -> assertz(dataHarvest(X + 1, Y, 0, 1, 1))
    ),
    (
        (validasi_lokasi_dig_2(X - 1, Y))
        -> assertz(dataHarvest(X - 1, Y, 0, 1, 1))
    ),
    write('Anda menggali tile ini.\n'). 

tier3Dig(X, Y) :-
    assertz(dataHarvest(X, Y, 0, 1, 1)),
    (
        (validasi_lokasi_dig_2(X + 1, Y))
        -> assertz(dataHarvest(X + 1, Y, 0, 1, 1))
    ),
    (
        (validasi_lokasi_dig_2(X - 1, Y))
        -> assertz(dataHarvest(X - 1, Y, 0, 1, 1))
    ),
    (
        (validasi_lokasi_dig_2(X, Y + 1))
        -> assertz(dataHarvest(X, Y + 1, 0, 1, 1))
    ),
    (
        (validasi_lokasi_dig_2(X, Y - 1))
        -> assertz(dataHarvest(X, Y - 1, 0, 1, 1))
    ),
    write('Anda menggali tile ini.\n'). 

validasi_lokasi_dig_2(X, Y) :- 
    (
        (quest_position(XQ, YQ), XQ == X, YQ == Y) 
        -> !, fail
        ; (ranch_position(XR, YR), XR == X, YR == Y)
        -> !, fail
        ; (house_position(XH, YH), XH == X, YH == Y)
        -> !, fail
        ; (market_position(XM, YM),XM == X, YM == Y)
        -> !, fail
        ; searchDataHarvest(X, Y, _, _, _)
        -> !, fail
        ; !
    ).

dig :-
    validasi_lokasi_dig,
    validasi_shovel. 
    
validasi_lokasi_plant :-
    scan_player(_,X,Y),
    (
        (searchDataHarvest(X, Y, ID, _, _), ID == 0) 
        -> !
        ; write('Anda tidak bisa menanam pada tile ini, jika tile ini bukan tile spesial, lakukan penggalian terlebih dahulu!\n'), !, fail
    ).

validasi_seed :-
    (
        searchItem(8, _, _)
        -> write('Kamu memiliki\n'), displaySeed, !
        ; searchItem(9, _, _)
        -> write('Kamu memiliki\n'), displaySeed, !
        ; searchItem(10, _, _)
        -> write('Kamu memiliki\n'), displaySeed, !
        ; searchItem(11, _, _)
        -> write('Kamu memiliki\n'), displaySeed, !
        ; searchItem(12, _, _)
        -> write('Kamu memiliki\n'), displaySeed, !
        ; searchItem(13, _, _)
        -> write('Kamu memiliki\n'), displaySeed, !
        ; searchItem(14, _, _)
        -> write('Kamu memiliki\n'), displaySeed, !
        ; write('Maaf, kamu tidak memiliki seed untuk ditanam!'), !, fail
    ).

plant(Day, Hour) :-
    validasi_lokasi_plant,
    validasi_seed,
    scan_player(_, X, Y),
    write('\nApa yang mau kamu tanam?\n'),
    read(Seed),
    (
        Seed == 'carrot',
            decreaseItem(8, 1), retract(dataHarvest(X, Y, _, _, _)), NDay is Day + 1, assertz(dataHarvest(X, Y, 8, NDay, Hour)), write('Kamu menanam sebuah carrot seed!\n');
        Seed == 'potato',
            decreaseItem(9, 1), retract(dataHarvest(X, Y, _, _, _)), NDay is Day + 2, assertz(dataHarvest(X, Y, 9, NDay, Hour)), write('Kamu menanam sebuah potato seed!\n');
        Seed == 'wheat',
            decreaseItem(10, 1), retract(dataHarvest(X, Y, _, _, _)), NDay is Day + 3, assertz(dataHarvest(X, Y, 10, NDay, Hour)), write('Kamu menanam sebuah wheat seed!\n');
        Seed == 'melon',
            decreaseItem(11, 1), retract(dataHarvest(X, Y, _, _, _)), NDay is Day + 4, assertz(dataHarvest(X, Y, 11, NDay, Hour)), write('Kamu menanam sebuah melon seed!\n');
        Seed == 'pumpkin',
            decreaseItem(12, 1), retract(dataHarvest(X, Y, _, _, _)), NDay is Day + 5, assertz(dataHarvest(X, Y, 12, NDay, Hour)), write('Kamu menanam sebuah pumpkin seed!\n');
        Seed == 'beet_root',
            decreaseItem(13, 1), retract(dataHarvest(X, Y, _, _, _)), NDay is Day + 6, assertz(dataHarvest(X, Y, 13, NDay, Hour)), write('Kamu menanam sebuah beet root seed seed!\n');
        Seed == 'golden_apple',
            decreaseItem(14, 1), retract(dataHarvest(X, Y, _, _, _)), NDay is Day + 7, assertz(dataHarvest(X, Y, 14, NDay, Hour)), write('Kamu menanam sebuah golden apple seed seed!\n')
    ). 

validasi_harvest :-
    scan_player(_, X, Y),
    (
        (searchDataHarvest(X, Y, ID, _, _), ID \== 0)
        -> !
        ; fail
    ).

% Belum diimplementasikan (perlu pengimplementasian waktu terlebih dahulu, disimulasikan jika belum siap panen)
validasi_kesiapan_panen(Day, Hour, ID) :-
    scan_player(_, X, Y),
    searchDataHarvest(X, Y, ID, NDay, NHour),
    (NDay =< Day),
    (NHour =< Hour)
    .

harvest(Day, Hour, Lvfarming, ExpOut) :-
    generateRandom(N),
    (
        validasi_harvest
        -> 
            (
                validasi_kesiapan_panen(Day, Hour, ID)
                -> 
                    (
                        (ID == 8)
                        -> (
                                    (Lvfarming < 10)
                                    -> tier1CarrotPlant(N, ExpOut)
                                    ; (Lvfarming < 20)
                                    -> tier2CarrotPlant(N, ExpOut)
                                    ; (Lvfarming < 30)
                                    -> tier3Carrotplant(N, ExpOut)
                                    ; tier4CarrotPlant(N, ExpOut)
                           )
                        ; (ID == 9)
                        -> (
                                    (Lvfarming < 10)
                                    -> tier1PotatoPlant(N, ExpOut)
                                    ; (Lvfarming < 20)
                                    -> tier2PotatoPlant(N, ExpOut)
                                    ; (Lvfarming < 30)
                                    -> tier3Potatoplant(N, ExpOut)
                                    ; tier4PotatoPlant(N, ExpOut)
                            )
                        ; (ID == 10)
                        -> (
                                    (Lvfarming < 10)
                                    -> tier1WheatPlant(N, ExpOut)
                                    ; (Lvfarming < 20)
                                    -> tier2WheatPlant(N, ExpOut)
                                    ; (Lvfarming < 30)
                                    -> tier3Wheatplant(N, ExpOut)
                                    ; tier4WheatPlant(N, ExpOut)
                            )
                        ; (ID == 11)
                        -> (
                                    (Lvfarming < 10)
                                    -> tier1MelonPlant(N, ExpOut)
                                    ; (Lvfarming < 20)
                                    -> tier2MelonPlant(N, ExpOut)
                                    ; (Lvfarming < 30)
                                    -> tier3Melonplant(N, ExpOut)
                                    ; tier4MelonPlant(N, ExpOut)
                            )
                        ; (ID == 12)
                        -> (
                                    (Lvfarming < 10)
                                    -> tier1PumpkinPlant(N, ExpOut)
                                    ; (Lvfarming < 20)
                                    -> tier2PumpkinPlant(N, ExpOut)
                                    ; (Lvfarming < 30)
                                    -> tier3Pumpkinplant(N, ExpOut)
                                    ; tier4PumpkinPlant(N, ExpOut)
                            )
                        ; (ID == 13)
                        -> (
                                    (Lvfarming < 10)
                                    -> tier1BeetRootPlant(N, ExpOut)
                                    ; (Lvfarming < 20)
                                    -> tier2BeetRootPlant(N, ExpOut)
                                    ; (Lvfarming < 30)
                                    -> tier3BeetRootplant(ExpOut)
                                    ; tier4BeetRootPlant(N, ExpOut)
                            )
                        ; (
                                    (Lvfarming < 20)
                                    -> tier1GoldenApplePlant(ExpOut)
                                    ; tier2GoldenApplePlant(N, ExpOut)
                            )
                    )
                ; write('Tanaman ini belum siap panen, datang lagi jika sudah siap yaa!\n'), scan_player(_, X, Y), !, searchDataHarvest(X, Y, ID, NDay, NHour), !, write('Sisa hari : '), SisaHari is NDay-Day, write(SisaHari), write('\n'), !, fail
            )
        ; write('Tile ini tidak bisa dipanen.\n'), !, fail
    ).

tier1CarrotPlant(N, ExpOut) :-
    (N < 33)
    -> retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Wah, carrot crop kamu gak menghasilkan hasil panen!\n'), ExpOut is 15, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; (N < 67)
    -> insertItem(1, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 1 carrot\n'), ExpOut is 20, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(1, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 2 carrot\n'), ExpOut is 20, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier2CarrotPlant(N, ExpOut) :-
    (N < 33)
    -> insertItem(1, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 1 carrot\n'), ExpOut is 20, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; (N < 67)
    -> insertItem(1, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 2 carrot\n'), ExpOut is 20, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(1, 3), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 3 carrot\n'), ExpOut is 20, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier3CarrotPlant(N, ExpOut) :-
    (N < 33)
    -> insertItem(1, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 2 carrot\n'), ExpOut is 20, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; (N < 67)
    -> insertItem(1, 3), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 3 carrot\n'), ExpOut is 20, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(1, 4), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 4 carrot\n'), ExpOut is 20, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier4CarrotPlant(N, ExpOut) :-
    (N < 33)
    -> insertItem(1, 3), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 3 carrot\n'), ExpOut is 20, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; (N < 67)
    -> insertItem(1, 4), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 4 carrot\n'), ExpOut is 20, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(1, 5), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 5 carrot\n'), ExpOut is 20, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier1PotatoPlant(N, ExpOut) :-
    (N < 33)
    -> retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Wah, potato crop kamu gak menghasilkan hasil panen!\n'), ExpOut is 15, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; (N < 67)
    -> insertItem(2, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 1 potato\n'), ExpOut is 25, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(2, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 2 potato\n'), ExpOut is 25, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier2PotatoPlant(N, ExpOut) :-
    (N < 33)
    -> insertItem(2, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 1 potato\n'), ExpOut is 25, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; (N < 67)
    -> insertItem(2, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 2 potato\n'), ExpOut is 25, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(2, 3), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 3 potato\n'), ExpOut is 25, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier3PotatoPlant(N, ExpOut) :-
    (N < 33)
    -> insertItem(2, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 2 potato\n'), ExpOut is 25, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; (N < 67)
    -> insertItem(2, 3), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 3 potato\n'), ExpOut is 25, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(2, 4), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 4 potato\n'), ExpOut is 25, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier4PotatoPlant(N, ExpOut) :-
    (N < 33)
    -> insertItem(2, 3), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 3 potato\n'), ExpOut is 25, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; (N < 67)
    -> insertItem(2, 4), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 4 potato\n'), ExpOut is 25, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(2, 5), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 5 potato\n'), ExpOut is 25, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier1WheatPlant(N, ExpOut) :-
    (N < 33)
    -> retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Wah, wheat crop kamu gak menghasilkan hasil panen!\n'), ExpOut is 15, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; (N < 67)
    -> insertItem(3, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 1 wheat\n'), ExpOut is 30, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(3, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 2 wheat\n'), ExpOut is 30, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier2WheatPlant(N, ExpOut) :-
    (N < 33)
    -> insertItem(3, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 1 wheat\n'), ExpOut is 30, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; (N < 67)
    -> insertItem(3, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 2 wheat\n'), ExpOut is 30, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(3, 3), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 3 wheat\n'), ExpOut is 30, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier3WheatPlant(N, ExpOut) :-
    (N < 33)
    -> insertItem(3, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 2 wheat\n'), ExpOut is 30, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; (N < 67)
    -> insertItem(3, 3), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 3 wheat\n'), ExpOut is 30, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(3, 4), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 4 wheat\n'), ExpOut is 30, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier4WheatPlant(N, ExpOut) :-
    (N < 33)
    -> insertItem(3, 3), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 3 wheat\n'), ExpOut is 30, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; (N < 67)
    -> insertItem(3, 4), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 4 wheat\n'), ExpOut is 30, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(3, 5), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 5 wheat\n'), ExpOut is 30, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier1MelonPlant(N, ExpOut) :-
    (N < 33)
    -> retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Wah, melon crop kamu gak menghasilkan hasil panen!\n'), ExpOut is 15, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; (N < 67)
    -> insertItem(4, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 1 melon\n'), ExpOut is 40, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(4, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 2 melon\n'), ExpOut is 40, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier2MelonPlant(N, ExpOut) :-
    (N < 50)
    -> insertItem(4, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 1 melon\n'), ExpOut is 40, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(4, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 2 melon\n'), ExpOut is 40, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier3MelonPlant(N, ExpOut) :-
    (N < 50)
    -> insertItem(4, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 2 melon\n'), ExpOut is 40, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(4, 3), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 3 melon\n'), ExpOut is 40, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier4MelonPlant(N, ExpOut) :-
    (N < 50)
    -> insertItem(4, 3), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 3 melon\n'), ExpOut is 40, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(4, 4), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 4 melon\n'), ExpOut is 40, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier1PumpkinPlant(N, ExpOut) :-
    (N < 33)
    -> retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Wah, pumpkin crop kamu gak menghasilkan hasil panen!\n'), ExpOut is 15, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; (N < 67)
    -> insertItem(5, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 1 pumpkin\n'), ExpOut is 50, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(5, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 2 pumpkin\n'), ExpOut is 50, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier2PumpkinPlant(N, ExpOut) :-
    (N < 50)
    -> insertItem(5, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 1 pumpkin\n'), ExpOut is 50, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(5, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 2 pumpkin\n'), ExpOut is 50, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier3PumpkinPlant(N, ExpOut) :-
    (N < 50)
    -> insertItem(5, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 2 pumpkin\n'), ExpOut is 50, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(5, 3), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 3 pumpkin\n'), ExpOut is 50, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier4PumpkinPlant(N, ExpOut) :-
    (N < 50)
    -> insertItem(5, 3), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 3 pumpkin\n'), ExpOut is 50, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(5, 4), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 4 pumpkin\n'), ExpOut is 50, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier1BeetRootPlant(N, ExpOut) :-
    (N < 33)
    -> retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Wah, beet root crop kamu gak menghasilkan hasil panen!\n'), ExpOut is 15, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; (N < 67)
    -> insertItem(6, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 1 beet root\n'), ExpOut is 65, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(6, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 2 beet root\n'), ExpOut is 65, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier2BeetRootPlant(N, ExpOut) :-
    (N < 50)
    -> insertItem(6, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 1 beet root\n'), ExpOut is 65, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(6, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 2 beet root\n'), ExpOut is 65, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier3BeetRootPlant(ExpOut) :-
    insertItem(6, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 2 beet root\n'), ExpOut is 65, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier4BeetRootPlant(N, ExpOut) :-
    (N < 50)
    -> insertItem(6, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 2 beet root\n'), ExpOut is 65, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(6, 3), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 3 beet root\n'), ExpOut is 65, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier1GoldenApplePlant(ExpOut) :-
    insertItem(7, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 1 golden apple\n'), ExpOut is 80, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.

tier2GoldenApplePlant(N, ExpOut) :-
    (N < 50)
    -> insertItem(7, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 1 golden apple\n'), ExpOut is 80, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !
    ; insertItem(7, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Kamu mendapat 2 golden apple\n'), ExpOut is 80, write('Kamu mendapat '), write(ExpOut), write(' exp farming!\n'), !.


kalibrasiMap :-
    forall(dataHarvest(X, Y, ID, _, _), kalibrasi(X, Y, ID)).

kalibrasi(X, Y, ID) :-
    scan_player(_, XP, YP),
    (
        (X \== XP; Y \== YP) ->
        (
            ID == 0 -> trueMap(Matrix), replace(Matrix, X, Y, '=', NMatrix), retract(trueMap(_)), asserta(trueMap(NMatrix));
            ID == 8 -> trueMap(Matrix), replace(Matrix, X, Y, 'c', NMatrix), retract(trueMap(_)), asserta(trueMap(NMatrix));
            ID == 9 -> trueMap(Matrix), replace(Matrix, X, Y, 'p', NMatrix), retract(trueMap(_)), asserta(trueMap(NMatrix));
            ID == 10 -> trueMap(Matrix), replace(Matrix, X, Y, 'w', NMatrix), retract(trueMap(_)), asserta(trueMap(NMatrix));
            ID == 11 -> trueMap(Matrix), replace(Matrix, X, Y, 'm', NMatrix), retract(trueMap(_)), asserta(trueMap(NMatrix));
            ID == 12 -> trueMap(Matrix), replace(Matrix, X, Y, 'u', NMatrix), retract(trueMap(_)), asserta(trueMap(NMatrix));
            ID == 13 ->trueMap(Matrix), replace(Matrix, X, Y, 'b', NMatrix), retract(trueMap(_)), asserta(trueMap(NMatrix));
            ID == 14 -> trueMap(Matrix), replace(Matrix, X, Y, 'g', NMatrix), retract(trueMap(_)), asserta(trueMap(NMatrix))
        ); trueMap(Matrix), retract(trueMap(_)), asserta(trueMap(Matrix))
    ). 