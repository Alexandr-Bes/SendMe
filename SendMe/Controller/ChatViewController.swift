//
//  ChatViewController.swift
//  SendMe
//
//  Created by Alexandr on 2/4/19.
//  Copyright © 2019 Alex.Ltd. All rights reserved.
//


import UIKit
import Firebase
import ChameleonFramework

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    var kbHeight: CGFloat = 0
    var valueToAddToKeyboardHeight : CGFloat = 0
    let device = UIDevice().name
    var messageArray: [Message] = [Message]()


    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageTableView: UITableView!


    //MARK: - Lifecycle methods

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
        retrieveMessages()
        messageTableView.separatorStyle = .none
        messageTableView.allowsSelection = false
    }


    @objc func keyboardWillShow(_ notification: Notification) {

        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {

            let keyboardRectangle = keyboardFrame.cgRectValue
            kbHeight = keyboardRectangle.height

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

        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        cell.avatarImageView.image = UIImage(named: "n-avatar")

        if cell.senderUsername.text == Auth.auth().currentUser?.email! {

            //Messages I sent
            cell.avatarImageView.backgroundColor = UIColor.flatBrown()
            cell.messageBackground.backgroundColor = UIColor.flatCoffee()
        } else {

            //Another user sent a message
            cell.avatarImageView.backgroundColor = UIColor.flatLime()
            cell.messageBackground.backgroundColor = UIColor.flatPurple()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }

    @objc func tableViewTapped() {
        messageTextField.endEditing(true)
    }


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

        sendButton.isEnabled = false

        let messagesDB = Database.database().reference().child("Messages")
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email, "MessageBody": messageTextField.text!]

        messagesDB.childByAutoId().setValue(messageDictionary) {
            (error, reference) in

            if error != nil {
                print(error!)
            } else {
                print("Message sent succesfully")
                self.messageTextField.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextField.text = ""
            }

        }
    }


    func retrieveMessages() {

        let messageDB = Database.database().reference().child("Messages")

        messageDB.observe(.childAdded) { (snapshot) in

            let snapshotValue = snapshot.value as! Dictionary<String, String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!

            let message = Message()
            message.messageBody = text
            message.sender = sender

            self.messageArray.append(message)
            self.messageTableView.reloadData()

            if self.messageArray.count-1 > 0 {
                self.messageTableView.scrollToRow(at: IndexPath(row: self.messageArray.count-1, section: 0), at: .bottom, animated: false)
            }

            self.configureTableView()
        }
    }


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
