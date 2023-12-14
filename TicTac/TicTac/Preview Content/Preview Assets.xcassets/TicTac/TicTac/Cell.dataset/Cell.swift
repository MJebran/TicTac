import Foundation
import SwiftUI

struct Cell
{
    var tile: Tile
    
    func displayTile() -> String
    {
        switch(tile)
        {
        case Tile.Circal:
            return "O"
        case Tile.Cross:
            return "X"
        default:
            return ""
        }
    }
    
    func tileColor() -> Color
    {
        switch(tile)
        {
        case Tile.Circal:
            return Color.red
        case Tile.Cross:
            return Color.black
        default:
            return Color.black
        }
    }
}

enum Tile
{
    case Circal
    case Cross
    case Empty
}
