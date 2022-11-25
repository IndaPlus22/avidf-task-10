% Taken and modified from https://gist.github.com/MuffinTheMan/7806903
% Get an element from a 2-dimensional list at (Row,Column)
% using 1-based indexing.
nth1_2d(Row, Column, List, Element) :-
    nth1(Row, List, SubList),
    nth1(Column, SubList, Element).

%Checks if point on board is in list
check_visited(Point, [H|T]) :-
    Point = H;
    check_visited(Point, T).

% Reads a file and retrieves the Board from it.
load_board(BoardFileName, Board):-
    see(BoardFileName),     % Loads the input-file
    read(Board),            % Reads the first Prolog-term from the file
    seen.                   % Closes the io-stream

    %Check wether or not stone exist in position
    nth1_2d(Row, Column, Board, Stone),
    (Stone = b; Stone = w),                     %assign value to stone
    check_alive(Row, Column, Board, Stone, []). %Call predicate


% Checks whether the group of stones connected to
% the stone located at (Row, Column) is alive or dead.
check_alive(Row, Column, Board, Color, Visited):-
    %Check stone in given position
    nth1_2d(Row, Column, Board, Stone),

    %If 
    %True if position is empty
    (
        Stone = e,

        %Check stone color
        (
            Stone = Color,
            %Provable that it has not been visited 
            \+ check_visited((Row, Column), Visited),
            Up is Row - 1,
            Down is Row + 1, 
            Right is Row + 1,
            Left is Row - 1,
            
            %Check surrounding positions recursively
            (
                check_alive(Up, Column, Board, Color, [(Row, Column) | Visited]);
                check_alive(Down, Column, Board, Color, [(Row, Column) | Visited]);
                check_alive(Row, Right, Board, Color, [(Row, Column) | Visited]);
                check_alive(Row, Left, Board, Color, [(Row, Column) | Visited])
            )
        )
    ).


