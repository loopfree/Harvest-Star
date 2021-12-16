/* Asumsi:  */
/* Baris pertama pasti harvest item */
/* Baris kedua pasti fish */
/* Baris ketiga pasti ranch item */

quest(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc) :-
    write('Welcome To Quest\n'),
    (Qharvest=:=0, Qfish=:=0, Qranch=:=0) ->
        (
            Lvl is Lv+1,

            write('Quest Finish\n'),
            random(1, Lvl, Reward),
            RewardX is Reward*100,
            write('You gain '),
            write(RewardX),
            write(' Gold\n'),

            addgoldquest(Gold, GoldX, RewardX),
            
            random(1, Lvl, Harvest_quest),
            random(1, Lvl, Fish_quest),
            random(1, Lvl, Ranch_quest),

            write('You get a new quest\n'),
            write('You need to collect:'), nl,
            write('- '), write(Harvest_quest), write(' harvest item'), nl,
            write('- '), write(Fish_quest), write(' fish'), nl,
            write('- '), write(Ranch_quest), write(' ranch item'), nl,
            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, GoldX, Day, Hour, Harvest_quest, Fish_quest, Ranch_quest, Alc)
        )
    ;write('Ongoing quest\n'),
    write('You need to collect:'), nl,
    write('- '), write(Qharvest), write(' harvest item'), nl,
    write('- '), write(Qfish), write(' fish'), nl,
    write('- '), write(Qranch), write(' ranch item'), nl,
    nl.