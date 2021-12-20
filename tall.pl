c.
taller(a, b).
taller(b, c).

taller(X, Y) :- taller(X, Z), taller(Z, Y).

taller_or_equal(X, Y) :- taller(X, Y);
						 not(taller(Y, X)).