:- dynamic((fishingCap/1, ranchingCap/1, farmingCap/1)).
fishingCap(100).
ranchingCap(200).
farmingCap(100).

start :-
    nl, nl, nl, nl, nl,
    nl, nl, nl, nl, nl,
    nl, nl, nl, nl, nl,
    nl, nl, nl, nl, nl,
    nl, nl, nl, nl, nl,
    write(' _  _   __   ___  _  _  ___  ___  ____    ___  ____  __   ___ \n'),  
    write('( )( ) (  ) (  ,)( )( )(  _)/ __)(_  _)  / __)(_  _)(  ) (  ,) \n'), 
    write(' )__(  /__\\  )  \\ \\\\//  ) _)\\__ \\  )(    \\__ \\  )(  /__\\  )  \\\n'),
    write('(_)(_)(_)(_)(_)\\_)(__) (___)(___/ (__)   (___/ (__)(_)(_)(_)\\_)\n'), nl,
    write('                          by G01 K03'), nl, nl, nl,
    sleep(1),
    write('Setelah mendapat berita Bitkowin auto cuan, '), nl, nl,
    sleep(1),
    write('Brianaldo pun langsung gaskan menjual semua asetnya untuk membeli Bitkowin.'), nl, nl,
    sleep(2),
    write('Ia bahkan juga meminjam uang dari rentenir sebesar 2.000.000 gold.'), nl, nl,
    sleep(2),
    write('Keesokan harinya, ternyata harga Bitkowin turun secara drastis sehingga'), nl,
    write('Brianaldo menjadi terjerat utang sebesar 200.000 gold.'), nl, nl,
    sleep(2),
    write('Hal ini pun membuat Brianaldo berpikir keras bagaimana cara untuk'), nl,
    write('mengembalikan uang tersebut.'), nl, nl,
    sleep(2),
    write('Setelah beberapa jam berpikir keras, Brianaldo tiba-tiba terpikirkan'), nl,
    write('bahwa Ia memiliki ladang di kampung halamannya.'), nl, nl,
    sleep(2),
    write('Oleh karena itu, Ia memutuskan untuk balik ke kampung halamannya untuk bekerja....'), nl, nl,
    sleep(5),
    nl, nl, nl, nl, nl,
    nl, nl, nl, nl, nl,
    nl, nl, nl, nl, nl,
    nl, nl, nl, nl, nl,
    nl, nl, nl, nl, nl,
    write(' _  _   __   ___  _  _  ___  ___  ____    ___  ____  __   ___ \n'),  
    write('( )( ) (  ) (  ,)( )( )(  _)/ __)(_  _)  / __)(_  _)(  ) (  ,) \n'), 
    write(' )__(  /__\\  )  \\ \\\\//  ) _)\\__ \\  )(    \\__ \\  )(  /__\\  )  \\\n'),
    write('(_)(_)(_)(_)(_)\\_)(__) (___)(___/ (__)   (___/ (__)(_)(_)(_)\\_)\n'), nl,
    write('                        by G01 K03'), nl, nl,
    chooseJob(Job, Lvfarming, Lvfishing, Lvranching), nl,
    initiate_true_map,
    /* mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc), */
    /*Count:  1       2          3           4          5           6           7            8        9      10    11   12    13        14     15      15   16   */
    mainLoop(Job,     1, Lvfarming,          0, Lvfishing,          0, Lvranching,           0,       0,    100,  500,   1,    0,        1,     1,      1,   3), !.

mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc) :-
    (Day < 365) ->
        (
            (Gold < 200000) ->
                write('\n'),
                write('Enter Command:\n'),
                write('| ?- '),
                read(Input), nl,
                (
                    Input == 'status',
                        status(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'quest',
                        player_position(XQuest, YQuest),
                        (
                            (XQuest =:=7, YQuest =:= 3) ->
                                quest(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc),
                                mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);
                            write('Anda sedang tidak berada pada Q'), nl,
                            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
                        );

                    Input == 'alc',
                        player_position(XAlc, YAlc),
                        (
                            (XAlc =:= 1, YAlc =:= 1) ->
                                alc_intro(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);
                            write('???'), nl,
                            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
                        );

                    Input == 'market',
                        player_position(XMarket, YMarket),
                        (
                            (XMarket =:= 10, YMarket =:= 12) ->
                                seasonAndWeather(Day, _Season, _),
                                market(_Season, Gold, GoldOut),
                                mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, GoldOut, Day, Hour, Qharvest, Qfish, Qranch, Alc);
                            write('Anda sedang tidak berada pada M'), nl,
                            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
                        );

                    Input  == 'house',
                        player_position(XRumah, YRumah),
                        (
                            (XRumah =:= 7, YRumah =:= 6) ->
                                house(NewHour, NewDay, EXIT, Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc),
                                (
                                    EXIT == true ->
                                        exitGame;
                                    EXIT == false ->
                                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, NewDay, NewHour, Qharvest, Qfish, Qranch, Alc)
                                );
                            write('Anda sedang tidak berada pada H'), nl,
                            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
                        );
                        

                    Input == 'map',
                        true_map,
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'help',
                        help,
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'inventory',
                        inventory,
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'throwItem',
                        throwItem,
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'fish',
                        fish(Lvfishing, ExpOut),
                        ExpfishingX is Expfishing + ExpOut,
                        fishingCap(Cap),
                            (
                                (ExpfishingX >= Cap) ->
                                write('Level Up Fishing!\n'),
                                addlvfishingv(Lvfishing, LvfishingX),
                                NCap is Cap + Cap * 1.1,
                                retract(fishingCap(_)),
                                asserta(fishingCap(NCap))
                            ; (LvfishingX is Lvfishing)
                            ),
                            addexpcurrv(Expcurr, ExpcurrX),
                            write('Kamu mendapat 30 exp!\n'),
                            (
                                (ExpcurrX >= Expcap) ->
                                    write('Level Up!\n'),
                                    addlv(Lv, LvX),
                                    addexpcapv(Expcap, ExpcapX)
                                ; ExpcapX is Expcap, LvX is Lv
                            ),  
                            NHour is Hour + 2,
                            (
                                (NHour >= 24) ->
                                    write('\nIt\'s a New Day!\n'),
                                    add_dayv(Day, DayX),
                                    NNHour is mod(NHour, 24)
                                ; DayX is Day, NNHour is NHour
                            ),
                        redQfish(Qfish, QfishX),
                        mainLoop(Job, LvX, Lvfarming, Expfarming, LvfishingX, ExpfishingX, Lvranching, Expranching, ExpcurrX, ExpcapX, Gold, DayX, NNHour, Qharvest, QfishX, Qranch, Alc)
                            ;
               
                    Input == 'ranch',
                        ranch(Day, Lvranching, ExpOut),
                        ExpranchingX is Expranching + ExpOut,
                        ranchingCap(Cap),
                        (
                            (ExpranchingX >= Cap) ->
                                write('Level Up ranching!\n'),
                                addlvranchingv(Lvranching, LvranchingX),
                                NCap is Cap + Cap * 1.1,
                                retract(ranchingCap(_)),
                                asserta(ranchingCap(NCap))
                            ; (LvranchingX is Lvranching)
                        ),
                        addexpcurrv(Expcurr, ExpcurrX),
                        write('Kamu mendapat 30 exp!\n'),
                        (
                            (ExpcurrX >= Expcap) ->
                                write('Level Up!\n'),
                                addlv(Lv, LvX),
                                addexpcapv(Expcap, ExpcapX)
                            ; ExpcapX is Expcap, LvX is Lv
                        ),
                        NHour is Hour + 3,
                            (
                                (NHour >= 24) ->
                                    write('\nIt\'s a New Day!\n'),
                                    add_dayv(Day, DayX),
                                    NNHour is mod(NHour, 24)
                                ; DayX is Day, NNHour is NHour
                            ),
                        redQranch(Qranch, QranchX),
                        mainLoop(Job, LvX, Lvfarming, Expfarming, Lvfishing, Expfishing, LvranchingX, ExpranchingX, ExpcurrX, ExpcapX, Gold, DayX, NNHour, Qharvest, Qfish, QranchX, Alc)
                        ;

                    Input == 'dig',
                        dig,
                        NHour is Hour + 1,
                            (
                                (NHour >= 24) ->
                                    write('\nIt\'s a New Day!\n'),
                                    add_dayv(Day, DayX),
                                    NNHour is mod(NHour, 24)
                                ; DayX is Day, NNHour is NHour
                            ),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, DayX, NNHour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'plant',
                        plant(Day, Hour),
                        NHour is Hour + 2,
                        (
                            (NHour >= 24) ->
                                write('\nIt\'s a New Day!\n'),
                                add_dayv(Day, DayX),
                                NNHour is mod(NHour, 24)
                            ; DayX is Day, NNHour is NHour
                        ),
                    mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, DayX, NNHour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'harvest',
                        harvest(Day, Hour, Lvfarming, ExpOut),
                        ExpfarmingX is Expfarming + ExpOut,
                        farmingCap(Cap),
                        (
                            (ExpfarmingX >= Cap) ->
                                write('Level Up farming!\n'),
                                addlvfarmingv(Lvfarming, LvfarmingX),
                                NCap is Cap + Cap * 1.1,
                                retract(farmingCap(_)),
                                asserta(farmingCap(NCap))
                            ; (LvfarmingX is Lvfarming)
                        ),
                        addexpcurrv(Expcurr, ExpcurrX),
                        write('Kamu mendapat 30 exp!\n'),
                        (
                            (ExpcurrX >= Expcap) ->
                                write('Level Up!\n'),
                                addlv(Lv, LvX),
                                addexpcapv(Expcap, ExpcapX)
                            ; ExpcapX is Expcap, LvX is Lv
                        ),
                        NHour is Hour + 2,
                        (
                            (NHour >= 24) ->
                                write('\nIt\'s a New Day!\n'),
                                add_dayv(Day, DayX),
                                NHour is mod(NHour, 24)
                            ; DayX is Day
                        ),
                    redQharvest(Qharvest, QharvestX),
                    mainLoop(Job, LvX, LvfarmingX, ExpfarmingX, Lvfishing, Expfishing, Lvranching, Expranching, ExpcurrX, Expcap, Gold, DayX, NHour, QharvestX, Qfish, Qranch, Alc);

                    Input == 'w',
                        % Asumsi bergerak 1 tile memakan waktu 1 hour
                        % Asumsi pergerakan tidak valid tetap memakan waktu 1 hour
                        w_move,
                        add_hourv(Hour, HourX),
                        (
                            (HourX >= 24) ->
                                write('\nIt\'s a New Day!\n'),
                                add_dayv(Day, DayX),
                                HourY is 0,
                                mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, DayX, HourY, Qharvest, Qfish, Qranch, Alc)
                            ;mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, HourX, Qharvest, Qfish, Qranch, Alc)
                        );

                    Input == 'a',
                        % Asumsi bergerak 1 tile memakan waktu 1 hour
                        % Asumsi pergerakan tidak valid tetap memakan waktu 1 hour
                        a_move,
                        add_hourv(Hour, HourX),
                        (
                            (HourX >= 24) ->
                                write('\nIt\'s a New Day!\n'),
                                add_dayv(Day, DayX),
                                HourY is 0,
                                mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, DayX, HourY, Qharvest, Qfish, Qranch, Alc)
                            ;mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, HourX, Qharvest, Qfish, Qranch, Alc)
                        );

                    Input == 's',
                        % Asumsi bergerak 1 tile memakan waktu 1 hour
                        % Asumsi pergerakan tidak valid tetap memakan waktu 1 hour
                        s_move,
                        add_hourv(Hour, HourX),
                        (
                            (HourX >= 24) ->
                                write('\nIt\'s a New Day!\n'),
                                add_dayv(Day, DayX),
                                HourY is 0,
                                mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, DayX, HourY, Qharvest, Qfish, Qranch, Alc)
                            ;mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, HourX, Qharvest, Qfish, Qranch, Alc)
                        );

                    Input == 'd',
                        % Asumsi bergerak 1 tile memakan waktu 1 hour
                        % Asumsi pergerakan tidak valid tetap memakan waktu 1 hour
                        d_move,
                        add_hourv(Hour, HourX),
                        (
                            (HourX >= 24) ->
                                write('\nIt\'s a New Day!\n'),
                                add_dayv(Day, DayX),
                                HourY is 0,
                                mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, DayX, HourY, Qharvest, Qfish, Qranch, Alc)
                            ;mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, HourX, Qharvest, Qfish, Qranch, Alc)
                        );

                    /* Fungsi untuk membantu debug */
                    Input == 'addlv',
                        addlv(Lv, LvX),
                        mainLoop(Job, LvX, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'addlvfarming',
                        addlvfarmingv(Lvfarming, LvfarmingX),
                        mainLoop(Job, Lv, LvfarmingX, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'addexpfarming',
                        addexpfarmingv(Expfarming, ExpfarmingX),
                        mainLoop(Job, Lv, Lvfarming, ExpfarmingX, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'addlvfishing',
                        addlvfishingv(Lvfishing, LvfishingX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, LvfishingX, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'addexpfishing',
                        addexpfishingv(Expfishing, ExpfishingX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, ExpfishingX, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'addlvranching',
                        addlvranchingv(Lvranching, LvranchingX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, LvranchingX, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'addexpranching',
                        addexpranchingv(Expranching, ExpranchingX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, ExpranchingX, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    /* Sistem penambahan exp di bawah sudah menghandle kasus level up */
                    Input == 'addexpcurr',
                        addexpcurrv(Expcurr, ExpcurrX),
                        (
                            (ExpcurrX >= Expcap) ->
                                write('Level Up!\n'),
                                addlv(Lv, LvX),
                                addexpcapv(Expcap, ExpcapX),
                                mainLoop(Job, LvX, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, ExpcurrX, ExpcapX, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
                            ;mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, ExpcurrX, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
                        );

                    Input == 'addexpcap',
                        addexpcapv(Expcap, ExpcapX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, ExpcapX, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'addgold',
                        addgoldv(Gold, GoldX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, GoldX, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    /* Fungsi addHour telah menghandle kasus apabila melewati 1 hari */
                    Input == 'addHour',
                        add_hourv(Hour, HourX),
                        (
                            (HourX >= 24) ->
                                write('\nIt\'s a New Day!\n'),
                                add_dayv(Day, DayX),
                                HourY is 0,
                                mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, DayX, HourY, Qharvest, Qfish, Qranch, Alc)
                            ;mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, HourX, Qharvest, Qfish, Qranch, Alc)
                        );

                    Input == 'addDay',
                        add_dayv(Day, DayX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, DayX, Hour, Qharvest, Qfish, Qranch, Alc);

                    /* CHEAT */
                    Input == 'rich',
                        add_goldcheatv(Gold, GoldX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, GoldX, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'old',
                        add_daycheatv(Day, DayX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, DayX, Hour, Qharvest, Qfish, Qranch, Alc);

                    /* Fungsi hourpp telah menghandle kasus apabila melewati 1 hari */
                    Input == 'hourpp',
                        add_hourcheatv(Hour, HourX),
                        (
                            (HourX >= 24) ->
                                write('\nIt\'s a New Day!\n'),
                                add_dayv(Day, DayX),
                                HourY is (HourX-24),
                                mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, DayX, HourY, Qharvest, Qfish, Qranch, Alc)
                            ;mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, HourX, Qharvest, Qfish, Qranch, Alc)
                        );

                    Input == 'redQharvest',
                        redQharvest(Qharvest, QharvestX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, QharvestX, Qfish, Qranch, Alc);

                    Input == 'redQfish',
                        redQfish(Qfish, QfishX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, QfishX, Qranch, Alc);

                    Input == 'redQranch',
                        redQranch(Qranch, QranchX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, QranchX, Alc);

                    mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
                )
            ;write('Penagih hutang tiba di kebun anda dan anda langsung melunasi hutang anda!'), nl, nl,
            write(' _  _   __   ___  _  _  ___  ___  ____    ___  ____  __   ___ \n'),  
            write('( )( ) (  ) (  ,)( )( )(  _)/ __)(_  _)  / __)(_  _)(  ) (  ,) \n'), 
            write(' )__(  /__\\  )  \\ \\\\//  ) _)\\__ \\  )(    \\__ \\  )(  /__\\  )  \\\n'),
            write('(_)(_)(_)(_)(_)\\_)(__) (___)(___/ (__)   (___/ (__)(_)(_)(_)\\_)\n'), nl,
            write('                          by G01 K03'), nl, nl,
            write('\n               > > > CONGRATULATION YOU WIN! < < <\n')
        )
    ;write('Penagih hutang tiba di kebun dan mengambil alih kebun!'), nl, nl,
    write(' _  _   __   ___  _  _  ___  ___  ____    ___  ____  __   ___ \n'),  
    write('( )( ) (  ) (  ,)( )( )(  _)/ __)(_  _)  / __)(_  _)(  ) (  ,) \n'), 
    write(' )__(  /__\\  )  \\ \\\\//  ) _)\\__ \\  )(    \\__ \\  )(  /__\\  )  \\\n'),
    write('(_)(_)(_)(_)(_)\\_)(__) (___)(___/ (__)   (___/ (__)(_)(_)(_)\\_)\n'), nl,
    write('                          by G01 K03'), nl, nl, nl,
    write('\n                  > > > GAME OVER < < <\n').

startGame :-
    nl, nl, nl, nl, nl,
    nl, nl, nl, nl, nl,
    nl, nl, nl, nl, nl,
    nl, nl, nl, nl, nl,
    nl, nl, nl, nl, nl,
    write(' _  _   __   ___  _  _  ___  ___  ____    ___  ____  __   ___ \n'),  
    write('( )( ) (  ) (  ,)( )( )(  _)/ __)(_  _)  / __)(_  _)(  ) (  ,) \n'), 
    write(' )__(  /__\\  )  \\ \\\\//  ) _)\\__ \\  )(    \\__ \\  )(  /__\\  )  \\\n'),
    write('(_)(_)(_)(_)(_)\\_)(__) (___)(___/ (__)   (___/ (__)(_)(_)(_)\\_)\n'), nl,
    write('                          by G01 K03'), nl, nl, nl,
    write('                type \'start\' to start the game'),
    % write('>>> HARVEST STAR <<<'), nl,
    % write('1. start     : memulai permainan'), nl,
    % write('2. map       : menampilkan peta'), nl,
    % write('3. status    : menampilkan kondisi terkini'), nl,
    % write('4. w         : bergerak 1 langkah ke utara'), nl,
    % write('5. s         : bergerak 1 langkah ke selatan'), nl,
    % write('6. d         : bergerak 1 langkah ke timur'), nl,
    % write('7. a         : bergerak 1 langkah ke barat'), nl,
    % write('8. help      : menampilkan segala bantuan'), nl,
    nl, !.

exitGame :-
    nl, nl,
    write(' _  _   __   ___  _  _  ___  ___  ____    ___  ____  __   ___ \n'),  
    write('( )( ) (  ) (  ,)( )( )(  _)/ __)(_  _)  / __)(_  _)(  ) (  ,) \n'), 
    write(' )__(  /__\\  )  \\ \\\\//  ) _)\\__ \\  )(    \\__ \\  )(  /__\\  )  \\\n'),
    write('(_)(_)(_)(_)(_)\\_)(__) (___)(___/ (__)   (___/ (__)(_)(_)(_)\\_)\n'), nl,
    write('                          by G01 K03'), nl, nl,
    write('\n                    > > > GAME OVER < < <\n').

chooseJob(Job, Lvfarming, Lvfishing, Lvranching) :-
    nl,
    write('Welcome to Harvest Star, Choose your job'), nl,
    write('1. Fisherman'), nl,
    write('2. Farmer'), nl,
    write('3. Rancher\n> '),
    read(JobX), nl,
    (
        (JobX =:= 1) ->
            Job is JobX,
            % Advantage Role
            Lvfarming is 0,
            Lvfishing is 10,
            Lvranching is 0,
            insertEquipment(37, 1),
            write('You choose Fisherman, let\'s go!');

        (JobX =:= 2) ->
            Job is JobX,
            % Advantage Role
            Lvfarming is 10,
            Lvfishing is 0,
            Lvranching is 0,
            insertEquipment(36, 1),
            write('You choose Farmer, let\'s go!');

        (JobX =:= 3) ->
            Job is JobX,
            % Advantage Role
            Lvfarming is 0,
            Lvfishing is 0,
            Lvranching is 10,
            insertEquipment(38, 1),
            write('You choose Rancher, let\'s go!');

        write('Invalid Input'),
        chooseJob(Job, Lvfarming, Lvfishing, Lvranching)
    ).

status(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc) :-
    write('----------- STATUS -----------'), nl,
    write('Job              : '),
    (
        Job =:= 1,
            write('Fisherman\n');
        Job =:= 2,
            write('Farmer\n');
        Job =:= 3,
            write('Rancher\n')
    ),
    write('Level            : '), write(Lv), nl,
    write('Level farming    : '), write(Lvfarming), nl,
    write('Exp farming      : '), write(Expfarming), nl,
    write('Level fishing    : '), write(Lvfishing), nl,
    write('Exp fishing      : '), write(Expfishing), nl,
    write('Level ranching   : '), write(Lvranching), nl,
    write('Exp ranching     : '), write(Expranching), nl,
    write('Exp              : '), write(Expcurr), write(' / '), write(Expcap), nl,
    write('Gold             : '), write(Gold), nl, nl,
    write('------------ TIME ------------'), nl,
    write('Day              : '), write(Day), nl,
    write('Hour             : '), write(Hour), nl, nl,
    write('----------- QUEST ------------'), nl,
    (
        (Qharvest=:=0, Qfish=:=0, Qranch=:=0) ->
            write('You have done your quest, you can now claim the reward!');
        write('You have ongoing quest!')
    ),
    nl.