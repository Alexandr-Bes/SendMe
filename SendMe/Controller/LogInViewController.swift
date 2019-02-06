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

class LogInViewController: UIViewController {



    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func logInPressed(_ sender: Any) {

        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in

            if error != nil {
                print(error!)
            } else {
                print("Successful Log In!")

                self.performSegue(withIdentifier: "goToChat", sender: self)
            }

        }
        
    }
    
}
