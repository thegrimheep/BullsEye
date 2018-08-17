//
//  ViewController.swift
//  BullsEye
//
//  Created by David Porter on 6/7/18.
//  Copyright © 2018 David Porter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Instance variables exist the duration of the object they are in.
    var currentValue = 0
    var score = 0
    var currentRound = 0
    var targetValue = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var totalScore: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(slider.value)
        currentRound = 0
        
        startNewRound()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackImageLeft = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackImageLeft.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackImageRight = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackImageRight.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    //update labels for now update the target value the player is trying to hit.
    func updateLabels() {
        targetLabel.text = String(targetValue)
        totalScore.text = String(score)
        roundLabel.text = String(currentRound)
    }
    
    //I am resetting the target value each time the user starts a new round.
    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        currentRound = 1 + currentRound
        slider.value = Float(currentValue)
        
        updateLabels()
    }
    
    func startNewGame() {
        currentRound = 0
        score = 0
        
        startNewRound()
    }
    
    //Slider action defined here, get the numerical value of the sliders position.
    @IBAction func sliderMoved(_ slider: UISlider) {
        print("The value of the slider is now: \(slider.value)")
        currentValue = lroundf(slider.value)
    }
    
    //Start Over Button is tapped
    @IBAction func startOverButton(_ sender: Any) {
        startNewGame()
    }
    
    //Hit me buttome tapped
    @IBAction func showAlert() {
        
        //        if this thing is true {
        //            then do this
        //        } else if this is true {
        //            then do this instead
        //        } else {
        //            do this thing else if neither of the above are true
        //        }
        
        //var is the difference between the target and the current value
        //the if statement gets the difference of the values and sets it to the difference value.
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        //this gives the player a customer message based on their result
        let title: String
        if difference == 0 {
            title = "On the money"
            points += 100  //give the player 100 bonus points for perfect score.
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close, Brah!"
        }
        
        score += points
        
        //displays the target and the sliders actual value.
        let message = "The Bull's Eye is on \(lroundf(slider.value)) which gives you \(points) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Again", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    //the local variables are restricted to this method. They stop when this is complete.
}

