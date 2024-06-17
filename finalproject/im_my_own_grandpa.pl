/*
*   "I am my own grandpa"
*   Tyler Filewich  tfilewic
*   CSE259 Final Project
*/




 /* Oh, many, many years ago
    When I was twenty-three
    I was married to a widow
    Who was pretty as can be
    */

male(me).
male(myfather).
male(bouncingbaby).
male(son).

female(widow).
female(redhair).

married(me, widow).
married(widow, me).

married(myfather, redhair).
married(redhair, myfather).


daughter_of(redhair, widow).


son_of(me, myfather).

son_of(bouncingbaby, me).
son_of(bouncingbaby, widow).

son_of(son, redhair).
son_of(son, myfather).

/*  This widow had a grown-up daughter
    Who had hair of red */



/*    My father fell in love with her
    And soon the two were wed */


/*	This made my dad my son-in-law
    And changed my very life */

parent_of(P, C) :-
    daughter_of(C, P);			% daughter
    son_of(C, P);				% son
    married(P, P2),					
    	(daughter_of(C, P2);	% stepdaughter
    	son_of(C, P2)).			% stepson

son_in_law(F, S) :- 
    parent_of(F, D),
    married(S, D).



/*	For my daughter was my mother
    'Cause she was my father's wife*/
mother_of(M, C) :-
    female(M),
    parent_of(M, C).


/*  To complicate the matter
    Though it really brought me joy
    I soon became the father
    Of a bouncing baby boy */



/* 	This little baby then became
    A brother-in-law to Dad*/
siblings(C1, C2):-
    parent_of(P, C1),
    parent_of(P, C2).

brother_in_law(B, P) :-
    male(B),
    (siblings(B, W),
    	married(P, W)); % P's wife's brother
    (siblings(P, W),
        married(B, W)).	% P's sister's husband

/*	And so became my uncle
    Though it made me very sad
    For if he was my uncle */
uncle_of(U, N) :-
    male(U),
    parent_of(P, N),
    siblings(P, U).


/*  Then that also made him brother
    Of the widow's grown-up daughter */
brother(B, S) :-
    male(B),
    siblings(B, S).


/*  WHo of course is my step-mother */
stepmother_of(M, C) :-
    female(M),
    married(M, F),
    (daughter_of(C, F);
    	son_of(C, F)).


/*    Chorus
    I'm my own grandpa
    I'm my own grandpa
    It sounds funny I know
    But it really is so
    Oh, I'm my own grandpa
*/
grandfather_of(G, C):-
    male(G),
    parent_of(G, P),
    parent_of(P, C).
    
/*	My father's wife then had a son
    Who kept them on the run */


/*  And he became my grandchild
    For he was my daughter's son */  
grandchild_of(C, G) :-
    parent_of(P, C),
    parent_of(G, P).


/*  My wife is now my mother's mother
    And it makes me blue
    Because although she is my wife
    She's my grandmother too */
grandmother_of(G, C):-
    female(G),
    parent_of(G, P),
    parent_of(P, C).

/*  Now if my wife is my grandmother
    Then I'm her grandchild
    And every time I think of it
    It nearly drives me wild
    For now I have become
    The strangest case you ever saw
    As husband of my grandma
    I am my own grandpa

    [chorus]
    */

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
    
