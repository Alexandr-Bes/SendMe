//
//  ChatViewController.swift
//  SendMe
//
//  Created by Alexandr on 2/4/19.
//  Copyright © 2019 Alex.Ltd. All rights reserved.
//


import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    var kbHeight: CGFloat = 0
    var valueToAddToKeyboardHeight : CGFloat = 0
    let device = UIDevice().name

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageTableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()


        messageTableView.delegate = self
        messageTableView.dataSource = self

        messageTextField.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)

        //Register for CustomMessageCell.xib
        messageTableView.register(UINib(nibName: "CustomMessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")

        configureTableView()

    
    }


    @objc func keyboardWillShow(_ notification: Notification) {

        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {

            let keyboardRectangle = keyboardFrame.cgRectValue
            kbHeight = keyboardRectangle.height
            print("\(kbHeight)")

            switch device {
            case "iPhone X": valueToAddToKeyboardHeight = 15
            case "iPhone XR": valueToAddToKeyboardHeight = 15
            case "iPhone XS": valueToAddToKeyboardHeight = 15
            case "iPhone XS Max": valueToAddToKeyboardHeight = 15
            default:
                valueToAddToKeyboardHeight = 50
            }

            UIView.animate(withDuration: 0.4) {
                self.heightConstraint.constant = self.kbHeight + self.valueToAddToKeyboardHeight
                self.view.layoutIfNeeded()
            }
        }

    }

    //MARK: - TableView DataSource Methods

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell

        let messageArray = ["First message", "Second 34234jrjgfkgkjkgsjdfkgjkfdjgfdslkjmessageejfefejkfjekwfjklejkfjekljfkejkjflkwjklfjkew", "Third message"]
        cell.messageBody.text = messageArray[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    @objc func tableViewTapped() {
        messageTextField.endEditing(true)
    }


    //TODO: Declare configureTableView here:
    func configureTableView() {
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }


    ///////////////////////////////////////////

    //MARK:- TextField Delegate Methods


    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.4) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }

    ///////////////////////////////////////////


    //MARK: - Send & Recieve from Firebase



    @IBAction func sendPressed(_ sender: Any) {

        //TODO: Send the message to Firebase and save it in our database
    }

    //TODO: Create the retrieveMessages method here:




    @IBAction func logOutPressed(_ sender: Any) {

        do {
            try Auth.auth().signOut()
        }
        catch {
            print("Error, there was a problem signing out")
        }

        guard(navigationController?.popToRootViewController(animated: true)) != nil
            else {
                print("No VC to pop-off")
                return

        }
    }

}
