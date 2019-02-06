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

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func registerPressed(_ sender: Any) {

         //MARK: Creating a new user on Firebase database

        if (passwordTextField.text?.count)! <= 5 {

            let alertMessage = UIAlertController(title: "Ooops", message: "Your password is too short, it has to contain at least 6 characters", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)

            alertMessage.addAction(okAction)
            present(alertMessage, animated: true, completion: nil)

        }

        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in

            if error != nil {
                print(error!)
            } else {
                print("Registration is successful")

                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }

    }





}
