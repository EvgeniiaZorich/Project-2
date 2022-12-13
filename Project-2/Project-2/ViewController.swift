//
//  ViewController.swift
//  Project-2
//
//  Created by Евгения Зорич on 09.12.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    
    @IBOutlet var button2: UIButton!
    
    @IBOutlet var button3: UIButton!
    
    
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var numberOfQuestion = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) | Score: \(score) | Question: \(numberOfQuestion)/10"
        
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            numberOfQuestion += 1
        } else {
            var answear = sender.tag
            title = "Wrong. That’s the flag of \(countries[answear])"
            score -= 1
            numberOfQuestion += 1
        }
        
    if numberOfQuestion == 11 {
        let finish = UIAlertController(title: title, message: "Game over. Your final score is \(score).", preferredStyle: .alert)
        finish.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(finish, animated: true)
        numberOfQuestion = 0
        return
    }
        
    let ab = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        
    ab.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ab, animated: true)
    }
    
}

