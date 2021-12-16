:-dynamic(factTes/3).
factTes(a1, b1, c1).
factTes(a2, b2, c2).
factTes(a3, b3, c3).
factTes(a4, b4, c4).
factTes(a5, b5, c5).

% note: param 2 append
% ?- append([1,2],[a,b],X).
% X = [1, 2, a, b].

%test(Ans) :-
%    X = [],
%    Ans = [],
%    forall(factTes(Param1, Param2, Param3), append(X, [Param1, Param2, Param3], Ans)),
%    write(Ans).


:-dynamic(x/1).
x([]).

test2 :-
    (factTes(Param1, Param2, Param3) ->
        !,
        retract(factTes(Param1, Param2, Param3)),
        x(_B),
        Y = [Param1, Param2, Param3],
        append(_B, [Y], A),
        retractall(x(_)),
        asserta(x(A)),
        test2;
        true
    ).

test3 :- 
    test2,
    x(_X), 
    write(_X). 