/*
 * Tyler Filewich  
 * tfilewic
 * CSE259 Project 1
 */


 /* prints N asterisks */
asterisk(N) :-
	N < 1; 
    N > 0,
	write('*'),
    asterisk(N-1).

 /* prints N spaces */
space(N) :-
	N < 1;
    N > 0,
	write(' '),
    space(N - 1).

 /* prints N underscores */
underscore(N) :-
	N < 1;
    N > 0,
	write('_'),
    underscore(N - 1).

/* prints a top/bottom margin */
margin(Width, Height):-
    Height < 1;
    (Height > 0,
    write('|'),
    space(Width),
    write('|'),
    nl,
    margin(Width, Height - 1)).
    
/* prints the top border and margin  */
top(Width, Height) :-
   underscore(Width + 2),
   nl,
   margin(Width, Height).

/* prints the bottom margin and border */
bottom(Width, Height) :-
	margin(Width, Height),
    underscore(Width + 2).


/* prints a single line of the letter A */
a(Size, Level):-
    Level = 0;
    ((Level = 5 ; Level = 3), 
    asterisk(Size), asterisk(Size), asterisk(Size));
    ((Level = 4; Level = 2; Level = 1), 
    asterisk(Size), space(Size), asterisk(Size)).

/* prints a single line of the letter S */
s(Size, Level):-
    Level = 0;
    ((Level = 5 ; Level = 3; Level = 1), 
    asterisk(Size), asterisk(Size), asterisk(Size));
    (Level = 4, 
    asterisk(Size), space(Size), space(Size));
    (Level = 2, 
    space(Size), space(Size), asterisk(Size)).

/* prints a single line of the letter U */
u(Size, Level):-
    Level = 0;
    ((Level = 5 ; Level = 4; Level = 3; Level = 2), 
    asterisk(Size), space(Size), asterisk(Size));
    (Level = 1, 
    asterisk(Size), asterisk(Size), asterisk(Size)).


/* prints a single line of ASU separated by spaces, padded with margins and bounded by the box*/
level(_, Height, _, _, _):-
    Height < 1.

level(Width, Height, Level, LeftRightMargin, Spacing):-
    Height > 0,
    write('|'),
    space(LeftRightMargin),
    a(Width, Level),
    space(Spacing),
    s(Width, Level),
    space(Spacing),
    u(Width, Level),
    space(LeftRightMargin),
    write('|'),
    nl,
    level(Width, Height - 1, Level, LeftRightMargin, Spacing).


/* prints the letters */
middle(FontSize, LeftRightMargin, SpaceBetweenCharacters):-
    level(FontSize, FontSize, 5, LeftRightMargin, SpaceBetweenCharacters),
    level(FontSize, FontSize, 4, LeftRightMargin, SpaceBetweenCharacters),
    level(FontSize, FontSize, 3, LeftRightMargin, SpaceBetweenCharacters),
    level(FontSize, FontSize, 2, LeftRightMargin, SpaceBetweenCharacters),
    level(FontSize, FontSize, 1, LeftRightMargin, SpaceBetweenCharacters).


/* main  -  exception handling for bad input*/
asu(LeftRightMargin, BottomTopMargin, SpaceBetweenCharacters, FontSize):-
    (LeftRightMargin < 0;
    BottomTopMargin < 0;
    SpaceBetweenCharacters < 0;
    FontSize < 1),
    write('invalid parameters'), 
    !.

/* main */
asu(LeftRightMargin, BottomTopMargin, SpaceBetweenCharacters, FontSize) :-
    Width is 2 * LeftRightMargin + 2 * SpaceBetweenCharacters + 9 * FontSize,
    top(Width, BottomTopMargin),
    middle(FontSize, LeftRightMargin, SpaceBetweenCharacters),
    bottom(Width, BottomTopMargin).
