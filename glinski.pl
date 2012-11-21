
%----------------------------------------------------------------------------------
%			PROLOG Assignment - Glinski Hexagonal Chess
%			Abhiram R (CS10B060), Sabari Naran (CS10B020)
%----------------------------------------------------------------------------------

% The basic Game Playing template

play(Position, Player, Result):- 	choose_move(Position, Player, Move),
									move(Move, Position, Position1),
									notCheckKing(Position1, Player),
									existsNonCheckMoveForOpponent(Position1, Player),
									display_game(Position1, Player),
									next_player(Player, Player1),
									!,
									play(Position1, Player1, Result).
									
play(Position, Player, Result) :- 	game_over(Position, Player, Result),
									!,
									announce(Result).
									
play(Game) :- 						initialize(Game, Position, Player),
									display_game(Position, Player),
									play(Position, Player, Result).
				
choose_move(Position, Player, Move) :- 	read(Move), 
										legal(Position, Player, Move).
										

%----------------------------------------------------------------------------------
%		The implementations of the above functions
%----------------------------------------------------------------------------------									
next_player(Player, Player1) :- Player = w, Player1 = b.
next_player(Player, Player1) :- Player = b, Player1 = w.

other_type(Type, Type1) :- Type = w, Type1 = b.
other_type(Type, Type1) :- Type = b, Type1 = w.

initialize(Game, Position, Player) :- 
			Position =	[
							% White's pieces :
							% The white pawns
							[1, 5, w, p], [2, 5, w, p], [3, 5, w, p], [4, 5, w, p], [5, 5, w, p], [5, 4, w, p], [5, 3, w, p], [5, 2, w, p], [5, 1, w, p], 
							% Other pieces of white
							[1, 4, w, r], [1, 3, w, n], [1, 2, w, q], [4, 1, w, r], [3, 1, w, n], [2, 1, w, k],
							% The three bishops
							[1, 1, w, b], [2, 2, w, b], [3, 3, w, b],
												
							% Black's pieces :
							% The black pawns
							[7, 11, b, p], [7, 10, b, p], [7, 9, b, p], [7, 8, b, p], [7, 7, b, p], [8, 7, b, p], [9, 7, b, p], [10, 7, b, p], [11, 7, b, p],
							% Other pieces of black
							[8, 11, b, r], [9, 11, b, n], [10, 11, b, q], [11, 10, b, k],  [11, 8, b, r], [11, 9, b, n],
							% The three bishops
							[11, 11, b, b], [10, 10, b, b], [9, 9, b, b]
												
						],
			Player = w.
