import Foundation

var black = 1
var red = 2
var move = 1
var checkerBoard: [[Int]] = [[1,0,1,0,1,0,1,0],[0,1,0,1,0,1,0,1],[1,0,1,0,1,0,1,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,2,0,2,0,2,0,2],[2,0,2,0,2,0,2,0],[0,2,0,2,0,2,0,2]]

let fileName = "checkers.txt"
let dir = try? FileManager.default.url(for: .documentDirectory, 
      in: .userDomainMask, appropriateFor: nil, create: true)

// If the directory was found, we write a file to it and read it back
if let fileURL = dir?.appendingPathComponent(fileName).appendingPathExtension("txt") {
	// Then reading it back from the file
    var inString = ""
    do {
        inString = try String(contentsOf: fileURL)
    } catch {
        print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
    }
    print("Read from the file: \(inString)") //TODO turn this print off after testing
	
	var stringSplit = inString.components(separatedBy: "\n")
	
	var splitIndex = 0
	
	for i in 0...7 {
		for j in 0...7 {
			checkerBoard[i][j] = Int(stringSplit[splitIndex])! 
			splitIndex = splitIndex + 1
		}
	}
	
	move = Int(stringSplit[splitIndex])! 
}


func printBoard() {
	print("    0   1   2   3   4   5   6   7")
	print("  ---------------------------------")
	print("0 | \(checkerBoard[0][0]) | \(checkerBoard[0][1]) | \(checkerBoard[0][2]) | \(checkerBoard[0][3]) | \(checkerBoard[0][4]) | \(checkerBoard[0][5]) | \(checkerBoard[0][6]) | \(checkerBoard[0][7]) |")
	print("  ---------------------------------")
	print("1 | \(checkerBoard[1][0]) | \(checkerBoard[1][1]) | \(checkerBoard[1][2]) | \(checkerBoard[1][3]) | \(checkerBoard[1][4]) | \(checkerBoard[1][5]) | \(checkerBoard[1][6]) | \(checkerBoard[1][7]) |")
	print("  ---------------------------------")
	print("2 | \(checkerBoard[2][0]) | \(checkerBoard[2][1]) | \(checkerBoard[2][2]) | \(checkerBoard[2][3]) | \(checkerBoard[2][4]) | \(checkerBoard[2][5]) | \(checkerBoard[2][6]) | \(checkerBoard[2][7]) |")
	print("  ---------------------------------")
	print("3 | \(checkerBoard[3][0]) | \(checkerBoard[3][1]) | \(checkerBoard[3][2]) | \(checkerBoard[3][3]) | \(checkerBoard[3][4]) | \(checkerBoard[3][5]) | \(checkerBoard[3][6]) | \(checkerBoard[3][7]) |")
	print("  ---------------------------------")
	print("4 | \(checkerBoard[4][0]) | \(checkerBoard[4][1]) | \(checkerBoard[4][2]) | \(checkerBoard[4][3]) | \(checkerBoard[4][4]) | \(checkerBoard[4][5]) | \(checkerBoard[4][6]) | \(checkerBoard[4][7]) |")
	print("  ---------------------------------")
	print("5 | \(checkerBoard[5][0]) | \(checkerBoard[5][1]) | \(checkerBoard[5][2]) | \(checkerBoard[5][3]) | \(checkerBoard[5][4]) | \(checkerBoard[5][5]) | \(checkerBoard[5][6]) | \(checkerBoard[5][7]) |")
	print("  ---------------------------------")
	print("6 | \(checkerBoard[6][0]) | \(checkerBoard[6][1]) | \(checkerBoard[6][2]) | \(checkerBoard[6][3]) | \(checkerBoard[6][4]) | \(checkerBoard[6][5]) | \(checkerBoard[6][6]) | \(checkerBoard[6][7]) |")
	print("  ---------------------------------")
	print("7 | \(checkerBoard[7][0]) | \(checkerBoard[7][1]) | \(checkerBoard[7][2]) | \(checkerBoard[7][3]) | \(checkerBoard[7][4]) | \(checkerBoard[7][5]) | \(checkerBoard[7][6]) | \(checkerBoard[7][7]) |")
	print("  ---------------------------------")
}

