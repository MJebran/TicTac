import SwiftUI

struct ContentView: View
{
    @StateObject var gameState = GameState()
    var body: some View
    {
        ZStack{
            Color.teal
                .edgesIgnoringSafeArea(.all)
            
        Text("Wellcome to TicTac")
        Text("Ready to lose")
        let borderSize = CGFloat(5)
        VStack(spacing: borderSize)
        {
            ForEach(0...2, id: \.self)
            {
                row in
                HStack(spacing: borderSize)
                {
                    ForEach(0...2, id: \.self)
                    {
                        column in
                        let cell = gameState.board[row][column]
                        
                        Text(cell.displayTile()).font(.system(size: 60))
                            .foregroundColor(cell.tileColor())
                            .bold()
                            .frame(minWidth: 100, maxHeight: 100)
                            .aspectRatio(1, contentMode: .fit)
                            .background(Color.teal)
                            .onTapGesture{gameState.placeTile(row, column)}
                    }
                }
            }
        }
        .background(Color.black)
        .padding()
        .alert(isPresented: $gameState.drawOrWin)
        {
            Alert(
                title: Text(gameState.draworWinMessage),
                dismissButton: .default(Text("OKay"))
                {
                    gameState.resetBoard()
                }
            )
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
