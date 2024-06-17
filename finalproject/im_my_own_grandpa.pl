/*
*   "I'm my own grandpa"
*   Tyler Filewich  tfilewic
*   CSE259 Final Project
*/

male(me).               % narrator
male(myfather).         % the narrator's father
male(bouncingbaby).     % the narrator and widow's baby boy
male(son).              % the father and redhair's son

female(widow).          % the widow
female(redhair).        % the widow's grown-up daughter

daughter_of(redhair, widow).    % This widow had a grown-up daughter Who had hair of red

son_of(me, myfather).           % My father

son_of(bouncingbaby, me).       % I soon became the father Of a bouncing baby boy

son_of(son, redhair).           % My father's wife then had a son


married(me, widow).         % I was married to a widow Who was pretty as can be
married(widow, me).

married(myfather, redhair). % My father fell in love with her And soon the two were wed
married(redhair, myfather).



parent_of(P, C) :-
    daughter_of(C, P);			% daughter
    son_of(C, P);				% son
    married(P, P2),					
    	(daughter_of(C, P2);	% stepdaughter
    	son_of(C, P2)).			% stepson

son_in_law(F, S) :- 
    parent_of(F, D),
    married(S, D).

mother_of(M, C) :-
    female(M),
    parent_of(M, C).

siblings(C1, C2):-
    parent_of(P, C1),
    parent_of(P, C2).

brother_in_law(B, P) :-
    male(B),
    (siblings(B, W),
    	married(P, W)); % P's wife's brother
    (siblings(P, W),
        married(B, W)).	% P's sister's husband

uncle_of(U, N) :-
    male(U),
    parent_of(P, N),
    siblings(P, U).

brother(B, S) :-
    male(B),
    siblings(B, S).

stepmother_of(M, C) :-
    female(M),
    married(M, F),
    (daughter_of(C, F);
    	son_of(C, F)).

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


test :-
    son_in_law(me, myfather),                   % This made my dad my son-in-law
    mother_of(redhair, me),                     % my daughter was my mother
    brother_in_law(myfather, bouncingbaby),     % This little baby then became a brother-in-law to Dad
    uncle_of(bouncingbaby, me),                 %   And so became my uncle
    brother(bouncingbaby, redhair),             %   that also made him brother Of the widow's grown-up daughter
    stepmother_of(redhair, me),                 %       Who of course is my step-mother
    grandfather_of(me, me),                     % Im my own grandpa
    grandchild_of(son, me),                     % My father's wife then had a son... And he became my grandchild
	grandmother_of(widow, me),                  % Because although she is my wife She's my grandmother too 
    !.  
    
