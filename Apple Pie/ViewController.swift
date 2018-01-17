//
//  ViewController.swift
//  Apple Pie
//
//  Created by Student on 1/4/18.
//  Copyright © 2018 Jamie Chavez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//List of words to guess
    var listOfWords = ["apple","boomerang","golden","rythm","hannahmontanna","beyonce"]
    
//Establishes how many inccorect guesses are allowed per round
    let incorrectMovesAllowed = 7

//
    var totalCorrectLettersGuessed = 0
    
//Holds value of upadted wins
    var totalWins = 0{
        didSet{
            totalCorrectLettersGuessed = currentGame.correctGuess
            correctWord += 10
            newRound()
        }
    }
    
//Holds value of upadted losses
    var totalLosses = 0{
        didSet{
            newRound()
        }
    }
    
//Establishing the tree image
    @IBOutlet weak var treeImageView: UIImageView!
    
//Establishing the correct word label
    @IBOutlet weak var correctWordLabel: UILabel!
    
//Establishing the score label
    @IBOutlet weak var scoreLabel: UILabel!
    
//Establishing the actual score number
    @IBOutlet weak var scoreNumber: UILabel!
    
//Establishing the collection of letter buttons a-z
   @IBOutlet var letterButtons: [UIButton]!
    
// Allows the player to not select a letter more than once in the same round
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
// Updates the games state
        let letterString = sender.title(for:.normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }

//Enables or disables the collection of buttons
    func enableLetterButtons(_ enable: Bool){
        for button in letterButtons{
            button.isEnabled = enable
        }
    }
    
// Updates the games state
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord{
            totalWins += 1
        } else{
            updateUI()
        }
    }
    
//variable that holds the value for the completion of a correct word
    var correctWord = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//Starts a new round
        newRound()
    }
var currentGame: Game!
func newRound(){
    if !listOfWords.isEmpty {
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining:incorrectMovesAllowed, guessedLetters: [], correctGuess: 0)
        enableLetterButtons(true)
        updateUI()
    } else{
        enableLetterButtons(false)
    }
}
    //Updates the interface to reflect the new game
    func updateUI(){
        
        
//Converts array of characters to array of strings and uses the map method
        var letters = [String]()
        letters = currentGame.formattedWord.map({(value:Character) -> String in return String(value)
        })
//Allowes spaces between the underscores
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        scoreNumber.text = "Points for correct word guess:\(correctWord)     Points for correct letter guess: \(totalCorrectLettersGuessed)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

