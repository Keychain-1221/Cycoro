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
    @IBOutlet var backgroundView: UIImageView!
    @IBOutlet var rollButton: UIButton!
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
    var colorNumber = 0
    let colorArray = [
        UIColor.systemTeal.cgColor,
        UIColor.systemGreen.cgColor,
        UIColor.systemRed.cgColor,
        UIColor.systemYellow.cgColor,
        UIColor.systemIndigo.cgColor,
        UIColor.systemPink.cgColor,
        UIColor.systemOrange.cgColor,
        UIColor.systemBlue.cgColor,
        UIColor.systemGray.cgColor,
    ]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        giveDiceRadius()
        diceManagement()
        colorNumber = defaults.integer(forKey: "color")
        backgroundView.layer.backgroundColor = colorArray[colorNumber]
        
        rollButton.layer.backgroundColor = UIColor.white.cgColor
        rollButton.layer.cornerRadius = 30
        rollButton.layer.masksToBounds = false
        rollButton.layer.borderWidth = 1
        rollButton.layer.borderColor = UIColor.systemGray4.cgColor
//        rollButton.layer.shadowColor = UIColor.black.cgColor
//        rollButton.layer.shadowOpacity = 0.5
//        rollButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//        rollButton.layer.shadowRadius = 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        defaults.set(colorNumber, forKey: "color")
    }
    
    func giveDiceRadius() {
        diceLeft.layer.cornerRadius = 8.0
        diceRight.layer.cornerRadius = 8.0
    }
    
    @IBAction func rollDice(_ sender: Any) {

//        animateButton(sender: rollButton)
        shake(view: diceLeft)
        shake(view: diceRight)
        DispatchQueue.main.asyncAfter(deadline: .now() + shakingTime) {
            self.updateDiceUI()
        }
    }
    

    
//    func moveButton(view: UIButton, for duration: TimeInterval = 0.2, withTranslation translation: CGFloat = 3) {
//        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
//            view.transform = CGAffineTransform(translationX: 0, y: translation)
//        }
//        propertyAnimator.addAnimations({view.transform = CGAffineTransform(translationX: 0, y: 0)}, delayFactor: 0.2)
//        propertyAnimator.startAnimation()
//
//    }
    
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
    
    @IBAction func changeColor(_ sender: UIButton) {
        if colorNumber < colorArray.count - 1 {
            colorNumber += 1
        } else if colorNumber == colorArray.count - 1 {
            colorNumber = 0
        }
        backgroundView.layer.backgroundColor = colorArray[colorNumber]
//        rollButton.layer.backgroundColor = colorArray[colorNumber]

    }
    
    
    
}

