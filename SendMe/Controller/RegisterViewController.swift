//
//  RegisterViewController.swift
//  SendMe
//
//  Created by Alexandr on 2/4/19.
//  Copyright © 2019 Alex.Ltd. All rights reserved.
//
//  This is the View Controller which registers new users with Firebase
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        configureTextFields()
    }

    //MARK:- TextField Delegate Methods

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if let nextTextField = emailTextField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            createNewUser()
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


    @IBAction func registerPressed(_ sender: Any) {

        if (passwordTextField.text?.count)! <= 5 {

            let alertMessage = UIAlertController(title: "Ooops", message: "Your password is too short, it has to contain at least 6 characters", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)

            alertMessage.addAction(okAction)
            present(alertMessage, animated: true, completion: nil)
            SVProgressHUD.dismiss()
        }

        SVProgressHUD.show()
        
        //MARK: Creating a new user on Firebase database

        createNewUser()


    }

    func createNewUser() {

        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in

            if error != nil {
                SVProgressHUD.dismiss()
                print(error!)
            } else {
                print("Registration successful")
                SVProgressHUD.dismiss()

                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }

    }




}
