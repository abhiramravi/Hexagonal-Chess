
%----------------------------------------------------------------------------------
%			PROLOG Assignment - Glinski Hexagonal Chess
%			Abhiram R (CS10B060), Sabari Naran (CS10B020)
%----------------------------------------------------------------------------------

% The basic Game Playing template

play(Position, Player, Result):- 	choose_move(Position, Player, Move),
									move(Move, Position, Position1),
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
							[8, 11, b, r], [9, 11, b, n], [10, 11, b, q], [11, 10, b, k], [11, 9, b, n], [11, 8, b, r],
							% The three bishops
							[11, 11, b, b], [10, 10, b, b], [9, 9, b, b]
												
						],
			Player = w.
%----------------------------------------------------------------------------------
%		Displaying the game
%----------------------------------------------------------------------------------		
display_game(Position, Player) :- write(Position).

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
empty([], X, Y, 1).
empty([[X, Y, C, D]|T], X, Y, 0).
empty([_|T], X, Y, Result) :- empty(T, X, Y, Result). 
			
%----------------------------------------------------------------------------------
%		Checking if the move tried is legal
%----------------------------------------------------------------------------------				
legal(Position, Type, [[X1, Y1], [X2, Y2]]) :- 	get_piece_at_position(Position, X1, Y1, Piece, Type),
												specificlegal(Position, Piece, Type, [[X1, Y1], [X2, Y2]]),
												empty(Position, X2, Y2, Result), Result = 1.

legal(Position, Type, [[X1, Y1], [X2, Y2]]) :- 	get_piece_at_position(Position, X1, Y1, Piece, Type),
												specificlegal(Position, Piece, Type, [[X1, Y1], [X2, Y2]]),
												get_piece_at_position(Position, X2, Y2, Piece1, other_type(Type)).									
												
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
				
%dummy rule to allow all moves for the time being											
%specificlegal(Position, Piece, Type, [[X1, Y1], [X2, Y2]]). 						
			
%----------------------------------------------------------------------------------
%							THE PAWNS
%----------------------------------------------------------------------------------		

%	White Pawns	
specificlegal(Position, p, w, [[X1, Y1], [X2, Y2]]) :- 	X2 =:= X1 + 1, Y2 =:= Y1 + 1.	
specificlegal(Position, p, w, [[X1, Y1], [X2, Y2]]) :- 	X2 =:= X1 + 2, Y2 =:= Y1 + 2, 
														empty(Position, X1 + 1, Y1 + 1, Result), Result = 1,
														doublePawnWhiteMove(X1, Y1).	


specificlegal(Position, p, w, [[X1, Y1], [X2, Y2]]) :- 	X2 =:= X1, Y2 =:= Y1 + 1, 
														get_piece_at_position(Position, X2, Y2, Piece1, b).
														
specificlegal(Position, p, w, [[X1, Y1], [X2, Y2]]) :- 	X2 =:= X1 + 1, Y2 =:= Y1, 
														get_piece_at_position(Position, X2, Y2, Piece1, b).														
%	Black Pawns 

specificlegal(Position, p, b, [[X1, Y1], [X2, Y2]]) :- 	X2 =:= X1 - 1, Y2 =:= Y1 - 1.	
specificlegal(Position, p, b, [[X1, Y1], [X2, Y2]]) :- 	X2 =:= X1 - 2, Y2 =:= Y1 - 2, 
														empty(Position, X1 - 1, Y1 - 1, Result), Result = 1,
														doublePawnBlackMove(X1, Y1).	


specificlegal(Position, p, b, [[X1, Y1], [X2, Y2]]) :- 	X2 =:= X1, Y2 =:= Y1 - 1, 
														get_piece_at_position(Position, X2, Y2, Piece1, w).
														
specificlegal(Position, p, b, [[X1, Y1], [X2, Y2]]) :- 	X2 =:= X1 - 1, Y2 =:= Y1, 
														get_piece_at_position(Position, X2, Y2, Piece1, w).		
		
	
											
