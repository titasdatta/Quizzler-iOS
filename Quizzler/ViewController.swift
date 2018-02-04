//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var currentQuestionIndex: Int = 0
    var score:Int = 0
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        pickedAnswer = sender.tag == 1 ? true : false
        
        checkAnswer()
        currentQuestionIndex += 1
        nextQuestion()
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(currentQuestionIndex + 1)/13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(currentQuestionIndex + 1)
    }
    

    func nextQuestion() {
        if currentQuestionIndex > 12 {
            
            let alert = UIAlertController(title: "Awesome!", message: "You've finished all the questions, do you want to start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
            })
            
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
            
        } else {
            questionLabel.text = allQuestions.list[currentQuestionIndex].questionText
            updateUI()
        }
    }
    
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[currentQuestionIndex].answer
        if correctAnswer == pickedAnswer {
            
            ProgressHUD.showSuccess("You got it!")
            score += 1
        }else {
            ProgressHUD.showError("Wrong!")
        }
    }
    
    
    func startOver() {
        
        currentQuestionIndex = 0;
        score = 0
        nextQuestion()
        
    }
    

    
}
