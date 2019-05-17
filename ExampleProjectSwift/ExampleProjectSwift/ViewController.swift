//
//  ViewController.swift
//  ExampleProjectSwift
//
//  Created by Иван on 5/17/19.
//  Copyright © 2019 Ivan. All rights reserved.
//

import UIKit
import ISKeystrokeDynamics

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textField: ISTextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    var kdrmh: ISKeystrokeDynamicsRecognitionModulesHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        kdrmh = ISKeystrokeDynamicsRecognitionModulesHandler(textField: textField)
        resetButton.layer.masksToBounds = true
        resetButton.layer.cornerRadius = 20
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userDidEnterPassword()
        return true;
    }
    
    func userDidEnterPassword() {
        textField.resignFirstResponder()
        if (textField.text == "TestPassword") {
            let result = kdrmh.startProcessing(withDataAmount: 12, andMode: .manhattanFiltered)
            if let number = result {
                if fabs(number.doubleValue) <= 65 {
                    resultLabel.text = "Real user!"
                } else if fabs(number.doubleValue) > 65 {
                    resultLabel.text = "Fake user!"
                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Wrong password!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            textField.text = String();
        }
    }
    
    @IBAction func resetFrameworkPressed(_ sender: Any) {
        kdrmh.resetData()
    }
    
}

