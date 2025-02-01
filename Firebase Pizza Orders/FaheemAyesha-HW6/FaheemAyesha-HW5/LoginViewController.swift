//
//  LoginViewController.swift
//  FaheemAyesha-HW5
//
//  Created by Ayesha Faheem on 10/19/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var segCtrl: UISegmentedControl!
    @IBOutlet weak var userIDTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    @IBOutlet weak var confirmPassLabel: UILabel!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var stausLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmPassLabel.isHidden = true
        confirmPassTF.isHidden = true
        signinButton.setTitle("Sign In", for: .normal)
        stausLabel.text = ""
        passwordTF.isSecureTextEntry = true
        confirmPassTF.isSecureTextEntry = true
        
    }
    
    @IBAction func onSegmentChange(_ sender: Any) {
        switch segCtrl.selectedSegmentIndex {
        case 0: // Log In
            confirmPassLabel.isHidden = true
            confirmPassTF.isHidden = true
            signinButton.setTitle("Sign In", for: .normal)
        case 1: // Sign Up
            confirmPassLabel.isHidden = false
            confirmPassTF.isHidden = false
            signinButton.setTitle("Sign Up", for: .normal)
        default:
            break
        }
    }
    
    
    @IBAction func signin(_ sender: Any) {
        if signinButton.currentTitle == "Sign Up" {
            if passwordTF.text != confirmPassTF.text {
                self.stausLabel.text = "Passwords Don't Match"
            } else {
                Auth.auth().createUser(withEmail: userIDTF.text!, password: passwordTF.text!) {
                    (authResult, error) in
                    if let error = error as NSError? {
                        self.stausLabel.text = "\(error.localizedDescription)"
                    } else {
                        self.stausLabel.text = ""
                    }
                }
            }
        }
        
        if signinButton.currentTitle == "Sign In" {
            Auth.auth().signIn(withEmail: userIDTF.text!, password: passwordTF.text!) {
                [self] (authResult, error) in
                if let error = error as NSError? {
                    self.stausLabel.text = "\(error.localizedDescription)"
                } else {
                    self.stausLabel.text = ""
                    
                    performSegue(withIdentifier: "LoginSegue", sender: self)
                }
            }
        }
        
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
