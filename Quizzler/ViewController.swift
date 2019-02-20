//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressBar: UIView!
    
    //Place your instance variables here
    let questionBank = QuestionBank();
    var curQuestionIndex: Int = 0;
    var curScore: Int = 0;
    
    let PREFIX_SCORE: String = "Score: ";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI();
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        let pickedAnswer = sender.tag == 1;
        
        checkAnswer(upPickedAnswer: pickedAnswer);
        
        nextQuestion();
    }
    
    func updateUI() {
        let q = questionBank.questions[curQuestionIndex];
        questionLabel.text = q.questionText;
        
        scoreLabel.text = PREFIX_SCORE + String(curScore);
        progressLabel.text = "\(curQuestionIndex + 1) / \(questionBank.questions.count)";

        let progBarWidth = self.view.frame.width / CGFloat(questionBank.questions.count) * CGFloat(curQuestionIndex + 1);
        progressBar.frame.size.width = progBarWidth;
    }

    func nextQuestion() {
        if ( curQuestionIndex >= (questionBank.questions.count - 1) ) {
            let alert = UIAlertController.init(title: "Awesome", message: "You've finished all the questions, do you want to start over?", preferredStyle: .alert);
            let actRestart = UIAlertAction(title: "Restart", style: .default, handler: {
                (UIAlertAction) in
                
                self.startOver();
                
            })
            alert.addAction(actRestart);
            
            present(alert, animated: true, completion: nil);
            
        } else {
            curQuestionIndex += 1;
        }
    
        updateUI();
    }
    
    func checkAnswer(upPickedAnswer: Bool) {
        let correctAnswer = questionBank.questions[curQuestionIndex].answer;
        
        
        curScore = correctAnswer == upPickedAnswer ? (curScore + 1) : curScore;
    }
    
    func startOver() {
        curScore = 0;
        curQuestionIndex = 0;
        
        updateUI();
    }

    
}