func askAndMakeMove() {
	printBoard()

	if move == 1 {
		print("It is Black's turn")
	}
	else if move == 2 {
		print("It is Red's turn")
	}

	var moveInvalid = true
	var stayInLoop = true
	var checkerRow = -1
	var checkerColumn = -1

	while (moveInvalid) {
		stayInLoop = true
		while (stayInLoop) {
			print("What row is the checker you wish to move (0-7):")
			if let checkRow = Int(readLine()!) {
				if (checkRow <= 7 && checkRow >= 0 ) {
					stayInLoop = false		
					checkerRow = checkRow
				} else {
					print("Must be between 0-7")
				}
			} else {
				print("Must be between 0-7")
			}
		}

		stayInLoop = true
		while (stayInLoop) {
			print("What column is the checker you wish to move (0-7):")
			if let checkColumn = Int(readLine()!) {
				if checkColumn <= 7 && checkColumn >= 0 {
					stayInLoop = false
					checkerColumn = checkColumn
				} else {
					print("Must be between 0-7")
				}
			} else {
				print("Must be between 0-7")
			}
		}
		
		if checkerBoard[checkerRow][checkerColumn] == move {
			print("Checker at: ", checkerRow, "-", checkerColumn)
			moveInvalid = false;
		}
		else{
			print("Invalid choice: ", checkerRow, "-", checkerColumn)
		}
	}

	var validMoves: [[Int]] = [[-1,-1],[-1,-1]]

	func storeValidMove (_row: Int, _column: Int) {
		for index in 0...1 {
			if validMoves[index][0] == -1 {
				validMoves[index][0] = _row
				validMoves[index][1] = _column
				break
			}	
		}
	}

	func checkMove(_row: Int, _column: Int, _inJumpChain: Bool) {
		if move == 1 { 
			if (_row + 1 <= 7 && _column - 1 >= 0) {
				if (checkerBoard[_row + 1][_column - 1] == 0 && !_inJumpChain) { 
					storeValidMove(_row: _row + 1, _column: _column - 1)
				} else if (checkerBoard[_row + 1][_column - 1] == 2 && _row + 2 <= 7 && _column - 2 >= 0 && checkerBoard[_row + 2][_column - 2] == 0) {
					storeValidMove(_row: _row + 2, _column: _column - 2)
				}
			}
			
			if (_row + 1 <= 7 && _column + 1 <= 7) {
				if (checkerBoard[_row + 1][_column + 1] == 0 && !_inJumpChain) { 
					storeValidMove(_row: _row + 1, _column: _column + 1)
				} else if (checkerBoard[_row + 1][_column + 1] == 2 && _row + 2 <= 7 && _column + 2 <= 7 && checkerBoard[_row + 2][_column + 2] == 0) {
					storeValidMove(_row: _row + 2, _column: _column + 2)
				}
			}
			
		}
		if move == 2 { 
			if (_row - 1 >= 0 && _column - 1 >= 0) {
				if (checkerBoard[_row - 1][_column - 1] == 0 && !_inJumpChain) { 
					storeValidMove(_row: _row - 1, _column: _column - 1)
				} else if (checkerBoard[_row - 1][_column - 1] == 1 && _row - 2 >= 0 && _column - 2 >= 0 && checkerBoard[_row - 2][_column - 2] == 0) {
					storeValidMove(_row: _row - 2, _column: _column - 2)
				}
			}
			
			if (_row - 1 >= 0 && _column + 1 <= 7) {
				if (checkerBoard[_row - 1][_column + 1] == 0 && !_inJumpChain) { 
					storeValidMove(_row: _row - 1, _column: _column + 1)
				} else if (checkerBoard[_row - 1][_column + 1] == 1 && _row - 2 >= 0 && _column + 2 <= 7 && checkerBoard[_row - 2][_column + 2] == 0) {
					storeValidMove(_row: _row - 2, _column: _column + 2)
				}
			}
		}
	}

	func checkIfMoveIsValidMove(_row: Int, _column: Int) -> Bool {
		for index in 0...1 {
			if validMoves[index][0] == _row && validMoves[index][1] == _column {
				return true;
			}
		}	
		return false;
	}

	func printValidMoves(_inJumpChain: Bool) -> Bool {
		if validMoves[0][0] == -1 && !_inJumpChain {
			print("No valid moves for this checker")
			return false
		} else if validMoves[0][0] == -1 && _inJumpChain{
			print("No further jumps available")
			return false
		}
	
		print("Valid moves are: ")
		for index in 0...1 {
			if validMoves[index][0] != -1 {
				print(validMoves[index][0],"-", validMoves[index][1])
			}	
		}
		return true
	}

	var inJumpChain = false
	
	repeat {
		if inJumpChain {
			printBoard()
		}
		
		validMoves = [[-1,-1],[-1,-1]]
		checkMove(_row: checkerRow, _column: checkerColumn, _inJumpChain: inJumpChain)
		
		moveInvalid = true
		stayInLoop = true
		var moveRow = -1
		var moveColumn = -1
		var jumpedRow = -1
		var jumpedColumn = -1
		let gotValidMoves = printValidMoves(_inJumpChain: inJumpChain)
		
		if !gotValidMoves && !inJumpChain { //no valid moves not in a jump chain choose a new checker to move no turn change
			return
		} else if !gotValidMoves && inJumpChain { //end of jump chain no valid moves left TURN CHANGE
			inJumpChain = false
		} else { //valid move exists
			while (moveInvalid) {
				stayInLoop = true
				while (stayInLoop) {
					print("What row will your checker end it's move on (0-7):")
					if let checkRow = Int(readLine()!) {
						if (checkRow <= 7 && checkRow >= 0 ) {
							stayInLoop = false		
							moveRow = checkRow
						} else {
							print("Must be between 0-7")
						}
					} else {
						print("Must be between 0-7")
					}
				}

				stayInLoop = true
				while (stayInLoop) {
					print("What column will your checker end it's move on (0-7):")
					if let checkColumn = Int(readLine()!) {
						if checkColumn <= 7 && checkColumn >= 0 {
							stayInLoop = false
							moveColumn = checkColumn
						} else {
							print("Must be between 0-7")
						}
					} else {
						print("Must be between 0-7")
					}
				}
				
				if checkIfMoveIsValidMove(_row: moveRow, _column: moveColumn) {
					print("Valid move to: ", moveRow, "-", moveColumn)
					moveInvalid = false;
				}
				else{
					print("Invalid move: ", moveRow, "-", moveColumn)
				}
			}
			
			checkerBoard[moveRow][moveColumn] = move
			checkerBoard[checkerRow][checkerColumn] = 0
				
			if moveRow - checkerRow == 2 || moveRow - checkerRow == -2 {				
				jumpedRow = checkerRow + 1
				jumpedColumn = checkerColumn - 1
			}
			else if checkerRow == moveRow - 2 && checkerColumn == moveColumn - 2 {
				jumpedRow = checkerRow + 1
				jumpedColumn = checkerColumn + 1
			}
			else if checkerRow == moveRow + 2 && checkerColumn == moveColumn - 2 {
				jumpedRow = checkerRow - 1
				jumpedColumn = checkerColumn + 1
			}
			else if checkerRow == moveRow + 2 && checkerColumn == moveColumn + 2 {
				jumpedRow = checkerRow - 1
				jumpedColumn = checkerColumn - 1
			}
			
			if jumpedRow != -1 && jumpedColumn != -1 {
				checkerBoard[jumpedRow][jumpedColumn] = 0
				inJumpChain = true
			} else {
				inJumpChain = false
			}
		}	
	} while inJumpChain
	
	if move == 1 {
		move = 2
	}
	else {
		move = 1
	}
}


var keepAsking = true
while keepAsking {
    askAndMakeMove()
    print("Would you like to make another move? Y/N")
    let answer = String(readLine()!)
    if answer == "N" {
        keepAsking = false
    }
}  

//erase the current file
if let fileURLDelete = dir?.appendingPathComponent(fileName).appendingPathExtension("txt") {
	do {
		try FileManager.default.removeItem(at: fileURLDelete)
	} catch let error as NSError {
		print("Error: \(error.domain)")
	}
}

// If the directory was found, we write a file to it and read it back
if let fileURL2 = dir?.appendingPathComponent(fileName).appendingPathExtension("txt") {

	var stringCheckerBoard = String()
	for i in 0...7 {
		for j in 0...7 {
			stringCheckerBoard = stringCheckerBoard + String(checkerBoard[i][j]) + "\n"
		}
	}
	stringCheckerBoard = stringCheckerBoard + String(move)

    // Write to the file named Test
    do {
        try stringCheckerBoard.write(to: fileURL, atomically: true, encoding: .utf8)
    } catch {
        print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
    }
}
