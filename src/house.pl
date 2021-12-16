/* Deklarasi Fakta */
:- dynamic(diary/29).
% :- dynamic(diary/1).
:- include('season.pl').
% diary(DAY, IsiDiary, Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc, inventory_item_list, inventory_equipment_list, chicken, cow, sheep, pig, ostrich, tiger, mythical_duck, crop)
% diary(DAY, ISIDIARY, JOB, LV, LVFARMING, EXPFARMING, LVFARMING, EXPFARMING, LVRANCHING, EXPRANCHING, EXPCURR, EXPCAP, GOLD, DAY1, HOUR, QHARVEST, QFISH, QRANCH, ALC, INVENTORY_ITEM_LIST, INVENTORY_EQUIPMENT_LIST, CHICKEN, COW, SHEEP, PIG, OSTRICH, TIGER, MYTHICAL_DUCK, CROP)
% diary(  A,        B,   C,  D,         E,          F,         G,          H,          I,           J,       K,      L,    M,   N,    O,        P,     Q,      R,   S,                   T,                        U,       V,   W,     X,   Y,       Z,    AA,            AB,   AC)
%        [1,   asdasd,   1,  1,         0,          0,          5,         0,          0,           0,       0,    100,  500,   1,    2,        1,     1,       1,  3,                  [],     [[37,fishing_rod,1]],       0,   0,     0,    0,      0,     0,             0,   []]
%        1      2       3    4     5        6             7          8            9           10         11       12      13   14    15    16        17     18    19      20                        21                    22    23    24    25    26       27    28             29  
% mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)

:-dynamic(crop/1).
crop([]).

saveHarvest :-
    (dataHarvest(X, Y, IDSeed, DayHarvest, HourHarvest) ->
        !,
        retract(dataHarvest(X, Y, IDSeed, DayHarvest, HourHarvest)),
        crop(_B),
        NX is X,
        NY is Y,
        NIDSeed is IDSeed,
        NDayHarvest is DayHarvest,
        NHourHarvest is HourHarvest,
        append(_B, [[NX, NY, NIDSeed, NDayHarvest, NHourHarvest]], A),
        retractall(crop(_)),
        asserta(crop(A)),
        saveHarvest;
        true
    ).


writeDiary(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc) :-
    /* Mengecek apabila ada save data di hari tersebut */
    (diary(Day, X, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _) ->
        write('Diary pada hari ini telah kamu overwrite: '), write(X), nl,
        retract(diary(Day, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _));
        true
    ),
    write('Write your diary for Day '), write(Day), write('\n> '),
    read(InputDiary),
    inventory_item_list(ItemList),
    inventory_equipment_list(EquipmentList),
    chicken(Chicken),
    cow(Cow),
    sheep(Sheep),
    pig(Pig),
    ostrich(Ostrich),
    tiger(Tiger),
    mythical_duck(MythicalDuck),
    saveHarvest,
    crop(DataCrop),
    retractall(dataHarvest(_, _, _, _, _)),
    loadCrop(DataCrop),
    updateMap,
    assertz(diary(Day, InputDiary, Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc, ItemList, EquipmentList, Chicken, Cow, Sheep, Pig, Ostrich, Tiger, MythicalDuck, DataCrop)),
    nl, write('Day '), write(Day), write(' entry saved'), nl.

% diary(DAY, ISIDIARY, JOB, LV, LVFARMING, EXPFARMING, LVFARMING, EXPFARMING, LVRANCHING, EXPRANCHING, EXPCURR, EXPCAP, GOLD, DAY, HOUR, QHARVEST, QFISH, QRANCH, ALC, INVENTORY_ITEM_LIST, INVENTORY_EQUIPMENT_LIST, CHICKEN, COW, SHEEP, PIG, OSTRICH, TIGER, MYTHICAL_DUCK, CROP)
% diary(  A,        B,   C,  D,         E,          F,         G,          H,          I,           J,       K,      L,    M,   N,    O,        P,     Q,      R,   S,                   T,                        U,       V,   W,     X,   Y,       Z,    AA,            AB,   AC)

