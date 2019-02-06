//
//  ChatViewController.swift
//  SendMe
//
//  Created by Alexandr on 2/4/19.
//  Copyright © 2019 Alex.Ltd. All rights reserved.
//


import UIKit
import Firebase

class ChatViewController: UIViewController {



    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageTableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO: Set yourself as the delegate and datasource here:



        //TODO: Set yourself as the delegate of the text field here:



        //TODO: Set the tapGesture here:



        //TODO: Register your MessageCell.xib file here:


    
    }

    ///////////////////////////////////////////

    //MARK: - TableView DataSource Methods



    //TODO: Declare cellForRowAtIndexPath here:



    //TODO: Declare numberOfRowsInSection here:



    //TODO: Declare tableViewTapped here:



    //TODO: Declare configureTableView here:



    ///////////////////////////////////////////

    //MARK:- TextField Delegate Methods




    //TODO: Declare textFieldDidBeginEditing here:




    //TODO: Declare textFieldDidEndEditing here:



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
