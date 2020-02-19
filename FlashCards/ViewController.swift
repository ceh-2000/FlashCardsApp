//
//  ViewController.swift
//  FlashCards
//
//  Created by Clare Heinbaugh on 2/15/20.
//  Copyright © 2020 Clare Heinbaugh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOption1: UIButton!
    @IBOutlet weak var btnOption2: UIButton!
    @IBOutlet weak var btnOption3: UIButton!
    
    @IBOutlet weak var plusBtn: UIButton!
    var number = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up the question and answer
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        //set up the multiple choice options
        btnOption1.layer.borderWidth = 3.0
        btnOption1.layer.borderColor = #colorLiteral(red: 0.3518381119, green: 0.8115496039, blue: 1, alpha: 1)
        btnOption2.layer.borderWidth = 3.0
        btnOption2.layer.borderColor = #colorLiteral(red: 0.3518381119, green: 0.8115496039, blue: 1, alpha: 1)
        btnOption3.layer.borderWidth = 3.0
        btnOption3.layer.borderColor = #colorLiteral(red: 0.3518381119, green: 0.8115496039, blue: 1, alpha: 1)
        btnOption1.layer.cornerRadius = 20.0
        btnOption1.clipsToBounds = true
        btnOption2.layer.cornerRadius = 20.0
        btnOption2.clipsToBounds = true
        btnOption3.layer.cornerRadius = 20.0
        btnOption3.clipsToBounds = true

        //plus button
        plusBtn.layer.borderWidth = 3.0
        plusBtn.layer.borderColor = #colorLiteral(red: 0.3518381119, green: 0.8115496039, blue: 1, alpha: 1)
        plusBtn.layer.cornerRadius = 20.0
        plusBtn.clipsToBounds = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                    let navigationController = segue.destination as! UINavigationController

                    let creationController = navigationController.topViewController as! CreationViewController

                    creationController.flashcardsController = self

    }

    @IBAction func didTapOption1(_ sender: Any) {
        if(number == 0){
            frontLabel.isHidden = true
        }
    }
    
    @IBAction func didTapOption2(_ sender: Any) {
        if(number == 1){
            frontLabel.isHidden = true
        }
    }
    
    @IBAction func didTapOption3(_ sender: Any) {
        if(number == 2){
            frontLabel.isHidden = true
        }
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if(frontLabel.isHidden == true){
            frontLabel.isHidden = false
        }
    }
    
    func updateFlashcard(question: String, answer: String, o1: String, op2: String){
        
        frontLabel.text = question
        backLabel.text = answer
        number = Int.random(in: 0 ..< 3)
        if(number == 0){
            btnOption1.setTitle(answer, for: .normal)
            btnOption2.setTitle(o1, for: .normal)
            btnOption3.setTitle(op2, for: .normal)

        }
        
        else if(number == 1){
            btnOption2.setTitle(answer, for: .normal)
            btnOption3.setTitle(o1, for: .normal)
            btnOption1.setTitle(op2, for: .normal)
        }
        else{
            btnOption3.setTitle(answer, for: .normal)
            btnOption1.setTitle(o1, for: .normal)
            btnOption2.setTitle(op2, for: .normal)
        }
        frontLabel.isHidden = false

    }
    
    
}

