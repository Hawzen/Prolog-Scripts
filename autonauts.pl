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
on(X, Time, []) :- 
			agent(X), Time > 0,
			format('Solution is ~w ~n', [[]]);

			agent(X), Time > 0, LastTime is Time - 1,
			between(0, LastTime, H),
			on(X, Time, [H]).

on(X, Time, [H|Tail]) :- 
			agent(X), Time > 0,
			length(Tail, TailLength), TailLength < Time,
			LastTime is Time - 1, HNext is H+1, 
			between(HNext, LastTime, NewH),
			on(X, Time, [NewH, H|Tail]);

			agent(X), Time > 0,
			length(Tail, TailLength), TailLength =< Time, odd(TailLength),
			reverse([H|Tail], Solution),
			format('Solution is ~w ~n', [Solution]).

on_switched(X, T, switched(X, PastT)) :- T > PastT, on(X, T).

off(X, T) :- \+ on(X, T).

can_recharge(X, Y, T) :- agent(X), 
						 bot(Y), on(Y, T), 
						 not(X = Y).

even(N) :- N mod 2 =:= 0.
odd(N) :- \+ even(N).
