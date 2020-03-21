//
//  ViewController.swift
//  FlashCards
//
//  Created by Clare Heinbaugh on 2/15/20.
//  Copyright © 2020 Clare Heinbaugh. All rights reserved.
//

import UIKit

struct Flashcard{
    var question: String
    var answer: String
    var option1: String
    var option2: String
    
}

class ViewController: UIViewController {
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOption1: UIButton!
    @IBOutlet weak var btnOption2: UIButton!
    @IBOutlet weak var btnOption3: UIButton!
    
    @IBOutlet weak var plusBtn: UIButton!
    var number = 1
    var option1TEXT = "Strawberry Milk"
    var option2TEXT = "1% Milk"
    var answerText = "Hello"

    //Array to hold our flashcards
    var flashcards = [Flashcard]()
    
    //next and previous buttons
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    //Current flashcard index
    var currentIndex = 0
    
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
        
        //Read saved flashcards
        readSavedFlashcards()
        
        //set the initial question and answer on the flashcard if none saved
        if flashcards.count == 0{
            updateFlashcard(question: "What kind of milk is the best?", answer: "2% Milk", o1: "Strawberry Milk", op2: "1% Milk", isExisting: false)
        }
        else{
            updateLabels()
            updateNextPrevButtons()
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //first start with the flashcard invisible and slightly smaller in size
        card.alpha = 0.0
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        //animation
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                self.card.alpha = 1.0
                self.card.transform = CGAffineTransform.identity
        
        })
        
        //first start with the button 1 invisible and slightly smaller in size
        btnOption1.alpha = 0.0
        btnOption1.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        //animation
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                self.btnOption1.alpha = 1.0
                self.btnOption1.transform = CGAffineTransform.identity
        
        })
        
        //first start with the button 2 invisible and slightly smaller in size
        btnOption2.alpha = 0.0
        btnOption2.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        //animation
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                self.btnOption2.alpha = 1.0
                self.btnOption2.transform = CGAffineTransform.identity
        
        })
        
        //first start with the button 2 invisible and slightly smaller in size
        btnOption3.alpha = 0.0
        btnOption3.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        //animation
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                self.btnOption3.alpha = 1.0
                self.btnOption3.transform = CGAffineTransform.identity
        
        })
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController

        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self

        if segue.identifier == "EditSegue"{
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
            creationController.initialOpt1 = option1TEXT
            creationController.initialOpt2 = option2TEXT
        }
                    

    }

    @IBAction func didTapOption1(_ sender: Any) {
        if(number == 0){
            flipFlashcard()
        }
    }
    
    @IBAction func didTapOption2(_ sender: Any) {
        if(number == 1){
            flipFlashcard()
        }
    }
    
    @IBAction func didTapOption3(_ sender: Any) {
        if(number == 2){
            flipFlashcard()
        }
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if(frontLabel.isHidden == true){
            flipFlashcard()
        }
    }
    
    func flipFlashcard(){
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            if(self.frontLabel.isHidden == true){
                self.frontLabel.isHidden = false
            }
            else{
                self.frontLabel.isHidden = true
            }
        })
        
        
    }
    
    func updateFlashcard(question: String, answer: String, o1: String, op2: String, isExisting: Bool){
        let flashcard = Flashcard(question: question, answer: answer, option1: o1, option2: op2)
        
//        frontLabel.text = flashcard.question
//        backLabel.text = flashcard.answer
        option1TEXT = flashcard.option1
        option2TEXT = flashcard.option2
        
        if isExisting {
            
            //replace existing flashcard
            flashcards[currentIndex] = flashcard
            
        }
        else{
            flashcards.append(flashcard)
            print("Added a new flashcard. We new have \(flashcards.count) flashcards.")
            
            currentIndex = flashcards.count - 1
            
            print("Current index: \(currentIndex)")
        }
        

        
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
        
        //Update next and previous buttons
        updateNextPrevButtons()
        
        //Update labels
        updateLabels()
        
        saveAllFlashcardsToDisk()

    }
    
    
    
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        //decrease current index
        currentIndex = currentIndex - 1
        
        //update buttons
        updateNextPrevButtons()
        
        //animate switching cards
        animateCardOutPrev()
    }
    
    
    @IBAction func didTapOnNext(_ sender: Any) {
        //increase current index
        currentIndex = currentIndex + 1
        
        //update buttons
        updateNextPrevButtons()
        
        //animate switching cards
        animateCardOutNext()
    }
    
    func updateLabels(){
        //get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        //Update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        
        //ADD STUFF HERE TO SUPPORT MULTIPLE OPTIONS
        option1TEXT = currentFlashcard.option1
        option2TEXT = currentFlashcard.option2
        answerText = currentFlashcard.answer
        
        number = Int.random(in: 0 ..< 3)
        if(number == 0){
            btnOption1.setTitle(answerText, for: .normal)
            btnOption2.setTitle(option1TEXT, for: .normal)
            btnOption3.setTitle(option2TEXT, for: .normal)

        }
        
        else if(number == 1){
            btnOption2.setTitle(answerText, for: .normal)
            btnOption3.setTitle(option1TEXT, for: .normal)
            btnOption1.setTitle(option2TEXT, for: .normal)
        }
        else{
            btnOption3.setTitle(answerText, for: .normal)
            btnOption1.setTitle(option1TEXT, for: .normal)
            btnOption2.setTitle(option2TEXT, for: .normal)
        }
        frontLabel.isHidden = false

    }
    
    func updateNextPrevButtons(){
        
        //disable next button if at end
        if currentIndex == flashcards.count-1{
            nextButton.isEnabled = false
        }
        else{
            nextButton.isEnabled = true
        }
        
        //disable previous button if at beginning
        if currentIndex == 0{
            prevButton.isEnabled = false
        }
        else{
            prevButton.isEnabled = true
        }
    }
    
    func saveAllFlashcardsToDisk(){
        
        //can't just save arrays --> must convert to dictionary with mapping
        let dictionaryArray = flashcards.map { (card) -> [String:String] in
            return ["question": card.question, "answer":card.answer, "option1":card.option1, "option2":card.option2]
        }
        
        //save to user defaults
        UserDefaults.standard.set(dictionaryArray, forKey: "theFlashCards")
        
        //Log success
        print("Flashcards were saved! Yay!")
    }
    
    func readSavedFlashcards(){
        
        //Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "theFlashCards") as? [[String: String]] {
             
            //in here we know for sure we have a dictionary array
            let savedCards = dictionaryArray.map {dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, option1: dictionary["option1"]!, option2: dictionary["option2"]!)
            }
            
            //put all the cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    
    @IBAction func didTapOnDelete(_ sender: Any) {
    
        //show confirmation
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        
              
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.deleteCurrentFlashcard()
        })
        
        //remember to add the new action to the parent action
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(cancelAction)
        
        present(alert, animated: true)

    }
    
    func deleteCurrentFlashcard(){
        //Delete current flashcard
        
        if (currentIndex == -1 && flashcards.count==1){
            currentIndex = 0
        }
        else{
            
            flashcards.remove(at: currentIndex)

            //Special case to check if last card was deleted
            if currentIndex > flashcards.count - 1 {
                currentIndex = flashcards.count - 1
            }
            
            updateNextPrevButtons()
            
            updateLabels()
            
            saveAllFlashcardsToDisk()
        }

    }
    
    func animateCardOutNext(){
        //animate card flying out left
        UIView.animate(withDuration: 0.2, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }, completion: {finished in
            //update labels
            self.updateLabels()
            
            //call the other animation
            self.animateCardInNext()
        })
    }
    
    func animateCardInNext(){
        //start card on the right side (don't animate this)
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        
        //animate card going back to its original position
        UIView.animate(withDuration: 0.2, animations: {
            self.card.transform = CGAffineTransform.identity
        })
    }
    
    func animateCardOutPrev(){
        //animate card flying out right
        UIView.animate(withDuration: 0.2, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        }, completion: {finished in
            //update labels
            self.updateLabels()
            
            //call the other animation
            self.animateCardInPrev()
        })
    }
    
    func animateCardInPrev(){
        //start card on the left side (don't animate this)
        card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        
        //animate card going back to its original position
        UIView.animate(withDuration: 0.2, animations: {
            self.card.transform = CGAffineTransform.identity
        })
    }
    
}