%----------------------------------------------------------------------------------
%		Displaying the game
%----------------------------------------------------------------------------------		
display_game(Position, Player) :-  			gap(16), write('__'), nl,
										gap(13), left(X), gap(Position, 11, 11), right(X),nl,
								gap(10), left(X), gap(Position, 10, 11), middle(X), gap(Position, 11, 10), right(X),nl,
								gap(7), left(X), gap(Position, 9, 11), middle(X), gap(Position, 10, 10), middle(X), gap(Position, 11, 9), right(X), nl,
								gap(4), left(X), gap(Position, 8, 11), middle(X), gap(Position, 9, 10), middle(X), gap(Position, 10, 9), middle(X), gap(Position, 11, 8), right(X), nl,
								
								gap(1), left(X), gap(Position, 7, 11),middle(X), gap(Position, 8, 10), middle(X), gap(Position, 9, 9), middle(X), 
								gap(Position, 10, 8), middle(X), gap(Position, 11, 7),right(X), nl,
								
								lend(X), gap(Position, 6, 11), middle(X), gap(Position, 7, 10), middle(X), gap(Position, 8, 9), middle(X), gap(Position, 9, 8), 
								middle(X), gap(Position, 10, 7), middle(X), gap(Position, 11, 6), rend(X), nl,
								
								
								middle(X), gap(Position, 6, 10),middle(X), gap(Position, 7, 9), middle(X), gap(Position, 8, 8), middle(X), 
								gap(Position, 9, 7), middle(X), gap(Position, 10, 6), middle(X), nl,
								
								lend(X), gap(Position, 5, 10), middle(X), gap(Position, 6, 9), middle(X), gap(Position, 7, 8), middle(X), 
								gap(Position, 8, 7), middle(X), gap(Position, 9, 6), middle(X), gap(Position, 10, 5), rend(X), nl,
								
								middle(X), gap(Position, 5, 9), middle(X), gap(Position, 6, 8), middle(X), gap(Position, 7, 7), middle(X), 
								gap(Position, 8, 6), middle(X), gap(Position, 9, 5), middle(X), nl,
								
								lend(X), gap(Position, 4, 9), middle(X), gap(Position, 5, 8), middle(X), gap(Position, 6, 7), middle(X), 
								gap(Position, 7, 6), middle(X), gap(Position, 8, 5), middle(X), gap(Position, 9, 4), rend(X), nl,
								
								middle(X), gap(Position, 4, 8), middle(X), gap(Position, 5, 7), middle(X), gap(Position, 6, 6), middle(X),
								gap(Position, 7, 5), middle(X), gap(Position, 8, 4), middle(X), nl,
								
								lend(X), gap(Position, 3, 8), middle(X), gap(Position, 4, 7), middle(X), gap(Position, 5, 6), middle(X), 
								gap(Position, 6, 5), middle(X), gap(Position, 7, 4), middle(X), gap(Position, 8, 3), rend(X), nl,
								
								middle(X), gap(Position, 3, 7), middle(X), gap(Position, 4, 6), middle(X), gap(Position, 5, 5), middle(X), 
								gap(Position, 6, 4), middle(X), gap(Position, 7, 3), middle(X), nl,
								
								lend(X), gap(Position, 2, 7), middle(X), gap(2), middle(X), gap(2), middle(X), gap(2), middle(X), gap(2), middle(X), gap(Position, 7, 2), rend(X), nl,
								middle(X), gap(2), middle(X), gap(2), middle(X), gap(2), middle(X), gap(2), middle(X), gap(2), middle(X), nl,
								lend(X), gap(Position, 1, 6), middle(X), gap(2), middle(X), gap(2), middle(X), gap(2), middle(X), gap(2), middle(X), gap(Position, 6, 1), rend(X), nl,
								middle(X), gap(Position, 1 ,5), middle(X), gap(2), middle(X), gap(2), middle(X), gap(2), middle(X), gap(Position, 5, 1), middle(X), nl,
								gap(3), middle(X), gap(Position, 1, 4), middle(X), gap(2), middle(X), gap(2), middle(X), gap(Position, 4 ,1), middle(X), nl,
								gap(6), middle(X), gap(Position, 1, 3), middle(X), gap(2), middle(X), gap(Position, 3 ,1), middle(X),  nl,
								gap(9), middle(X), gap(Position, 1, 2), middle(X), gap(Position, 2, 1), middle(X), nl,
								gap(12), middle(X), gap(Position, 1, 1), middle(X),nl,
								gap(15), middle(X),nl. %, write(Position), nl.


notgap(X) :- write(' '), Y is X -1, Y >0, notgap(Y).
%----------------------------------------------------------------------------------
%		Printing gaps for Hexagonal board testing
%----------------------------------------------------------------------------------	
gap(X) :- notgap(X), !, fail.
gap(X).
gap(Position, X, Y) :- get_piece_at_position(Position, X, Y, Piece, Type), write(Piece), write(Type).
gap(Position, X, Y) :- gap(2).

%----------------------------------------------------------------------------------
%		Getting piece at particular position and printing it
%----------------------------------------------------------------------------------	


left(X) :- write('__/').
right(X) :- write('\\__').
middle(X) :- write('\\__/').
rend(X) :- write('\\').
lend(X) :- write('/').
%func():-

