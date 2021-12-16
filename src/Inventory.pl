:-include('item.pl').

/* Deklarasi Fakta */
:-dynamic(inventory_item_list/1).
inventory_item_list([]).
% Contoh: inventory_item_list([[1, carrot, 10], [10, wheat_seed, 10], [11, melon_seed, 10], [2, potato, 10]]).

:-dynamic(inventory_equipment_list/1).
inventory_equipment_list([]).
% Contoh: inventory_equipment_list([[36, shovel, 3], [38, samurai, 1]]).

/* Deklarasi Rules */
/* Rules Utama */
% inventory.
% I.S. -
% F.S. Menampilkan seluruh Item dan Equipment pada layar
inventory :- 
    totalInventory(_N),
    write('Your inventory ('), write(_N), write(' / 100)\n'), !,
    displayInventory.

% throwItem.
% I.S. -
% F.S. Item terbuang dari inventory jika ada
throwItem :-
    inventory,
    totalInventory(_Z),
    (_Z == 0 -> 
        write('\nNothing to throw. Cancelling...\n'), fail;
        true),
    write('\nWhat do you want to throw?\n> '),
    read(_Throw),
    item(_ID, _Throw, _),
    (_ID >= 36, _ID =< 38 ->
        (searchEquipment(_ID, _Element, _) ->
            !, _Element = [_, _Throw, _Level],
            deleteEquipment(_ID),
            write('\nYou threw away 1 Level '), write(_Level), write(' '), write(_Throw), write('.\n');
            write('\nYou don\'t have '), write(_Throw), write('. Cancelling...\n')
        );
        searchItem(_ID, _Element, _), !,
        _Element = [_, _, _N],
        write('\nYou have '), write(_N), write(' '), write(_Throw), write('. How many do you want to throw?\n> '),
        read(_ThrowN),
        (_ThrowN > _N ->
            write('\nYou don\'t have enough'), write(_Throw), write('. Cancelling...\n');
            decreaseItem(_ID, _ThrowN),
            write('\nYou threw away '), write(_ThrowN), write(' '), write(_Throw), write('.\n')
        )
    ).

/* Rules Pembantu */
% totalEquipment (output N : integer).
% I.S. -
% F.S. N adalah banyaknya Equipment
totalEquipment(N) :-
    inventory_equipment_list(_X),
    totalEquipment(_X, N).
totalEquipment([], N) :- N is 0.
totalEquipment([_X | _Y], N) :-
    totalEquipment(_Y, Nn),
    N is Nn + 1.

% totalItem (output N : integer).
% I.S. -
% F.S. N adalah banyaknya Item
totalItem(N) :-
    inventory_item_list(_X),
    totalItem(_X, N).
totalItem([], N) :- N is 0.
totalItem([_X | _Y], N) :-
    totalItem(_Y, Nn),
    _X = [_, _, _Z],
    N is Nn + _Z.

% totalInventory (output N : integer).
% I.S. -
% F.S. N adalah banyaknya Item dan Equipment di inventory
totalInventory(N) :-
    totalEquipment(NE),
    totalItem(NI),
    N is NE + NI.

% displayInventory.
% I.S. -
% F.S. Menampilkan seluruh Item dan Equipment pada layar
displayInventory :-
    displayEquipment,
    displayItem.

% displayEquipment.
% I.S. -
% F.S. Menampilkan seluruh Equipment pada layar
displayEquipment :-
    inventory_equipment_list(_X),
    displayEquipment(_X).
displayEquipment([]).
displayEquipment([_X | _Y]) :-
    _X = [_A, _B, _C],
    write('1 Level '), write(_C), write(' '), write(_B), write('\n'),
    displayEquipment(_Y).

% displayItem. 
% I.S. -
% F.S. Menampilkan seluruh Item pada layar
displayItem :-
    inventory_item_list(_X),
    displayItem(_X).
displayItem([]).
displayItem([_X | _Y]) :-
    _X = [_A, _B, _C],
    write(_C), write(' '), write(_B), write('\n'),
    displayItem(_Y).

% displaySeed.
% I.S. -
% F.S. Menampilkan seluruh seed (Item ID 8 - 14) yang ada di inventory pada layar
displaySeed :-
    inventory_item_list(_X),
    displaySeed(_X).
displaySeed([]).
displaySeed([_X | _Y]) :-
    _X = [_A, _B, _C],
    (_A >= 8, _A =< 14 -> 
        write('- '), write(_C), write(' '), write(_B), write('\n');
        true
    ),
    displaySeed(_Y).

% insertItem (input _ID : integer, input _N : integer)
% I.S. _ID merupakan id item valid, _N terdefinisi
% F.S. Jika input masih dibawah kapasitas, item dimasukan atau kuantitas item ditambahkan,
%      Jika tidak, tidak melakukan apa apa
insertItem(_ID, _N) :-
    totalInventory(_NI),
    _Total is _NI + _N,
    _Total =< 100,
    item(_ID, Name, _),
    inventory_item_list(_ItemList),
    (searchItem(_ID, _Element, _Index) ->
        _Element = [_, _, NItem],
        NOutput is NItem + _N,
        deleteAt(_ItemList, _Index, _Temp),
        insertAt(_Temp, [_ID, Name, NOutput], _Index, Output);
        insertLast(_ItemList, [_ID, Name, _N], Output)
    ),
    retractall(inventory_item_list(_)),
    asserta(inventory_item_list(Output)).

