redQharvest(Qharvest, QharvestX) :-
    (Qharvest > 0) ->
        QharvestX is Qharvest-1
    ;QharvestX is 0.

redQfish(Qfish, QfishX) :-
    (Qfish > 0) ->
        QfishX is Qfish-1
    ;QfishX is 0.

redQranch(Qranch, QranchX) :-
    (Qranch > 0) ->
        QranchX is Qranch-1
    ;QranchX is 0.