% Implementing NOT
%notfunc(A):-func(A),!,fail.
%notfunc(A).
%----------------------------------------------------------------------------------
%		Getting the piece for the given position 
%----------------------------------------------------------------------------------		
get_piece_at_position([], X, Y, Piece, Type) :- fail.
get_piece_at_position([[X, Y, C, D]|T], X, Y, Piece, Type) :- Piece = D, Type = C.			
get_piece_at_position([[A, B, C, D]|T], X, Y, Piece, Type) :- get_piece_at_position(T, X, Y, Piece, Type).

%----------------------------------------------------------------------------------
%		Checking if the position coordinate given is empty
%----------------------------------------------------------------------------------
empty(Position, X, Y) :- get_piece_at_position(Position, X, Y, Piece, Type), !, fail.
empty(Position, X, Y).
/*
empty([], X, Y, 1).
empty([[X, Y, C, D]|T], X, Y, 0).
empty([_|T], X, Y, Result) :- empty(T, X, Y, Result). 
	*/		
%----------------------------------------------------------------------------------
%		Checking if the move tried is legal
%----------------------------------------------------------------------------------	
legal(Position, Type, [[X1, Y1], [X2, Y2]]) :- 	get_piece_at_position(Position, X2, Y2, Piece1, C), other_type(Type, C), 
												get_piece_at_position(Position, X1, Y1, Piece, Type),
												specificlegal(Position, Piece, Type, [[X1, Y1], [X2, Y2]]). 
															
legal(Position, Type, [[X1, Y1], [X2, Y2]]) :- 	empty(Position, X2, Y2),  
												get_piece_at_position(Position, X1, Y1, Piece, Type), 
												specificlegal(Position, Piece, Type, [[X1, Y1], [X2, Y2]]).


												
%----------------------------------------------------------------------------------
%		Performing the move given on the current board
%----------------------------------------------------------------------------------	
% If the entry point of move is the one being seen, then change its coordinate to 
% the exit point of move and add to the Position1	

move(_, [], []). 
move([[X1, Y1],[X2, Y2]], [[X1, Y1, C, D]|T] , [[X2, Y2, C, D]|T1]) :- move([[X1, Y1],[X2, Y2]],T,T1).
move([[X1, Y1],[X2, Y2]], [[X2, Y2, C, D]|T] , T1) :- move([[X1, Y1],[X2, Y2]], T, T1).
move([[X1, Y1],[X2, Y2]], [[X, Y, C, D]|T], [[X, Y, C, D]|T1]) :-  move([[X1, Y1],[X2, Y2]], T, T1).

	
%----------------------------------------------------------------------------------
%		Checking if the move is legal for the given piece
%----------------------------------------------------------------------------------		

% Defining some dependancies

doublePawnWhiteMove(X, Y) :- X = 1, Y = 5.
doublePawnWhiteMove(X, Y) :- X = 2, Y = 5.
doublePawnWhiteMove(X, Y) :- X = 3, Y = 5.
doublePawnWhiteMove(X, Y) :- X = 4, Y = 5.
doublePawnWhiteMove(X, Y) :- X = 5, Y = 5.
doublePawnWhiteMove(X, Y) :- X = 5, Y = 4.
doublePawnWhiteMove(X, Y) :- X = 5, Y = 3.
doublePawnWhiteMove(X, Y) :- X = 5, Y = 2.
doublePawnWhiteMove(X, Y) :- X = 5, Y = 1.	
doublePawnBlackMove(X, Y) :- X = 7, Y = 11.
doublePawnBlackMove(X, Y) :- X = 7, Y = 10.
doublePawnBlackMove(X, Y) :- X = 7, Y = 9.
doublePawnBlackMove(X, Y) :- X = 7, Y = 8.
doublePawnBlackMove(X, Y) :- X = 7, Y = 7.
doublePawnBlackMove(X, Y) :- X = 8, Y = 7.
doublePawnBlackMove(X, Y) :- X = 9, Y = 7.
doublePawnBlackMove(X, Y) :- X = 10, Y = 7.
doublePawnBlackMove(X, Y) :- X = 11, Y = 7.

