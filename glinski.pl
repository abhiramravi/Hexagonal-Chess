
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
							(1, 5, wp), [2, 5, wp], [3, 5, wp], [4, 5, wp], [5, 5, wp], [5, 4, wp], [5, 3, wp], [5, 2, wp], [5, 1, wp], 
							% Other pieces of white
							[1, 4, wr], [1, 3, wn], [1, 2, wq], [4, 1, wr], [3, 1, wn], [2, 1, wk],
							% The three bishops
							[1, 1, wb], [2, 2, wb], [3, 3, wb],
												
							% Black's pieces :
							% The black pawns
							[7, 11, bp], [7, 10, bp], [7, 9, bp], [7, 8, bp], [7, 7, bp], [8, 7, bp], [9, 7, bp], [10, 7, bp], [11, 7, bp],
							% Other pieces of black
							[8, 11, br], [9, 11, bn], [10, 11, bq], [11, 10, bk], [11, 9, bn], [11, 8, br],
							% The three bishops
							[11, 11, bb], [10, 10, bb], [9, 9, bb]
												
						],
			Player = self.

display_game(Position, Player) :- write(Position).
%get_piece_at_position(Position, X, Y, Piece).			
			
			
legal(Position, [[X1, Y1], [X2, Y2]]) :- 	get_piece_at_position(Position, X1, Y1, Piece, Type),
											legal(Position, Piece, [[X1, Y1], [X2, Y2]]),
											empty(Position, X2, Y2).

legal(Position, [[X1, Y1], [X2, Y2]]) :- 	get_piece_at_position(Position, X1, Y1, Piece, Type),
											legal(Position, Piece, [[X1, Y1], [X2, Y2]]),
											get_piece_at_position(Position, X2, Y2, Piece1, other_type(Type)).									
											
			
			
								
