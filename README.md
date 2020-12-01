# Advent of Code in Prolog

## How to run

Get [SWI-Prolog](https://swi-prolog.org/) from your favorite package manager.
The version I'm using is 8.2.2, which is available in Debian repos as
`swi-prolog`.

## Inputs

Sign up to [Advent of Code](https://adventofcode.com/) to get puzzle inputs.

## Running

SWI-Prolog programs are not run directly. Open up a terminal and start `prolog`,
then:

```prolog
?- [code].
true.

?- start.
% ...
```

Note that an `input.txt` file (that day's input) needs to be present in the
working folder.

If you really want to, however, you can run the file directly (I would recommend
against it because the Prolog shell is what makes it great):

```shell
$ prolog -q -t start code.pl
```

This runs Prolog in quiet (`-q`) mode with the toplevel goal `start` (`-t`)
from code.pl.

## Copyright

&copy; 2020 The 1000x Engineer. This project is licensed under the GNU General
Public License, version 3.
