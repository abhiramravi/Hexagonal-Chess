
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
										legal(Position, Move).
										

%----------------------------------------------------------------------------------
%		The implementations of the above functions
%----------------------------------------------------------------------------------									
next_player(Player, Player1) :- Player = self, Player1 = computer.
next_player(Player, Player1) :- Player = computer, Player1 = self.

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
			Player = self.

display_game(Position, Player) :- write(Position).


get_piece_at_position([[X, Y, C, D]|T], X, Y, Piece, Type) :- Piece = D, Type = C.			
get_piece_at_position([[A, B, C, D]|T], X, Y, Piece, Type) :- get_piece_at_position(T, X, Y, Piece, Type).

empty(Position, X, Y) :- not(get_piece_at_position(Position, X, Y, Piece, Type)).
			
			
legal(Position, [[X1, Y1], [X2, Y2]]) :- 	get_piece_at_position(Position, X1, Y1, Piece, Type),
											legal(Position, Piece, Type, [[X1, Y1], [X2, Y2]]),
											empty(Position, X2, Y2).

legal(Position, [[X1, Y1], [X2, Y2]]) :- 	get_piece_at_position(Position, X1, Y1, Piece, Type),
											legal(Position, Piece, Type, [[X1, Y1], [X2, Y2]]),
											get_piece_at_position(Position, X2, Y2, Piece1, other_type(Type)).									
											
legal(Position, Piece, [[X1, Y1], [X2, Y2]]) :- Piece = wp, X2 = X1 + 1, Y2 = Y1 + 1.											
			
			
								
