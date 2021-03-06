//
//  CreationViewController.swift
//  FlashCards
//
//  Created by Clare Heinbaugh on 2/19/20.
//  Copyright © 2020 Clare Heinbaugh. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    var flashcardsController: ViewController!
    var initialQuestion: String?
    var initialAnswer: String?
    var initialOpt1: String?
    var initialOpt2: String?
    
    @IBOutlet weak var option1: UITextField!
    @IBOutlet weak var option2: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        option1.text = initialOpt1
        option2.text = initialOpt2

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        //get question text
        let questionText = questionTextField.text
        //get answer text
        let answerText = answerTextField.text
        //get option1
        let opt1 = option1.text
        //get option2
        let opt2 = option2.text
        
        //show error if parameters are incomplete
        let alert = UIAlertController(title: "Missing Text", message: "You need to fill in all fields.", preferredStyle: .alert)
        //can add multiple actions here but for now user just needs to press "Ok"
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        if(questionText == "" || answerText == "" || opt1 == "" || opt2==""){
            present(alert, animated: true)
        }
        else{
            //see if flashcard exists
            var isExisting = false
            if initialQuestion != nil
            {
                isExisting = true 
            }
            
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, o1: opt1!, op2: opt2!, isExisting: isExisting)
            dismiss(animated: true)
        }
        
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
