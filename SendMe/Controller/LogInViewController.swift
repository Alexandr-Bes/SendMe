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

class LogInViewController: UIViewController {


    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func logInPressed(_ sender: Any) {

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
