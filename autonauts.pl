:- dynamic(switched/2).

human(me).

bot(digger).
bot(planter).
bot(cutter).
bot(gatherer).
bot(recharger).

agent(X) :- human(X);
			bot(X).

on(X, 0) :- agent(X).
on(X, T) :- T >= 0, LastT is T - 1,
			not(switched(X, LastT)), on(X, LastT);

			T >= 0, LastT is T - 1,
			switched(X, LastT), off(X, LastT).

on_switched(X, T, switched(X, PastT)) :- T > PastT, on(X, T).

off(X, T) :- \+ on(X, T).

can_recharge(X, Y, T) :- agent(X), 
						 bot(Y), on(Y, T), 
						 not(X = Y).