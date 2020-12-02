% -*- mode: prolog -*-

start :-
    read_input(Input),
    !,
    part1(Input, 0, Valid1),
    format("Part 1 = ~d~n", [Valid1]),
    part2(Input, 0, Valid2),
    format("Part 2 = ~d~n", [Valid2]).

read_input(Input) :-
    % Read input.txt into a string.
    read_file_to_string("input.txt", Data, []),
    % Split it into lines.
    split_string(Data, "\n", "\n", Lines),
    % Read it into password structures.
    read_passwords(Lines, [], Input).

read_passwords([], Input, Input).
read_passwords([Line|Rest], Passwords, Input) :-
    % Split the string into segments.
    split_string(Line, " ", "", [MinMax, Char_, Pwd]),
    % Split the min-max chars.
    split_string(MinMax, "-", "", [Min, Max]),
    % Trim off the :.
    sub_string(Char_, 0, 1, _, Char),
    % Do the type conversions.
    number_string(MinNum, Min),
    number_string(MaxNum, Max),
    atom_string(CharAtom, Char),
    % Add it to the list.
    Password = password(MinNum, MaxNum, CharAtom, Pwd),
    read_passwords(Rest, [Password|Passwords], Input).


% count_chars counts in a list of chars (atoms) how many of a given
% character exists.
count_chars(Chars, Char, Count) :-
    count_chars(Chars, Char, 0, Count),
    !.
count_chars([], _, Count, Count) :- !.
count_chars([Char|Rest], Char, Acc, Count) :-
    Acc1 is Acc + 1,
    count_chars(Rest, Char, Acc1, Count).
count_chars([_|Rest], Char, Acc, Count) :-
    count_chars(Rest, Char, Acc, Count).

% part1 solves the first part of the puzzle.
part1([], Valid, Valid) :- !.
part1([Password|Rest], Acc, Valid) :-
    % Get the password.
    Password = password(Min, Max, Char, Pwd),
    string_chars(Pwd, PwdChars),
    count_chars(PwdChars, Char, Count),

    % Check (inclusive) whether the occurences of Char is within Min or Max.
    Count >= Min,
    Count =< Max,
    Acc1 is Acc + 1,
    part1(Rest, Acc1, Valid),
    !
    ;
    part1(Rest, Acc, Valid).
    
% part2 solves the second part of the puzzle.
part2([], Valid, Valid) :- !.
part2([Password|Rest], Acc, Valid) :-
    Password = password(Min, Max, Char, Pwd),
    string_chars(Pwd, PwdChars),

    % Since this part depends on only _one_ of the two predicates
    % being true, we can use xor.
    (
        nth1(Min, PwdChars, Char) ->
        MinMatch = 1; MinMatch = 0
    ),
    (
        nth1(Max, PwdChars, Char) ->
        MaxMatch = 1; MaxMatch = 0
    ),
    Matched is MinMatch xor MaxMatch,
    Matched = 1,

    Acc1 is Acc + 1,
    part2(Rest, Acc1, Valid),
    !
    ;
    part2(Rest, Acc, Valid).