clearDiagonalLOS1(Position, [[X1, Y1], [X2, Y2]]) :- X1 =:= X2 + 1, Y1 =:= Y2 + 2.
clearDiagonalLOS1(Position, [[X1, Y1], [X2, Y2]]) :-	X1 =:= X2 - 1, Y1 =:= Y2 - 2.
clearDiagonalLOS1(Position, [[X1, Y1], [X2, Y2]]) :- X1 < X2, X is X1 + 1, Y is Y1 + 2,empty(Position, X, Y),
													clearDiagonalLOS1(Position, [[X, Y],[X2, Y2]]).
clearDiagonalLOS1(Position, [[X1, Y1], [X2, Y2]]) :- X1 > X2, X is X1 - 1, Y is Y1 - 2,empty(Position, X, Y),
													clearDiagonalLOS1(Position, [[X, Y],[X2, Y2]]).
clearDiagonalLOS2(Position, [[X1, Y1], [X2, Y2]]) :-	X2 =:= X1 + 2, Y2 =:= Y1 + 1.
clearDiagonalLOS2(Position, [[X1, Y1], [X2, Y2]]) :-	X2 =:= X1 - 2, Y2 =:= Y1 - 1.
clearDiagonalLOS2(Position, [[X1, Y1], [X2, Y2]]) :- X1 < X2, X is X1 + 2, Y is Y1 + 1,empty(Position, X, Y),
													clearDiagonalLOS2(Position, [[X, Y],[X2, Y2]]).
clearDiagonalLOS2(Position, [[X1, Y1], [X2, Y2]]) :- X1 > X2, X is X1 - 2, Y is Y1 - 1,empty(Position, X, Y),
													clearDiagonalLOS2(Position, [[X, Y],[X2, Y2]]).

clearDiagonalLOS3(Position, [[X1, Y1], [X2, Y2]]) :- X2 =:= X1 + 1, Y2 =:= Y1 - 1.
clearDiagonalLOS3(Position, [[X1, Y1], [X2, Y2]]) :- X2 =:= X1 - 1, Y2 =:= Y1 + 1.
clearDiagonalLOS3(Position, [[X1, Y1], [X2, Y2]]) :- X1 < X2,  X is X1 + 1, Y is Y1 - 1,empty(Position, X, Y),
													clearDiagonalLOS3(Position, [[X, Y],[X2, Y2]]).
clearDiagonalLOS3(Position, [[X1, Y1], [X2, Y2]]) :- X1 > X2,  X is X1 - 1, Y is Y1 + 1,empty(Position, X, Y),
													clearDiagonalLOS3(Position, [[X, Y],[X2, Y2]]).
													
													
clearLinearLOS1(Position, [[X1, Y1], [X2, Y2]]) :-	X2 =:= X1, Y2 =:= Y1 + 1.
clearLinearLOS1(Position, [[X1, Y1], [X2, Y2]]) :- 	X2 =:= X1, Y2 =:= Y1 - 1.
clearLinearLOS1(Position, [[X1, Y1], [X2, Y2]]) :- 	Y1 < Y2, X is X1, Y is Y1 + 1,empty(Position, X, Y),
													clearLinearLOS1(Position, [[X , Y],[X2, Y2]]).
clearLinearLOS1(Position, [[X1, Y1], [X2, Y2]]) :- 	Y1 > Y2, X is X1, Y is Y1 - 1,empty(Position, X, Y),
													clearLinearLOS1(Position, [[X, Y],[X2, Y2]]).	
													
clearLinearLOS2(Position, [[X1, Y1], [X2, Y2]]) :- 	X2 =:= X1 + 1, Y2 =:= Y1.
clearLinearLOS2(Position, [[X1, Y1], [X2, Y2]]) :- 	X2 =:= X1 - 1, Y2 =:= Y1.
clearLinearLOS2(Position, [[X1, Y1], [X2, Y2]]) :- 	X1 < X2, X is X1 + 1, Y is Y1,empty(Position, X, Y),
													clearLinearLOS2(Position, [[X, Y],[X2, Y2]]).
