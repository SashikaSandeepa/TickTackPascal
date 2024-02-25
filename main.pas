program TickTackToe;

uses
    sysUtils;

type
    Cell = (X, O, _);
    TGridArray = array [1..3, 'a'..'c'] of Cell;
    TPlayer = record
        PlayerName: string;
        IsHisMove: boolean;

    end;

var
    Grid: TGridArray;
    Player1, Player2 : TPlayer;
    Winner : Cell;
    MoveCount : integer = 0;


procedure InitGrid(var Grid: TGridArray);
var
    i: integer;
    j: char;

begin
    for i:= 1 to 3 do
        for j:= 'a' to 'c' do
            // Grid[i,j] := sysUtils.intToStr(i) + j;
            Grid[i,j] := Cell._;
end;

// Print current Grid in a more readable way to the player
procedure PrintGrid(Grid: TGridArray);
var
    i: integer;
    j: char;

begin
    write(' ');
    for j:='a' to 'c' do
    begin
        write(j: 2)
    end;
    writeln();
    for i:= 1 to 3 do
    begin
        write(i, ' ');
        for j := 'a' to 'c' do
        begin
            write(Grid[i,j]:2);            
        end;
        writeln();
    end;
end;

function GetInput(var Player1, Player2: TPlayer): TGridArray;
var
    Row: integer;
    Col: char;
    Move: string;


begin
    Player1.PlayerName := 'Player1';
    Player2.PlayerName := 'Player2';

    write('Enter your move [(col)(row)]: ');
    readln(Move);
    Col := copy(Move, 1, 1)[1];
    Row := sysUtils.strToInt(copy(Move, 2, 1));
    // writeln('Row:', Row, ' ', 'Col:', Col);
    if Grid[Row, Col] = Cell._ then
    begin
        if Player1.IsHisMove = True then
        begin
            Player1.IsHisMove := False;
            Player2.IsHisMove := True;
            Grid[Row, Col] := Cell.X;
        end
        else
        begin
            Player2.IsHisMove := False;
            Player1.IsHisMove := True;
            Grid[Row, Col] := Cell.O;
        end;
    end
    else
    begin
        writeln('Illegal Move')
    end;

    GetInput := Grid;

end;

function FindWinner(var Grid: TGridArray; var MoveCount: integer): Cell;
var
    Row : integer;
    Col : char;
    Winner: Cell;

begin
    MoveCount := MoveCount + 1;
    Winner := Cell._;
    for Row := 1 to 3 do
    begin
        if Grid[Row,'a'] = Grid[Row,'b'] then
            if Grid[Row,'b'] = Grid[Row,'c'] then
                if Grid[Row,'c'] <> Cell._ then
                    Winner := Grid[Row,'a'];
    end;
    for Col := 'a' to 'c' do
    begin
        if Grid[1,Col] = Grid[2,Col] then
            if Grid[2,Col] = Grid[3,Col] then
                if Grid[3,Col] <> Cell._ then
                    Winner := Grid[1, Col];
    end;
    if Grid[1,'a'] = Grid[2,'b'] then
        if Grid[2,'b'] = Grid[3,'c'] then
            if Grid[3,'c'] <> Cell._ then
                Winner := Grid[1,'a'];
    if Grid[1,'c'] = Grid[2,'b'] then
        if Grid[2,'b'] = Grid[3,'a'] then
            if Grid[3,'a'] <> Cell._ then
                Winner := Grid[1,'a'];
    if MoveCount = 9 then
    begin
        writeln('DRAW!');
        Exit;
    end;

    FindWinner := Winner;
end;


// Begining of Main
begin
    // set the Player1 as the first to move
    Player1.IsHisMove := True;

    // Initiating the grid
    InitGrid(Grid);

    PrintGrid(Grid);
    While True do
    begin
        Grid := GetInput(Player1, Player2);
        PrintGrid(Grid);
        Winner := FindWinner(Grid, MoveCount);
        if Winner <> Cell._ then
        begin
            if Winner = Cell.X then
            begin
                writeln('Winner is Player1[x]');
            end
            else if Winner = Cell.O then
            begin
                writeln('Winner is Player2[O]');
            end;
            break;
        end;
    end;

end.
