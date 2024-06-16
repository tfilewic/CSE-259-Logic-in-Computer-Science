/*
 * Tyler Filewich  
 * tfilewic
 * CSE259 Project 1
 */


 /* prints N asterisks */
asterisk(N) :-
	N < 1; 				% base case
    N > 0,
	write('*'),
    asterisk(N-1).		% recursive call

 /* prints N spaces */
space(N) :-
	N < 1;				% base case
    N > 0,
	write(' '),
    space(N - 1).		% recursive call

 /* prints N underscores */
underscore(N) :-
	N < 1;				% base case
    N > 0,				
	write('_'),			
    underscore(N - 1).	% recursive call


/* prints a top/bottom margin */
margin(Width, Height):-
    Height < 1;					% base case
    (Height > 0,
    write('|'),		% left bounding box	
    space(Width),	% empty space
    write('|'),		% right bounding box
    nl,				% newline
    margin(Width, Height - 1)).	% recursive call
    
/* prints the top border and margin  */
top(Width, Height) :-
   underscore(Width + 2),	% bounding box top
   nl,						% newline
   margin(Width, Height).	% top margin

/* prints the bottom margin and border */
bottom(Width, Height) :-
	margin(Width, Height), 	% bottom margin
    underscore(Width + 2).	% bounding box bottom


/* prints a single line of the letter A */
a(Size, Level):-
    ((Level = 5 ; Level = 3), 							% Levels 5 and 3 are "***"
    asterisk(Size), asterisk(Size), asterisk(Size));
    ((Level = 4; Level = 2; Level = 1), 				% Levels 4, 2, 1 are "* *"
    asterisk(Size), space(Size), asterisk(Size)).

/* prints a single line of the letter S */
s(Size, Level):-
    ((Level = 5 ; Level = 3; Level = 1), 				% Levels 5, 3, 1 are "***"
    asterisk(Size), asterisk(Size), asterisk(Size));
    (Level = 4, 										% Level 4 is "*  "
    asterisk(Size), space(Size), space(Size));
    (Level = 2, 										% Level 2 is "  *"
    space(Size), space(Size), asterisk(Size)).

/* prints a single line of the letter U */
u(Size, Level):-
    ((Level = 5 ; Level = 4; Level = 3; Level = 2), 	% Levels 2-5 are "* *"
    asterisk(Size), space(Size), asterisk(Size));
    (Level = 1, 										% Level 1 is "***"
    asterisk(Size), asterisk(Size), asterisk(Size)).	

/* prints a single line of ASU separated by spaces, padded with margins and bounded by the box*/
level(_, Height, _, _, _):-
    Height < 1.  % base case

level(Width, Height, Level, LeftRightMargin, Spacing):-
    Height > 0,													% base case
    write('|'),					% left bounding box
    space(LeftRightMargin),		% left margin
    a(Width, Level),			% a
    space(Spacing),				% space
    s(Width, Level),			% s
    space(Spacing),				% space
    u(Width, Level),			% u
    space(LeftRightMargin),		% right margin
    write('|'),					% right bounding box
    nl,							% newline
    level(Width, Height - 1, Level, LeftRightMargin, Spacing).	% recursive call

/* prints the middle section with letters */
middle(FontSize, LeftRightMargin, SpaceBetweenCharacters):-
    level(FontSize, FontSize, 5, LeftRightMargin, SpaceBetweenCharacters),
    level(FontSize, FontSize, 4, LeftRightMargin, SpaceBetweenCharacters),
    level(FontSize, FontSize, 3, LeftRightMargin, SpaceBetweenCharacters),
    level(FontSize, FontSize, 2, LeftRightMargin, SpaceBetweenCharacters),
    level(FontSize, FontSize, 1, LeftRightMargin, SpaceBetweenCharacters).


/* main  -  exception handling for bad input*/
asu(LeftRightMargin, BottomTopMargin, SpaceBetweenCharacters, FontSize):-
    ((\+ integer(LeftRightMargin);          % must be an integer
    \+ integer(BottomTopMargin);            % must be an integer
    \+ integer(SpaceBetweenCharacters);     % must be an integer
    \+ integer(FontSize));                  % must be an integer
    (LeftRightMargin < 0;  			% left/right margins can not be negative
    BottomTopMargin < 0;			% top/bottom margins can not be negative
    SpaceBetweenCharacters < 0;		% character spacing can not be negative
    FontSize < 1)),					% font size must be at least 1
    write('invalid parameters'), 	% error message
    !.								% cut

/* main - draws the entire graphic */
asu(LeftRightMargin, BottomTopMargin, SpaceBetweenCharacters, FontSize) :-
    Width is 2 * LeftRightMargin + 2 * SpaceBetweenCharacters + 9 * FontSize, % total width in characters
    top(Width, BottomTopMargin),									% draw top			
    middle(FontSize, LeftRightMargin, SpaceBetweenCharacters),		% draw middle
    bottom(Width, BottomTopMargin).									% draw bottom	