clearLinearLOS2(Position, [[X1, Y1], [X2, Y2]]) :- 	X1 > X2, X is X1 - 1, Y is Y1,empty(Position, X, Y),
													clearLinearLOS2(Position, [[X, Y],[X2, Y2]]).
													
clearLinearLOS3(Position, [[X1, Y1], [X2, Y2]]) :- 	X1 =:= X2 - 1, Y1 =:= Y2 - 1.
clearLinearLOS3(Position, [[X1, Y1], [X2, Y2]]) :- 	X1 =:= X2 + 1, Y1 =:= Y2 + 1.
clearLinearLOS3(Position, [[X1, Y1], [X2, Y2]]) :- 	Y1 < Y2, X is X1 + 1, Y is Y1 + 1,empty(Position, X, Y),
													clearLinearLOS3(Position, [[X , Y],[X2, Y2]]).
clearLinearLOS3(Position, [[X1, Y1], [X2, Y2]]) :- 	Y1 > Y2, X is X1 - 1, Y is Y1 - 1,empty(Position, X, Y),
													clearLinearLOS3(Position, [[X, Y],[X2, Y2]]).
%dummy rule to allow all moves for the time being											
%specificlegal(Position, Piece, Type, [[X1, Y1], [X2, Y2]]). 						
			
%----------------------------------------------------------------------------------
%							THE PAWNS
%----------------------------------------------------------------------------------		

%	White Pawns	
specificlegal(Position, p, w, [[X1, Y1], [X2, Y2]]) :- 	X2 =:= X1 + 1, Y2 =:= Y1 + 1.	
specificlegal(Position, p, w, [[X1, Y1], [X2, Y2]]) :- 	X2 =:= X1 + 2, Y2 =:= Y1 + 2, X is X1 + 1, Y is Y1 + 1, 
														empty(Position, X, Y),
														doublePawnWhiteMove(X1, Y1).	


specificlegal(Position, p, w, [[X1, Y1], [X2, Y2]]) :- 	X2 =:= X1, Y2 =:= Y1 + 1, 
														get_piece_at_position(Position, X2, Y2, Piece1, b).
														
specificlegal(Position, p, w, [[X1, Y1], [X2, Y2]]) :- 	X2 =:= X1 + 1, Y2 =:= Y1, 
														get_piece_at_position(Position, X2, Y2, Piece1, b).														
%	Black Pawns 

specificlegal(Position, p, b, [[X1, Y1], [X2, Y2]]) :- 	X2 =:= X1 - 1, Y2 =:= Y1 - 1.	
specificlegal(Position, p, b, [[X1, Y1], [X2, Y2]]) :- 	X2 =:= X1 - 2, Y2 =:= Y1 - 2, X is X1 - 1, Y is Y1 - 1,
														empty(Position, X, Y),
														doublePawnBlackMove(X1, Y1).	


specificlegal(Position, p, b, [[X1, Y1], [X2, Y2]]) :- 	X2 =:= X1, Y2 =:= Y1 - 1, 
														get_piece_at_position(Position, X2, Y2, Piece1, w).
														
specificlegal(Position, p, b, [[X1, Y1], [X2, Y2]]) :- 	X2 =:= X1 - 1, Y2 =:= Y1, 
														get_piece_at_position(Position, X2, Y2, Piece1, w).		
		
	
											
%----------------------------------------------------------------------------------
%							THE BISHOPS
%----------------------------------------------------------------------------------		