% deleteItem (input _ID : integer)
% I.S. _ID merupakan id item valid
% F.S. item dengan id _ID terhapus dari list item
deleteItem(_ID) :-
    searchItem(_ID, _, _Index),
    inventory_item_list(_X),
    deleteAt(_X, _Index, Output),
    retractall(inventory_item_list(_)),
    asserta(inventory_item_list(Output)).

% decreaseItem (input _ID : integer, input _NDecrease : integer)
% I.S. _ID merupakan id item valid, _NDecrease terdefinis
% F.S. Mengurangkan Item sebanyak _NDecrease, deleteItem jika habis
decreaseItem(_ID, _NDecrease) :-
    searchItem(_ID, _Element, _Index),
    _Element = [_, _Name, _N],
    _NDecrease =< _N,
    (_NDecrease == _N ->
        deleteItem(_ID);
        inventory_item_list(_X),
        deleteAt(_X, _Index, _Temp),
        _NOutput is _N - _NDecrease,
        insertAt(_Temp, [_ID, _Name, _NOutput], _Index, Output),
        retractall(inventory_item_list(_)),
        asserta(inventory_item_list(Output))
    ).

% searchItem (input _ID : integer, output Element : [ID, Name, Quantity], output Index : integer)
% I.S. _ID merupakan id item valid
% F.S. Jika ditemukan, Elemen dan Index menjadi Elemen dan Index yang dicari
searchItem(_ID, Element, Index) :-
    inventory_item_list(_X),
    searchItem(_X, _ID, NElement, NIndex),
    Element = NElement,
    Index is NIndex.
searchItem([_X | _Y], _ID, Element, Index) :-
    _X = [_A, _B, _C],
    _ID =:= _A, !, 
    Element = _X,
    Index is 1.
searchItem([_X | _Y], _ID, Element, Index) :-
    searchItem(_Y, _ID, Element, NIndex),
    Index is NIndex + 1.

% insertEquipment (input _ID : integer, input _N : integer)
% I.S. _ID merupakan id equipment valid, _N terdefinisi
% F.S. Jika Equipment sudah ada pada inventory, menambahkan level Equipment sebanyak _N
%      Jika belum dan kapasitas inventory masih tercukupi, equipment ditambakan pada inventory dengan level _N
insertEquipment(_ID, _N) :-
    inventory_equipment_list(_EquipmentList),
    (searchEquipment(_ID, _Element, _Index) ->
        _Element = [_, Name, _Level],
        _LevelOutput is _Level + _N,
        deleteAt(_EquipmentList, _Index, _Temp),
        insertAt(_Temp, [_ID, Name, _LevelOutput], _Index, Output);
        totalInventory(_NI),
        _Total is _NI + 1,
        _Total =< 100,
        item(_ID, Name, _),
        insertLast(_EquipmentList, [_ID, Name, _N], Output)
    ),
    retractall(inventory_equipment_list(_)),
    asserta(inventory_equipment_list(Output)).

% deleteEquipment (input _ID : integer)
% I.S. _ID merupakan id equipment valid
% F.S. item dengan id _ID terhapus dari list equipment
deleteEquipment(_ID) :-
    searchEquipment(_ID, _, _Index),
    inventory_equipment_list(_X),
    deleteAt(_X, _Index, Output),
    retractall(inventory_equipment_list(_)),
    asserta(inventory_equipment_list(Output)).

% searchEquipment (input _ID : integer, output Element : [ID, Name, Level], output Index : integer)
% I.S. _ID merupakan id equipment valid 
% F.S. Jika ditemukan, Elemen dan Index menjadi Elemen dan Index yang dicari
searchEquipment(_ID, Element, Index) :-
    inventory_equipment_list(_X),
    searchEquipment(_X, _ID, NElement, NIndex),
    Element = NElement,
    Index is NIndex.
searchEquipment([_X | _Y], _ID, Element, Index) :-
    _X = [_A, _B, _C],
    _ID =:= _A, !, 
    Element = _X,
    Index is 1.
searchEquipment([_X | _Y], _ID, Element, Index) :-
    searchEquipment(_Y, _ID, Element, NIndex),
    Index is NIndex + 1.

% insertLast (input [_X | _Y] : List, input Item : Element List, output Output : List)
% I.S. [_X | _Y] terdefinisi
% F.S. Item dimasukkan di akhir [_X | _Y] menghasilkan Output
insertLast([], Item, [Item]).
insertLast([_X | _Y], Item, [_X | L]) :- insertLast(_Y, Item, L).

% insertAt (input [_X | _Y] : List, input Item : Element List, input Index : integer, output Output : List)
% I.S. [_X | _Y] terdefinisi
% F.S. Item dimasukkan di index Index pada [_X | _Y] menghasilkan Output
insertAt(Xs, Element, 1, [Element | Xs]) :- !.
insertAt([X | Xs], Element, Position, [X | Result]) :- 
    PositionN is Position - 1, 
    insertAt(Xs, Element, PositionN, Result).

% deleteAt (input [_X | _Y] : List, input Index : integer, output Output : List)
% I.S. [_X | _Y] terdefinisi
% F.S. Item dengan index Index dihapuskan pada [_X | _Y] menghasilkan Output
deleteAt([_ | Xs], 1, Xs) :- !.
deleteAt([X | Xs], Position, [X | Result]) :- 
    PositionN is Position - 1, 
    deleteAt(Xs, PositionN, Result).