readDiary(Day) :-
    diary(Day, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, AA, AB, AC),
    write('Ini diary untuk hari ke-'), write(Day), write(': '), nl,
    write(B), nl,
    retractall(inventory_item_list(_)),
    asserta(inventory_item_list(T)),
    retractall(inventory_equipment_list(_)),
    asserta(inventory_equipment_listinventory_item_list(U)),
    retractall(chicken(_)),
    asserta(chichken(V)),
    retractall(cow(_)),
    asserta(cow(W)),
    retractall(sheep(_)),
    asserta(sheep(X)),
    retractall(pig(_)),
    asserta(pig(Y)),
    retractall(ostrich(_)),
    asserta(ostrich(Z)),
    retractall(tiger(_)),
    asserta(tiger(AA)),
    retractall(mythical_duck(_)),
    asserta(mythical_duck(AB)),
    retractall(dataHarvest(_, _, _, _, _)),
    loadCrop(AC),
    % chicken, cow, sheep, pig, ostrich, tiger, mythical_duck, crop
    updateMap,
    mainLoop(C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S).

loadCrop([]).
loadCrop([Head | Tail]) :- 
    Head = [A, B, C, D, E],
    An is A,
    Bn is B,
    Cn is C,
    Dn is D,
    En is E,
    asserta(dataHarvest(An, Bn, Cn, Dn, En)),
    loadCrop(Tail).

/* Deklarasi Rules */
house(_NewHour, _NewDay, EXIT, Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc):-
    (
        write('Apa yang mau kamu lakukan?\n'),
        write('-  tidur\n'),
        write('-  tulisDiary\n'),
        write('-  bacaDiary\n'),
        write('-  exit\n> '),
        read(INPUT), nl,
        (
            INPUT == 'tidur',
                EXIT = false,
                write('Kamu tidur\n\n'),
                random(1, 10, Chance),
                (Chance > 8 ->
                    periTidur;true),
                _NewHour is 7, _NewDay is Day + 1,
                seasonAndWeather(Day, _Season, _Weather),
                write('Hari : '), write(_NewDay), write('\n'),
                write('Musim: '), write(_Season), write('\n'),
                write('Cuaca: '), write(_Weather), write('\n');
            INPUT == 'tulisDiary',
                EXIT = false,
                writeDiary(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc),
                _NewDay is Day, _NewHour is Hour;
            INPUT == 'bacaDiary',
                EXIT = false,
                write('Diary pada hari apa yang ingin kamu baca?\n> '),
                read(Entry),
                readDiary(Entry),
                _NewDay is Day, _NewHour is Hour;
            INPUT == 'exit',
                write('Apakah anda ingin keluar dari game? Apabila iya, akan otomatis dianggap kalah'), nl,
                write('1. Iya, saya sudah lelah'), nl,
                write('0. Tidak, tadi hanya salah tekan saja\n> '),
                read(Confirm),
                (
                    (Confirm =:= 1) ->
                        EXIT = true;
                    (Confirm =:= 0) ->
                        EXIT = false,
                        _NewDay is Day,
                        _NewHour is Hour,
                        write('\nSilahkan melanjutkan permainan!'), nl;
                    write('\nInput invalid'), 
                    EXIT = false,
                    _NewDay is Day,
                    _NewHour is Hour,nl
                )
        )
    ).

periTidur:-
    write('\n\nHai, kali ini aku mau memberi kamu kesempatan untuk pergi kemanapun\n'),
    write('Kemanakah kamu mau pergi?\n'),
    write('-> market\n'),
    write('-> ranch\n'),
    write('-> quest\n'),
    write('-> ?????\n'),
    read(Input),
    (
        Input == 'market',
            X is 10,
            Y is 12,
            write('Kamu ada di market\n'),
            moveBrute(X, Y);
        Input == 'ranch',
            X is 10,
            Y is 5,
            write('Kamu ada di ranch\n'),
            moveBrute(X, Y);
        Input == 'quest',
            X is 7,
            Y is 3,
            write('Kamu ada di quest\n'),
            moveBrute(X, Y);
        Input == '?????',
            X is 1,
            Y is 1,
            write('Kamu ada di bzZZzzBZzZZzzBzzZ\n'),
            moveBrute(X, Y);
        write('Yasudahlah kalau kamu tidak ingin pergi\n')
    ).