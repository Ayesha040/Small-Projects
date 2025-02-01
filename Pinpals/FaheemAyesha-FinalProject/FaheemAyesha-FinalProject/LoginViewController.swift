//
//  LoginViewController.swift
//  FaheemAyesha-FinalProject
//
//  Created by Ayesha Faheem on 11/24/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subheadingLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var haveAccountLabel: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        titleLabel.text = "Login"
        subheadingLabel.text = "Please sign in to continue"
        confirmPasswordTF.isHidden = true
        confirmPasswordLabel.isHidden = true
        loginButton.setTitle("Login", for: .normal)
        statusLabel.isHidden = true
        signupButton.setTitle("Sign Up", for: .normal)
        passwordTF.isSecureTextEntry = true
        confirmPasswordTF.isSecureTextEntry = true
    }
    
    

    @IBAction func login(_ sender: Any) {
        //log in
        if loginButton.currentTitle == "Login" {
            Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) {
                [self] (authResult, error) in
                if let error = error as NSError? {
                    self.statusLabel.isHidden = false
                    self.statusLabel.text = "\(error.localizedDescription)"
                } else {
                    self.statusLabel.text = ""
                    performSegue(withIdentifier: "LoginSegue", sender: self)
                }
            }
        }
        
        //sign up
        if loginButton.currentTitle == "Sign Up" {
            if passwordTF.text != confirmPasswordTF.text {
                self.statusLabel.text = "Passwords Don't Match"
            } else {
                Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) {
                    [self](authResult, error) in
                    if let error = error as NSError? {
                        self.statusLabel.isHidden = false
                        self.statusLabel.text = "\(error.localizedDescription)"
                    } else {
                        UserDefaults.standard.set(emailTF.text, forKey: "username")
                        self.statusLabel.text = ""
                        performSegue(withIdentifier: "LoginSegue", sender: self)
                    }
                }
            }
        }
    }
    
    
    @IBAction func signup(_ sender: Any) {
        if signupButton.currentTitle == "Sign Up" {
            statusLabel.text = ""
            titleLabel.text = "Sign Up"
            subheadingLabel.text = "Please enter a valid email and password"
            haveAccountLabel.text = "Have an account?"
            signupButton.setTitle("Login", for: .normal)
            confirmPasswordTF.isHidden = false
            confirmPasswordLabel.isHidden = false
            loginButton.setTitle("Sign Up", for: .normal)
        } else if signupButton.currentTitle == "Login"{
            statusLabel.text = ""
            titleLabel.text = "Login"
            subheadingLabel.text = "Please sign in to continue"
            haveAccountLabel.text = "Don't have an account?"
            signupButton.setTitle("Sign Up", for: .normal)
            confirmPasswordTF.isHidden = true
            confirmPasswordLabel.isHidden = true
            loginButton.setTitle("Login", for: .normal)

        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
