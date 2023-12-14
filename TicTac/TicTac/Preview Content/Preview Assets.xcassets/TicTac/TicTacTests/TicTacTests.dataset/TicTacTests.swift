//
//  TicTacTests.swift
//  TicTacTests
//
//  Created by Ahmad Mustafa Jebran on 11/20/23.
//

import XCTest
@testable import TicTac

class TicTacTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    class GameStateTests: XCTestCase {
        
        var gameState: GameState!

        override func setUpWithError() throws {
            gameState = GameState()
        }

        override func tearDownWithError() throws {
            gameState = nil
        }

        // Test placing tiles and checking for a winner
        func testPlacingTilesAndWinner() {
            XCTAssertEqual(gameState.turn, Tile.Cross)
            
            // Simulate a game where Cross wins
            gameState.placeTile(0, 0)
            gameState.placeTile(1, 0)
            gameState.placeTile(0, 1)
            gameState.placeTile(1, 1)
            gameState.placeTile(0, 2)
            
            XCTAssertEqual(gameState.crossesSCcore, 1)
            XCTAssertEqual(gameState.turn, Tile.Circal)
            XCTAssertTrue(gameState.drawOrWin)
            XCTAssertEqual(gameState.draworWinMessage, "Crosses Win!")
        }

        // Test resetting the board
        func testResettingBoard() {
            // Simulate a game
            gameState.placeTile(0, 0)
            gameState.placeTile(1, 0)
            gameState.placeTile(0, 1)
            
            XCTAssertNotEqual(gameState.board[0][0].tile, Tile.Empty)
            XCTAssertNotEqual(gameState.board[1][0].tile, Tile.Empty)
            XCTAssertNotEqual(gameState.board[0][1].tile, Tile.Empty)
            
            gameState.resetBoard()
            
            XCTAssertEqual(gameState.board[0][0].tile, Tile.Empty)
            XCTAssertEqual(gameState.board[1][0].tile, Tile.Empty)
            XCTAssertEqual(gameState.board[0][1].tile, Tile.Empty)
            XCTAssertEqual(gameState.turn, Tile.Cross)
            XCTAssertEqual(gameState.crossesSCcore, 0)
            XCTAssertEqual(gameState.noughtsScore, 0)
            XCTAssertFalse(gameState.drawOrWin)
        }

        // Test placing tiles, checking for a winner, and draw
        func testPlacingTilesWinnerAndDraw() {
            XCTAssertEqual(gameState.turn, Tile.Cross)
            
            // Simulate a game where it ends in a draw
            gameState.placeTile(0, 0) // Cross
            gameState.placeTile(1, 0) // Nought
            gameState.placeTile(0, 1) // Cross
            gameState.placeTile(1, 1) // Nought
            gameState.placeTile(2, 0) // Cross
            gameState.placeTile(1, 2) // Nought
            gameState.placeTile(0, 2) // Cross
            gameState.placeTile(2, 1) // Nought
            gameState.placeTile(2, 2) // Cross

            XCTAssertTrue(gameState.drawOrWin)
            XCTAssertEqual(gameState.draworWinMessage, "Draw")
        }

        // Test resetting the board after a draw
        func testResettingBoardAfterDraw() {
            // Simulate a draw
            gameState.placeTile(0, 0)
            gameState.placeTile(1, 0)
            gameState.placeTile(0, 1)
            gameState.placeTile(1, 1)
            gameState.placeTile(2, 0)
            gameState.placeTile(1, 2)
            gameState.placeTile(0, 2)
            gameState.placeTile(2, 1)
            gameState.placeTile(2, 2)

            XCTAssertTrue(gameState.drawOrWin)
            XCTAssertEqual(gameState.draworWinMessage, "Draw")

            gameState.resetBoard()

            XCTAssertEqual(gameState.turn, Tile.Cross)
            XCTAssertEqual(gameState.crossesSCcore, 0)
            XCTAssertEqual(gameState.noughtsScore, 0)
            XCTAssertFalse(gameState.drawOrWin)
        }

        // Test checking for a winner after a reset
        func testCheckingWinnerAfterReset() {
            // Simulate a win
            gameState.placeTile(0, 0)
            gameState.placeTile(1, 0)
            gameState.placeTile(0, 1)
            gameState.placeTile(1, 1)
            gameState.placeTile(0, 2)

            XCTAssertTrue(gameState.drawOrWin)
            XCTAssertEqual(gameState.draworWinMessage, "Crosses Win!")

            gameState.resetBoard()

            XCTAssertEqual(gameState.turn, Tile.Cross)
            XCTAssertEqual(gameState.crossesSCcore, 0)
            XCTAssertEqual(gameState.noughtsScore, 0)
            XCTAssertFalse(gameState.drawOrWin)
        }

        // Test checking for a winner after switching turns
        func testCheckingWinnerAfterSwitchingTurns() {
            XCTAssertEqual(gameState.turn, Tile.Cross)

            // Simulate a win for Noughts
            gameState.placeTile(0, 0)
            gameState.placeTile(1, 0)
            gameState.placeTile(0, 1)
            gameState.placeTile(1, 1)
            gameState.placeTile(0, 2)

            XCTAssertEqual(gameState.turn, Tile.Cross) // Turn should not change after a win
            XCTAssertEqual(gameState.crossesSCcore, 0)
            XCTAssertEqual(gameState.noughtsScore, 1)
            XCTAssertTrue(gameState.drawOrWin)
            XCTAssertEqual(gameState.draworWinMessage, "Circals Win!")
        }
    }
}