specificlegal(Position, b, _, [[X1, Y1], [X2, Y2]]) 	:- specificlegal2(Position, b, _, [[X1, Y1], [X2, Y2]], -11, C1). 
		/*										
specificlegal(Position, b, _, [[X1, Y1], [X2, Y2]]) 	:- C =< 100, C >= -100, X2 =:= X1 + C, Y2 =:= Y1 + 2*C,  clearDiagonalLOS1(Position, [[X1, Y1], [X2, Y2]]).			
specificlegal(Position, b, _, [[X1, Y1], [X2, Y2]]) 	:- C =< 100, C >= -100, X2 =:= X1 + 2*C, Y2 =:= Y1 + C, clearDiagonalLOS2(Position, [[X1, Y1], [X2, Y2]]).						
specificlegal(Position, b, _, [[X1, Y1], [X2, Y2]]) 	:- C =< 100, C >= -100, X2 =:= X1 + C, Y2 =:= Y1 - C, clearDiagonalLOS3(Position, [[X1, Y1], [X2, Y2]]).		
*/
%----------------------------------------------------------------------------------
%							THE KNIGHTS
%----------------------------------------------------------------------------------					
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 =:= X1 + 1, Y2 =:=  Y1 + 3.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 =:=  X1 + 2, Y2 =:=  Y1 + 3.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 =:=  X1 + 3, Y2 =:=  Y1 + 1.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 =:=  X1 + 3, Y2 =:=  Y1 + 2.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 =:=  X1 + 3, Y2 =:=  Y1 - 1.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 =:=  X1 + 3, Y2 =:=  Y1 - 2.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 =:=  X1 - 1, Y2 =:=  Y1 + 2.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 =:=  X1 - 2, Y2 =:=  Y1 + 1.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 =:=  X1 - 3, Y2 =:=  Y1 - 1.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 =:=  X1 - 3, Y2 =:=  Y1 - 2.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 =:=  X1 - 1, Y2 =:=  Y1 - 3.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 =:=  X1 - 2, Y2 =:=  Y1 - 3.		
		
%----------------------------------------------------------------------------------
%							THE ROOKS
%----------------------------------------------------------------------------------		
specificlegal(Position, r, _, [[X1, Y1], [X2, Y2]]) 	:- specificlegal3(Position, r, _, [[X1, Y1], [X2, Y2]], -11, C1). 	
/*				
specificlegal(Position, r, _, [[X1, Y1], [X2, Y2]])	:- X2 =:= X1, Y2 =:= Y1 + C, clearLinearLOS1([[X1, Y1], [X2, Y2]]).	
specificlegal(Position, r, _, [[X1, Y1], [X2, Y2]])	:- X2 =:= X1 + C, Y2 =:= Y1, clearLinearLOS2([[X1, Y1], [X2, Y2]]).	
specificlegal(Position, r, _, [[X1, Y1], [X2, Y2]])	:- X2 =:= X1 + C, Y2 =:= Y1 + C, clearLinearLOS3([[X1, Y1], [X2, Y2]]).		
*/
%----------------------------------------------------------------------------------
%							THE QUEEN
%----------------------------------------------------------------------------------						
specificlegal(Position, q, _, [[X1, Y1], [X2, Y2]]) 	:- specificlegal(Position, r, _, [[X1, Y1], [X2, Y2]]).
specificlegal(Position, q, _, [[X1, Y1], [X2, Y2]]) 	:- specificlegal(Position, b, _, [[X1, Y1], [X2, Y2]]).				
					
