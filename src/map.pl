%Bentuk map awal, beserta isinya
:- dynamic((trueMap/1)).

/* Map Info */
:- dynamic(player_position/2).
:- dynamic(quest_position/2).
:- dynamic(ranch_position/2).
:- dynamic(house_position/2).
:- dynamic(market_position/2).

map_init([
[#,#,#,#,#,#,#,#,#,#,#,#,#,#,#,#],
[#,-,-,-,-,-,-,-,-,-,-,-,-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,-,-,-,-,-,#],
[#,-,-,-,-,-,-,'Q',-,-,-,-,-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,-,-,-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,'R',-,-,-,-,#],
[#,-,-,-,-,-,-,'H',-,-,-,-,-,-,-,#],
[#,-,-,-,-,-,-,-,'P',-,-,-,-,-,-,#],
[#,-,-,-,-,'o','o','o',-,-,-,-,-,-,-,#],
[#,-,-,-,'o','o','o','o','o',-,-,-,-,-,-,#],
[#,-,-,-,-,'o','o','o',-,-,-,-,-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,-,-,-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,'M',-,-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,-,-,-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,-,-,-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,-,-,-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,-,-,-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,-,-,-,-,-,#],
[#,#,#,#,#,#,#,#,#,#,#,#,#,#,#,#]
]).

/* Check Player Location */
checkPosition :-
   /* Global Variables */
   player_position(XPlayer, YPlayer),
   quest_position(XQuest, YQuest),
   ranch_position(XRanch, YRanch),
   house_position(XHouse, YHouse),
   market_position(XMarket, YMarket).

encounterInMap :-
   /* Global Variables */
   player_position(XPlayer, YPlayer),
   quest_position(XQuest, YQuest),
   ranch_position(XRanch, YRanch),
   house_position(XHouse, YHouse),
   market_position(XMarket, YMarket).

initiate_true_map :-
   map_init(M),
   asserta(player_position(8, 7) ),
   asserta(quest_position(7, 3) ),
   asserta(ranch_position(10,5) ),
   asserta(house_position(7, 6) ),
   asserta(market_position(10, 12) ), 
   asserta(trueMap(M)), !. 

/* Update Map */
updateMap :-
   /* Getting the global variables */
   trueMap(MapNow),
   player_position(XPlayer, YPlayer),
   quest_position(XQuest, YQuest),
   ranch_position(XRanch, YRanch),
   house_position(XHouse, YHouse),
   market_position(XMarket, YMarket),
    
   checkPosition,

   matrix(MapNow, I, J, 'P'),
   replaceMatrix(MapNow, I, J, '-', MapChanged),
   replaceMatrix(MapChanged, YQuest, XQuest, 'Q', Matrix1),
   replaceMatrix(Matrix1, YRanch, XRanch, 'R', Matrix2),
   replaceMatrix(Matrix2, YHouse, XHouse, 'H', Matrix3),
   replaceMatrix(Matrix3, YMarket, XMarket, 'M', Matrix4),
   replaceMatrix(Matrix4, YPlayer, XPlayer, 'P', NewerMatrix),
    
   retract(trueMap(_) ),
   asserta(trueMap(NewerMatrix) ),
   kalibrasiMap.

replaceList( [_ | Tail], 0, X, [X | Tail] ).
replaceList( [Head | Tail], J, X, [Head | Replaced] ):- J > -1, NewJ is J-1, replaceList(Tail, NewJ, X, Replaced), !.
replaceList(Row, _, _, Row).

replaceMatrix(Matrix, I, J, NewValue, Result) :-
   findall(Value, matrix(Matrix, I, _, Value), Row),
   replaceList(Row, J, NewValue, ResRow),
   replaceList(Matrix, I, ResRow, Result), !.

matrix(Matrix, I, J, Value) :-
   nth0(I, Matrix, Row),
   nth0(J, Row, Value).

true_map :-
   trueMap(M),
   print_matrix(M).

%Melakukan print matrix
print_row([]).
print_row([X|Y]) :- write(X),print_row(Y).
print_matrix([]).
print_matrix([Y|Z]) :- print_row(Y), nl, print_matrix(Z).

%Menhasilkan elem yang ada pada list pada hitungan tertentu
find_row([_|List],N,Out) :-
    N1 is N - 1,
    find_row(List,N1,Out).
find_row([Element|_],0,Element).

%Menhasilkan elem yang ada pada koordinat tertentu di matriks
% find_matrikx(M,X,Y,Out)
% M matriks
% X,Y koordinat
% Out karakter di koordinat itu
find_matrix([_|List],N1,N2,Out) :-
   N2_2 is N2 - 1,
   find_matrix(List,N1,N2_2,Out).
find_matrix([Row|_],N1,0,Out) :-
   find_row(Row, N1, Out).

%Menhasilkan elem yang ada pada koordinat tertentu di map
%X, Y koordinat
%L Hasil
elmt_in_matrix(X,Y,L) :-    
   trueMap(M),
   find_matrix(M,X,Y,L).

%Mencari elemen tertentu pada list (hanya bisa jika elemen nya unik(hanya ada satu))
scan_row([],_,_,-1).
scan_row([Head|_],Head,N,N).
scan_row([Head|List],X,N,Out) :-
   (  Head == X 
      -> Out is N
      ; N1 is N+1,scan_row(List,X,N1,Out)
   ).

%Mencari elemen tertentu pada matriks (hanya bisa jika elemen nya unik(hanya ada satu))
% scan_matrix(M,C,N,Out1,Out2)
% M matriks
% C karakter yang ingin dicari
% N dibiarin 0
% Out1,Out2 koordinat
scan_matrix([],_,_,-1,-1).
scan_matrix([Head|List],X,N,Out1,Out2) :- 
   scan_row(Head,X,0,OutR),
   (
      OutR == -1
      -> N1 is N+1,scan_matrix(List,X,N1,Out1,Out2)
      ;Out1 is OutR, Out2 is N
   ).

%Mencari lokasi P(player) di matriks map
%input dummy(tidak dipakai)
%X, Y hasil koordinat
scan_player(_,X,Y) :-
   trueMap(M),
   scan_matrix(M,'P',0,Out1,Out2),
   X is Out1, Y is Out2.

%Menggantikan elemen di koordinat tertentu dengan suatu elemen lain
%L matriks masukan
%X, Y koordinat
%Z elemen yg akan mengganitkan
%R matriks keluaran
replace(L, X, Y, Z, R) :-
   append(RowPfx,[Row|RowSfx],L),
   length(RowPfx,Y),               
   append(ColPfx,[_|ColSfx],Row),  
   length(ColPfx,X),         
   append(ColPfx,[Z|ColSfx],RowNew), 
   append(RowPfx,[RowNew|RowSfx],R).

%mengecek apakah karakter sama dengan border atau air
valid(Char,Out) :-
   (
      (Char == '#')
      -> Out is 2
      ; (Char == 'o')
      -> Out is 1
      ;Out is 0
   ).

%Mengecek apakah jika kita bergerak, valid atau tidak(West)
validW(X,Y,Out2) :-
   X1 is X - 1,
   elmt_in_matrix(X1,Y,Char),
   valid(Char,Out),
   Out2 is Out.

%Mengecek apakah jika kita bergerak, valid atau tidak(East)
validE(X,Y,Out2) :-
   X1 is X + 1,
   elmt_in_matrix(X1,Y,Char),
   valid(Char,Out),
   Out2 is Out.

%Mengecek apakah jika kita bergerak, valid atau tidak(North)
validN(X,Y,Out2) :-
   Y1 is Y - 1,
   elmt_in_matrix(X,Y1,Char),
   valid(Char,Out),
   Out2 is Out.

%Mengecek apakah jika kita bergerak, valid atau tidak(South)
validS(X,Y,Out2) :-
   Y1 is Y + 1,
   elmt_in_matrix(X,Y1,Char),
   valid(Char,Out),
   Out2 is Out.

%Melakukan perpindahan P(player) dengan arah yang ditentukan(West)
moveW(M, X, Y) :-
   X1 is X - 1,
   retract(player_position(_, _) ),
   asserta(player_position(X1, Y) ),
   updateMap,
   write('Anda bergerak ke arah barat.'),nl,nl.

%Melakukan perpindahan P(player) dengan arah yang ditentukan(East)
moveE(M, X, Y) :-
   X1 is X + 1,
   retract(player_position(_, _) ),
   asserta(player_position(X1, Y) ),
   updateMap,
   write('Anda bergerak ke arah timur.'),nl,nl.

%Melakukan perpindahan P(player) dengan arah yang ditentukan(North)
moveN(M, X, Y) :-
   Y1 is Y - 1,
   retract(player_position(_, _) ),
   asserta(player_position(X, Y1) ),
   updateMap,
   write('Anda bergerak ke arah utara.'),nl,nl.

%Melakukan perpindahan P(player) dengan arah yang ditentukan(South)
moveS(M, X, Y) :-
   Y1 is Y + 1,
   retract(player_position(_, _) ),
   asserta(player_position(X, Y1) ),
   updateMap,
   write('Anda bergerak ke arah selatan.'),nl,nl.

%Memanggil fungsi map untuk langsung mengeprint matrix map
map :-    
   trueMap(M),
   print_matrix(M).

%Melakukan move dan mengecek validitas
a_move :- 
   scan_player(_,X,Y),
   validW(X,Y,Out),
   (
      (Out == 2)
      -> write('Tidak bisa keluar dari batas!'), nl, !
      ; (Out == 1)
      -> write('Tidak bisa masuk ke air!'), nl, !
      ; trueMap(M),moveW(M, X, Y), updateMap, map, !
   ).

%Melakukan move dan mengecek validitas
d_move :- 
   scan_player(_,X,Y),
   validE(X,Y,Out),
   (
      (Out == 2)
      -> write('Tidak bisa keluar dari batas!'), nl, !
      ; (Out == 1)
      -> write('Tidak bisa masuk ke air!'), nl, !
      ; trueMap(M),moveE(M, X, Y), updateMap, map, !
   ).

%Melakukan move dan mengecek validitas
w_move :- 
   scan_player(_,X,Y),
   validN(X,Y,Out),
   (
      (Out == 2)
      -> write('Tidak bisa keluar dari batas!'), nl, !
      ; (Out == 1)
      -> write('Tidak bisa masuk ke air!'), nl, !
      ; trueMap(M),moveN(M, X, Y), updateMap, map, !
   ).

%Melakukan move dan mengecek validitas
s_move :- 
   scan_player(_,X,Y),
   validS(X,Y,Out),
   (
      (Out == 2)
      -> write('Tidak bisa keluar dari batas!'),nl, !
      ; (Out == 1)
      -> write('Tidak bisa masuk ke air!'),nl, !
      ; trueMap(M),moveS(M, X, Y), updateMap, map, !
   ).

moveBrute(DestX, DestY) :-
   X1 is DestX,
   Y1 is DestY,
   retract(player_position(_, _) ),
   asserta(player_position(X1, Y1) ),
   updateMap.