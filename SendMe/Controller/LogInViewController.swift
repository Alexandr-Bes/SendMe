//
//  LogInViewController.swift
//  SendMe
//
//  Created by Alexandr on 2/4/19.
//  Copyright © 2019 Alex.Ltd. All rights reserved.
//
//  This is the view controller where users login

import UIKit
import Firebase
import SVProgressHUD

class LogInViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

       configureTextFields()
    }


    //MARK:- TextField Delegate Methods

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if let nextField = emailTextField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            logIn()
        }
        
        return false
    }

    
    func configureTextFields() {

        passwordTextField.returnKeyType = .go
        emailTextField.returnKeyType = .next
        emailTextField.delegate = self
        passwordTextField.delegate = self

        emailTextField.tag = 0
        passwordTextField.tag = 1
    }


    @IBAction func logInPressed(_ sender: Any) {

        logIn()

    }

    func logIn() {

        SVProgressHUD.show()

        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in

            if error != nil {

                let alertMessage = UIAlertController(title: "Sorry", message: "Wrong email or password", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)

                alertMessage.addAction(okAction)
                self.present(alertMessage, animated: true
                    , completion: nil)

                SVProgressHUD.dismiss()
                print(error!)
            } else {
                print("Log In successful")
                SVProgressHUD.dismiss()

                self.performSegue(withIdentifier: "goToChat", sender: self)
            }

        }
    }



}
