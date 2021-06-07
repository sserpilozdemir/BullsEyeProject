//
//  ViewController.swift
//  BullsEyeProject
//
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var targetLabel:  UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!

    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSlider()
        startNewRound()
    }
    
    func configureSlider() {
        let thumbImageNormal = UIImage(named:
                                        "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named:
                                                "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named:
                                        "SliderTrackLeft")!
        let trackLeftResizableImage = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizableImage, for: .normal)
        
    
        let trackRightImage = UIImage(named:
                                        "SliderTrackRight")!
        let trackRightResizableImage = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizableImage, for: .normal)
        
    }
    
    func startNewRound() {
        round += 1
        currentValue = 50
        slider.value = Float(currentValue)
        targetValue = Int.random(in: 1...100)
        updateLabel()
    }
    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    func updateLabel() {
        targetLabel.text = "\(targetValue)"
        scoreLabel.text = "\(score)"
        roundLabel.text = "\(round)"
    }
    
    
    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
                
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        }else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        }else if difference < 10 {
            title = "Pretty good"
        }else{
            title = "Not even close..."
        }
        
        
        score += points

        let message = "You scored \(points)"
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK",
                                   style: .default) { _ in
                                    self.startNewRound()
                                   }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }


}

