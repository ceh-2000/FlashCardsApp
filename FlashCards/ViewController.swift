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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontLabel.isHidden=true
    }
    
    
}

