
% Run the day's program.
start :-
    read_input(Input),
    find_sums(Input, 2, 2020, [A, B]),
    find_sums(Input, 3, 2020, [C, D, E]),
    !,
    Result is A * B,
    Result2 is C * D * E,
    format("Two numbers: ~p ~p Result: ~p~n", [A, B, Result]),
    format("Three numbers: ~p ~p ~p Result: ~p~n", [C, D, E, Result2]).

% Read the file into a string and unify Input to a list of numbers.
read_input(Input) :-
    read_file_to_string("input.txt", String, []),
    split_string(String, "\n", "\n", Strings),
    read_input(Strings, [], Input).

% Unify each string Num to a number Number and add it to Input.
read_input([], Input, Input).
read_input([Num|Rest], Numbers, Input) :-
    number_string(Number, Num),
    append(Numbers, [Number], Numbers1),
    read_input(Rest, Numbers1, Input).


% find_sums finds Count numbers with a sum Sum in List.

% Base condition, empty list = cut
find_sums([], _, _, _) :- !.
% Special case for Count = 1 where we just find the number.
find_sums([First|_], 1, First, [First]).
find_sums([_|Rest], 1, Sum, Outputs) :-
    find_sums(Rest, 1, Sum, Outputs).
% General case, recurse to find the other numbers.
find_sums([Num|Rest], Count, Sum, Outputs) :-
    % Check Count for sanity
    Count >= 2,

    % Calculate remaining amount
    Remainder is Sum - Num,
    Count1 is Count - 1,

    % Find the rest of the numbers
    find_sums(Rest, Count1, Remainder, Out1),

    sum_list(Out1, Sum1),
    (
        % If the list of the sum is the remainder, then we unify Outputs
        % with the new number.
        Sum1 = Remainder,
        Outputs = [Num|Out1]
        ;
        % Otherwise, just continue on.
        find_sums(Rest, Count, Sum, Outputs)
    ).