%----------------------------------------------------------------------------------
%							THE BISHOPS
%----------------------------------------------------------------------------------														
specificlegal(Position, b, _, [[X1, Y1], [X2, Y2]]) 	:- X2 =:= X1 + C, Y2 =:= Y1 + 2*C, clearDiagonalLOS([[X1, Y1], [X2, Y2]]).			
specificlegal(Position, b, _, [[X1, Y1], [X2, Y2]]) 	:- X2 =:= X1 + 2*C, Y2 =:= Y1 + C, clearDiagonalLOS([[X1, Y1], [X2, Y2]]).						
specificlegal(Position, b, _, [[X1, Y1], [X2, Y2]]) 	:- X2 =:= X1 + C, Y2 =:= Y1 - C, clearDiagonalLOS([[X1, Y1], [X2, Y2]]).		

%----------------------------------------------------------------------------------
%							THE KNIGHTS
%----------------------------------------------------------------------------------					
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 = X1 + 3, Y2 = Y1 + 2.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 = X1 + 3, Y2 = Y1 + 1.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 = X1 - 3, Y2 = Y1 - 2.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 = X1 - 3, Y2 = Y1 - 1.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 = X1 - 2, Y2 = Y1 + 1.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 = X1 - 1, Y2 = Y1 + 2.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 = X1 - 3, Y2 = Y1 + 2.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 = X1 - 3, Y2 = Y1 + 1.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 = X1 + 3, Y2 = Y1 - 1.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 = X1 + 3, Y2 = Y1 - 2.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 = X1 + 2, Y2 = Y1 - 1.		
specificlegal(Position, n, _, [[X1, Y1], [X2, Y2]])	:- X2 = X1 + 1, Y2 = Y1 - 2.		
		
%----------------------------------------------------------------------------------
%							THE ROOKS
%----------------------------------------------------------------------------------							
specificlegal(Position, r, _, [[X1, Y1], [X2, Y2]])	:- X2 =:= X1, Y2 =:= Y1 + C, clearLinearLOS([[X1, Y1], [X2, Y2]])	.	
specificlegal(Position, r, _, [[X1, Y1], [X2, Y2]])	:- X2 =:= X1 + C, Y2 =:= Y1, clearLinearLOS([[X1, Y1], [X2, Y2]])	.	
specificlegal(Position, r, _, [[X1, Y1], [X2, Y2]])	:- X2 =:= X1 + C, Y2 =:= Y1 + C, clearLinearLOS([[X1, Y1], [X2, Y2]])	.		

%----------------------------------------------------------------------------------
%							THE QUEEN
%----------------------------------------------------------------------------------						
specificlegal(Position, q, _, [[X1, Y1], [X2, Y2]]) 	:- specificlegal(Position, r, _, [[X1, Y1], [X2, Y2]]).
specificlegal(Position, q, _, [[X1, Y1], [X2, Y2]]) 	:- specificlegal(Position, b, _, [[X1, Y1], [X2, Y2]]).				
					
%----------------------------------------------------------------------------------
%							THE KING
%----------------------------------------------------------------------------------						
specificlegal(Position, k, _, [[X1, Y1], [X2, Y2]]) 	:- X2 =:= X1 + C, Y2 =:= Y1 + 2*C, C <= 1, C >= -1. C =\= 0.	
specificlegal(Position, k, _, [[X1, Y1], [X2, Y2]]) 	:- X2 =:= X1 + 2*C, Y2 =:= Y1 + C, C <= 1, C >= -1. C =\= 0.						
specificlegal(Position, k, _, [[X1, Y1], [X2, Y2]]) 	:- X2 =:= X1 + C, Y2 =:= Y1 - C, C <= 1, C >= -1. C =\= 0.		
specificlegal(Position, k, _, [[X1, Y1], [X2, Y2]])	:- X2 =:= X1, Y2 =:= Y1 + C, C <= 1, C >= -1. C =\= 0.	
specificlegal(Position, k, _, [[X1, Y1], [X2, Y2]])	:- X2 =:= X1 + C, Y2 =:= Y1, C <= 1, C >= -1. C =\= 0.	
specificlegal(Position, k, _, [[X1, Y1], [X2, Y2]])	:- X2 =:= X1 + C, Y2 =:= Y1 + C, C <= 1, C >= -1. C =\= 0.	

						
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
								
