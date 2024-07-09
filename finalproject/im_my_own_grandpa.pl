/*
*   "I'm my own grandpa"
*   Tyler Filewich  tfilewic
*   CSE259 Final Project
*/


/*  FACTS  */

male(me).               % narrator
male(myfather).         % the narrator's father
male(bouncingbaby).     % the narrator and widow's baby boy
male(son).              % the father and redhair's son

female(widow).          % the widow
female(redhair).        % the widow's grown-up daughter

daughter(redhair, widow).    % This widow had a grown-up daughter Who had hair of red

son(me, myfather).           % My father

son(bouncingbaby, me).       % I soon became the father Of a bouncing baby boy

son(son, redhair).           % My father's wife then had a son


married(me, widow).         % I was married to a widow Who was pretty as can be
married(widow, me).

married(myfather, redhair). % My father fell in love with her And soon the two were wed
married(redhair, myfather).



/*  RULES  */

parent_of(P, C) :-
    daughter(C, P);			% daughter
    son(C, P);				% son
    married(P, P2),					
    	(daughter(C, P2);	% stepdaughter
    	son(C, P2)).	    % stepson

son_in_law(S, F) :- 
    male(S),
    parent_of(F, D),
    married(S, D).

daughter_of(D, P) :-
    female(D),
    parent_of(P, D).

mother_of(M, C) :-
    female(M),
    parent_of(M, C).

siblings(C1, C2):-
    parent_of(P, C1),
    parent_of(P, C2).

brother_in_law_of(B, P) :-
    male(B),
    (siblings(B, W),
    	married(P, W));     % wife's brother
    (siblings(P, W),
        married(B, W)).	    % sister's husband

uncle_of(U, N) :-
    male(U),
    parent_of(P, N),
    (siblings(P, U);		% a parent's brother
	siblings(P, A),			% a parent's brother-in-law
	married(A, U)).

brother_of(B, S) :-
    male(B),
    siblings(B, S).

stepmother_of(M, C) :-
    female(M),
    married(M, F),
    (daughter(C, F);
    	son(C, F)).

grandfather_of(G, C):-
    male(G),
    parent_of(G, P),
    parent_of(P, C).
    
grandchild_of(C, G) :-
    parent_of(P, C),
    parent_of(G, P).

grandmother_of(G, C):-
    female(G),
    parent_of(G, P),
    parent_of(P, C).

great_great_grandfather_of(G, C):-
	grandfather_of(G, M),
	grandchild_of(C, M).

/*  QUERIES  */

test :-											% proves the relationships described in the song
    son_in_law(myfather, me),                   % This made my dad my son-in-law
    daughter_of(redhair, me),                   % For my daughter 
    mother_of(redhair, me),                     %       was my mother 
    brother_in_law_of(bouncingbaby, myfather),  % This little baby then became a brother-in-law to Dad
    uncle_of(bouncingbaby, me),                 %   And so became my uncle
    brother_of(bouncingbaby, redhair),          %       that also made him brother Of the widow's grown-up daughter
    stepmother_of(redhair, me),                 %           Who of course is my step-mother
    grandfather_of(me, me),                     % Im my own grandpa
    grandchild_of(son, me),                     % My father's wife then had a son... And he became my grandchild
	grandmother_of(widow, me),                  % Because although she is my wife She's my grandmother too 
    !.  
    

test2:-											% proves supplementary relationships not described in the song									
	great_great_grandfather_of(me, me),			% I am my own great-great-grandfather
	brother_of(me, son),						% my daughter's son is my brother
	grandchild_of(bouncingbaby, redhair),		% my son is my daughter's grandchild
	siblings(bouncingbaby, redhair),			% my son and my mother in law are siblings
	!.