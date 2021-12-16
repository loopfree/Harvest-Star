% season_name([weather_list])
spring([sunny, sunny, sunny, sunny, sunny, sunny, sunny, rain, rain, rain]).    % Day   1 -  91
summer([sunny, sunny, sunny, sunny, sunny, sunny, sunny, rain, rain, typhoon]). % Day  92 - 183
autumn([sunny, sunny, sunny, sunny, sunny, sunny, sunny, sunny, rain, rain]).   % Day 184 - 275
winter([sunny, sunny, sunny, sunny, sunny, snow, snow, snow, snow, heavy_snow]).% Day 276 - 365

% season(DAY, SEASON):-
%     (
%         DAY < 331,
%             SEASON is 'kemarau';
%         SEASON is 'hujan'
%     ).

% seasonAndWeather (input _Day : integer, output _Season : string, output _Weather : string)
% I.S. _Day terdefinisi dan valid
% F.S. _Season dan _Weather terdefinisi
seasonAndWeather(_Day, _Season, _Weather) :-
    random(1, 10, Rand),
    (_Day =< 91 ->
        !, _Season = 'spring',
        spring(_X),
        getElementAt(_X, Rand, _Weather);
    _Day =< 183 ->
        !, _Season = 'summer',
        summer(_X),
        getElementAt(_X, Rand, _Weather);
    _Day =< 275 ->
        !, _Season = 'autumn',
        autumn(_X),
        getElementAt(_X, Rand, _Weather);
    _Day =< 365 ->
        !, _Season = 'winter',
        winter(_X),
        getElementAt(_X, Rand, _Weather)
    ).

% getElementAt (input [_X | _Y] : List of string, input N : integer, output Element : string)
% I.S. [_X | _Y] dan N terdefinisi
% F.S. Element menjadi elemen dengan indeks ke N pada [_X | _Y]
getElementAt([_X | _Y], 1, Element) :- !, Element = _X.
getElementAt([_X | _Y], N, Element) :- 
    Nn is N - 1,
    getElementAt(_Y, Nn, Element).