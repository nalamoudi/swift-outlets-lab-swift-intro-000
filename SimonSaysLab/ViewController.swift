//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.isHidden = true
    }
    
    @IBAction func redButton(_ sender: Any) {
        simonSaysGame.guessRed()
        playingGame()
        }
    
    
    @IBAction func greenButton(_ sender: Any) {
        simonSaysGame.guessGreen()
        playingGame()
    }
    @IBAction func yellowButton(_ sender: Any) {
        simonSaysGame.guessYellow()
        playingGame()
    }
    @IBAction func blueButton(_ sender: Any) {
        simonSaysGame.guessBlue()
        playingGame()
    }
    
    func playingGame() {
        buttonsClicked += 1
        if buttonsClicked == 5 {
            if simonSaysGame.wonGame() == true {
                winLabel.text = "You won!"
                winLabel.isHidden = false
                buttonsClicked = 0
            } else if simonSaysGame.wonGame() == false {
                winLabel.text = "Nope, try again."
                winLabel.isHidden = false
                buttonsClicked = 0
            }
        }
    }
    
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        winLabel.text = "Playing..."
        winLabel.isHidden = false
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        displayTheColors()
    }
    
    fileprivate func displayTheColors() {
        self.view.isUserInteractionEnabled = false
        UIView.transition(with: displayColorView, duration: 1.5, options: .transitionCurlUp, animations: {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
            }, completion: { _ in
                if !self.simonSaysGame.sequenceFinished() {
                    self.displayTheColors()
                } else {
                    self.view.isUserInteractionEnabled = true
                    print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                }
        })
    }
}
