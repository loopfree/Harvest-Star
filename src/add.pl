addlv(Lv, LvX) :-
    LvX is Lv+1.

addlvfarmingv(Lvfarming, LvfarmingX) :-
    LvfarmingX is Lvfarming+1.

addexpfarmingv(Expfarming, ExpfarmingX) :-
    ExpfarmingX is Expfarming+20.

addlvfishingv(Lvfishing, LvfishingX) :-
    LvfishingX is Lvfishing+1.

addexpfishingv(Expfishing, ExpfishingX) :-
    ExpfishingX is Expfishing+20.

addlvranchingv(Lvranching, LvranchingX) :-
    LvranchingX is Lvranching+1.

addexpranchingv(Expranching, ExpranchingX) :-
    ExpranchingX is Expranching+20.

addexpcurrv(Expcurr, ExpcurrX) :-
    ExpcurrX is Expcurr+30.

addexpcapv(Expcap, ExpcapX) :-
    ExpcapX is 2*Expcap.

/* Note */
/* Untuk add gold boleh tambah fungsi sendiri mis addgoldquest, dll */
addgoldv(Gold, GoldX) :-
    GoldX is Gold+999.
/* End of Note */

addgoldquest(Gold, GoldX, Addition) :-
    GoldX is Gold+Addition.

add_hourv(Hour, HourX) :-
    HourX is Hour+1.

add_dayv(Day, DayX) :-
    DayX is Day+1.


/* DEBUG CHEAT */
add_goldcheatv(Gold, GoldX) :-
    GoldX is Gold + 50000.

add_daycheatv(Day, DayX) :-
    DayX is Day + 50.

add_hourcheatv(Hour, HourX) :-
    HourX is Hour + 5.