%----------------------------------------------------------------------------------
%							THE KING
%----------------------------------------------------------------------------------						
specificlegal(Position, k, _, [[X1, Y1], [X2, Y2]]) 	:- X2 =:= X1 + 1, Y2 =:= Y1 + 2.	
specificlegal(Position, k, _, [[X1, Y1], [X2, Y2]]) 	:- X2 =:= X1 + 2, Y2 =:= Y1 + 1.						
specificlegal(Position, k, _, [[X1, Y1], [X2, Y2]]) 	:- X2 =:= X1 + 1, Y2 =:= Y1 - 1.		
specificlegal(Position, k, _, [[X1, Y1], [X2, Y2]])	:- X2 =:= X1, Y2 =:= Y1 + 1.	
specificlegal(Position, k, _, [[X1, Y1], [X2, Y2]])	:- X2 =:= X1 + 1, Y2 =:= Y1.	
specificlegal(Position, k, _, [[X1, Y1], [X2, Y2]])	:- X2 =:= X1 + 1, Y2 =:= Y1 + 1.	
specificlegal(Position, k, _, [[X1, Y1], [X2, Y2]]) 	:- X2 =:= X1 - 1, Y2 =:= Y1 - 2.	
specificlegal(Position, k, _, [[X1, Y1], [X2, Y2]]) 	:- X2 =:= X1 - 2, Y2 =:= Y1 - 1.						
specificlegal(Position, k, _, [[X1, Y1], [X2, Y2]]) 	:- X2 =:= X1 - 1, Y2 =:= Y1 + 1.		
specificlegal(Position, k, _, [[X1, Y1], [X2, Y2]])	:- X2 =:= X1, Y2 =:= Y1 - 1.	
specificlegal(Position, k, _, [[X1, Y1], [X2, Y2]])	:- X2 =:= X1 - 1, Y2 =:= Y1.	
specificlegal(Position, k, _, [[X1, Y1], [X2, Y2]])	:- X2 =:= X1 - 1, Y2 =:= Y1 - 1.	

						
specificlegal2(Position, b, _, [[X1, Y1], [X2, Y2]], C, C) 	:- C =< 11, X2 =:= X1 + C, Y2 =:= Y1 + 2*C,  clearDiagonalLOS1(Position, [[X1, Y1], [X2, Y2]]).			
specificlegal2(Position, b, _, [[X1, Y1], [X2, Y2]], C, C) 	:- C =< 11, X2 =:= X1 + 2*C, Y2 =:= Y1 + C, clearDiagonalLOS2(Position, [[X1, Y1], [X2, Y2]]).						
specificlegal2(Position, b, _, [[X1, Y1], [X2, Y2]], C, C) 	:- C =< 11, X2 =:= X1 + C, Y2 =:= Y1 - C, clearDiagonalLOS3(Position, [[X1, Y1], [X2, Y2]]).						
specificlegal2(Position, b, _, [[X1, Y1], [X2, Y2]], C, C1)   :- C =< 11, C2 is C + 1, specificlegal2(Position, b, _, [[X1, Y1], [X2, Y2]], C2, C1).						
					
specificlegal3(Position, r, _, [[X1, Y1], [X2, Y2]], C, C1)	:- C =< 11, X2 =:= X1, Y2 =:= Y1 + C, clearLinearLOS1(Position, [[X1, Y1], [X2, Y2]]).	
specificlegal3(Position, r, _, [[X1, Y1], [X2, Y2]], C, C1)	:- C =< 11, X2 =:= X1 + C, Y2 =:= Y1, clearLinearLOS2(Position, [[X1, Y1], [X2, Y2]]).	
specificlegal3(Position, r, _, [[X1, Y1], [X2, Y2]], C, C1)	:- C =< 11, X2 =:= X1 + C, Y2 =:= Y1 + C, clearLinearLOS3(Position, [[X1, Y1], [X2, Y2]]).			
specificlegal3(Position, r, _, [[X1, Y1], [X2, Y2]], C, C1)	:- C =< 11, C2 is C + 1, specificlegal3(Position, r, _, [[X1, Y1], [X2, Y2]], C2, C1).					
					
%----------------------------------------------------------------------------------
%						FINDING THE KING
%----------------------------------------------------------------------------------	
findKing([[X, Y, C, k]|T], C, X, Y).
findKing([_|T], C, X, Y) :- findKing(T, C, X, Y).		

%----------------------------------------------------------------------------------
%						CHECKING FOR CHECK
%----------------------------------------------------------------------------------
checkKing(Position, Player) :- findKing(Position, Player, X, Y), 	legal(Position, Type, [[X1, Y1], [X, Y]]), other_type(Player, Type).			
					
notCheckKing(Position, Player) :- checkKing(Position, Player),!,fail.
notCheckKing(Position, Player).				

%----------------------------------------------------------------------------------
%						CHECKMATE
%----------------------------------------------------------------------------------					
existsNonCheckMoveForOpponent(Position1, Player)	:- 	other_type(Player, Type), 
													findKing(Position1, Type, X, Y), 
													legal(Position1, Type, [[X1, Y1], [X2, Y2]]), 	
													move([[X1, Y1], [X2, Y2]], Position1, Position2),
													notCheckKing(Position2, Type). 			
					
					
					
					
					
					
								
