import Foundation

class GameState: ObservableObject //observable object
{
    @Published var board = [[Cell]]() // It saves the sate of the game and it 2D array
    @Published var turn = Tile.Cross// cross will go first, first turn
    @Published var noughtsScore = 0
    @Published var crossesSCcore = 0
    @Published var drawOrWin = false
    @Published var draworWinMessage = "Draw"
    
    init()
    {
        resetBoard() //restBoard function
    }
    
    func placeTile(_ row: Int,_ column: Int)
    {
        if(board[row][column].tile != Tile.Empty)
        {return}
        // checking if the turn if it is Corss's turn Cross will play if not Nought will play
        board[row][column].tile = turn == Tile.Cross ? Tile.Cross : Tile.Circal
        
        //Toggling the turn
        //turn = turn == Tile.Cross ? Tile.Nought : Tile.Cross // now Nought will if not it will be Cross's turn to play
        
        //checking for winner
        if(checkForWinner())
        {
            if(turn == Tile.Cross) {crossesSCcore += 1}
            else {noughtsScore += 1}
            
            let winner = turn == Tile.Cross ? "Crosses" : "Circal"
            draworWinMessage = winner + " Win!"
            drawOrWin = true
        }
        else
        {
            turn = turn == Tile.Cross ? Tile.Circal : Tile.Cross
        }
        
        if(checkForDraw())
        {
            draworWinMessage = "Draw"
            drawOrWin = true
        }
    }
    
    func checkForDraw() -> Bool
    {
        for row in board
        {
            for cell in row{
                if cell.tile == Tile.Empty
                {
                    return false
                }
            }
        }
        return true
    }
    
    func checkForWinner() -> Bool
    {
        // This is our Vertical Victory
        if isTurnTile(0, 0) && isTurnTile(1, 0) && isTurnTile(2, 0) {return true}
        if isTurnTile(0, 1) && isTurnTile(1, 1) && isTurnTile(2, 1) {return true}
        if isTurnTile(0, 2) && isTurnTile(1, 2) && isTurnTile(2, 2) {return true}
        
        // This is our Horizontal Victory
        if isTurnTile(0, 0) && isTurnTile(0, 1) && isTurnTile(0, 2) {return true}
        if isTurnTile(1, 0) && isTurnTile(1, 1) && isTurnTile(1, 2) {return true}
        if isTurnTile(2, 0) && isTurnTile(2, 1) && isTurnTile(2, 2) {return true}
        
        // This is our Horizontal Victory
        if isTurnTile(0, 0) && isTurnTile(0, 1) && isTurnTile(0, 2) {return true}
        if isTurnTile(1, 0) && isTurnTile(1, 1) && isTurnTile(1, 2) {return true}
        if isTurnTile(2, 0) && isTurnTile(2, 1) && isTurnTile(2, 2) {return true}
        
        // This is our Diagonal Victory
        if isTurnTile(0, 0) && isTurnTile(1, 1) && isTurnTile(2, 2) {return true}
        if isTurnTile(0, 2) && isTurnTile(1, 1) && isTurnTile(2, 0) {return true}
        
        return false
    }
    
    func isTurnTile(_ row: Int,_ column: Int) -> Bool
    {
        return board[row][column].tile == turn 
    }
    
    func resetBoard()
    {
        var newBoard = [[Cell]]() //new board of type Cell
        
        for _ in 0...2
        {
            var row = [Cell]() //cell array
            for  _ in 0...2 //going through 3 times
            {
                row.append(Cell(tile: Tile.Empty))
            }
            newBoard.append(row)
        }
        board = newBoard
    }
}
