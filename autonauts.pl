:- dynamic(clicked/3).

human(me).

bot(digger).
bot(planter).
bot(cutter).
bot(gatherer).
bot(recharger).

agent(X) :- human(X);
			bot(X).

on(X, 0) :- agent(X).
on(X, T, clicked(A, X, LastT)) :- 
			LastT = T - 1, agent(A), T >= 0,
			off(X, LastT).

on(X, T, not(clicked(H, X, LastT))) :-
			LastT = T - 1, human(H), T >= 0, 
			on(X, LastT), not(clicked(H, X, LastT)).

off(X, T) :- \+ on(X, T).

can_recharge(X, Y, T) :- agent(X), 
						 bot(Y), on(Y, T), 
						 not(X = Y).