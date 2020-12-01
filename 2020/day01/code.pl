
start :-
    read_input(Input),
    !,
    find_summing_entries(Input, A, B),
    find_summing_entries2(Input, C, D, E),
    Result is A * B,
    Result2 is C * D * E,
    format("Two numbers: ~p ~p Result: ~p~n", [A, B, Result]),
    format("Three numbers: ~p ~p ~p Result: ~p~n", [C, D, E, Result2]).

read_input(Input) :-
    read_file_to_string("input.txt", String, []),
    split_string(String, "\n", "\n", Strings),
    read_input(Strings, [], Input).

read_input([], Input, Input).
read_input([Num|Rest], Numbers, Input) :-
    number_string(Number, Num),
    append(Numbers, [Number], Numbers1),
    read_input(Rest, Numbers1, Input).

find_summing_entries([], _, _) :- !.
find_summing_entries([First|Rest], A, B) :-
    find_summing_entries(First, Rest, A, B),
    find_summing_entries(Rest, A, B).

find_summing_entries(_, [], _, _) :- !.
find_summing_entries(First, [Second|Rest], A, B) :-
    Result is First + Second,
    Result = 2020,
    !,
    A = First,
    B = Second
    ;
    find_summing_entries(First, Rest, A, B).

find_summing_entries2([], _, _, _) :- !.
find_summing_entries2([First|Rest], A, B, C) :-
    find_summing_entries2(First, Rest, A, B, C),
    find_summing_entries2(Rest, A, B, C).

find_summing_entries2(_, [], _, _, _) :- !.
find_summing_entries2(First, [Second|Rest], A, B, C) :-
    find_summing_entries2(First, Second, Rest, A, B, C),
    find_summing_entries2(First, Rest, A, B, C).

find_summing_entries2(_, _, [], _, _, _) :- !.
find_summing_entries2(First, Second, [Third|Rest], A, B, C) :-
    Result is First + Second + Third,
    Result = 2020,
    !,
    A = First,
    B = Second,
    C = Third
    ;
    find_summing_entries2(First, Second, Rest, A, B, C).
