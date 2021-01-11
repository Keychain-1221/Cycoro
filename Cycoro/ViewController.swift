//
//  ViewController.swift
//  Cycoro
//
//  Created by Keita Yamada on 2020/11/29.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var diceLeft: UIImageView!
    @IBOutlet weak var diceRight: UIImageView!
    @IBOutlet weak var numberOfDice: UISegmentedControl!
    let diceArray = [
        UIImage(named: "Cycoro-One.png"),
        UIImage(named: "Cycoro-Two.png"),
        UIImage(named: "Cycoro-Three.png"),
        UIImage(named: "Cycoro-Four.png"),
        UIImage(named: "Cycoro-Five.png"),
        UIImage(named: "Cycoro-Six.png")
    ]
    let shakingTime = 0.5
    var selectedDiceAmount: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        giveDiceRadius()
        diceManagement()
    }
    
    func giveDiceRadius() {
        diceLeft.layer.cornerRadius = 8.0
        diceRight.layer.cornerRadius = 8.0
    }
    
    @IBAction func rollDice(_ sender: UIButton) {
        shake(view: diceLeft)
        shake(view: diceRight)
        DispatchQueue.main.asyncAfter(deadline: .now() + shakingTime) {
            self.updateDiceUI()
        }
    }
    
    func shake(view: UIView, for duration: TimeInterval = 0.5, withTranslation translation: CGFloat = 10) {
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            view.transform = CGAffineTransform(translationX: translation, y: 0)
        }
        propertyAnimator.addAnimations({view.transform = CGAffineTransform(translationX: 0, y: 0)}, delayFactor: 0.2)
        propertyAnimator.startAnimation()
    }
    
    @IBAction func changeNumberOfDice(_ sender: Any) {
        selectedDiceAmount = numberOfDice.selectedSegmentIndex
        diceManagement()
    }
    
    func diceManagement() {
        if selectedDiceAmount == 0 {
            diceRight.isHidden = true
//            diceLeft.layer.position.x = CGFloat(UIScreen.main.bounds.width / 2)
        } else if selectedDiceAmount == 1 {
            diceRight.isHidden = false
        }
        
    }
    
    
    func updateDiceUI() {
        diceLeft.image = diceArray.randomElement()!!
        diceRight.image = diceArray.randomElement()!!
    }
    
    
    
}

