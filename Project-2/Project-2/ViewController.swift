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
    var topScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        
        let userDefaults = UserDefaults.standard
        topScore = userDefaults.object(forKey: "topScore") as? Int ?? 0
        print("Top score is", topScore)
        
        registerLocal()
        scheduleLocal()
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
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: [], animations: {
            sender.imageView?.transform = CGAffineTransform(scaleX: 0.1, y: 2)
        })
        
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
        if score <= topScore {
            let finish = UIAlertController(title: title, message: "Game over. Your final score is \(score).", preferredStyle: .alert)
            finish.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(finish, animated: true)
            numberOfQuestion = 0
            score = 0
            return
        } else {
            let finish = UIAlertController(title: title, message: "Game over. Your final score is \(score). It's a new record", preferredStyle: .alert)
            finish.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(finish, animated: true)
            topScore = score
            let userDefaults = UserDefaults.standard
            userDefaults.set(topScore, forKey: "topScore")
            
            numberOfQuestion = 0
            score = 0
            return
        }
    }
        
    let ab = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        
    ab.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ab, animated: true)
    }
    
    func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Yay!")
            } else {
                print("D'oh!")
            }
        }
    }
    
    func scheduleLocal() {
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Don not forget about flags"
        content.body = "It is time to learn"
        content.categoryIdentifier = "alarm"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
           center.add(request)
        }
    }

