//
//  SettingsViewController.swift
//  FaheemAyesha-FinalProject
//
//  Created by Ayesha Faheem on 11/24/23.
//

import UIKit
import MapKit
import FirebaseAuth


class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeProfileImage(_:)))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGestureRecognizer)
        profileImage.layer.cornerRadius = profileImage.bounds.width / 2 // make the image round
        profileImage.clipsToBounds = true
        if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
           let savedImage = UIImage(data: imageData) {
            profileImage.image = savedImage
        } else {
            let defaultImage = UIImage(named: "defaultpfp")
            profileImage.image = defaultImage
        }
        
        // Set the default username as the email used for signup
        if let email = UserDefaults.standard.string(forKey: "username") {
            usernameLabel.text = email
        }
        notificationSwitch.isOn = UserDefaults.standard.bool(forKey: "notificationEnabled")
        notificationSwitch.addTarget(self, action: #selector(notificationsSwitchChange(_:)), for: .valueChanged)
    }
    
    @IBAction func notificationsSwitchChange(_ sender: UISwitch) {
        if sender.isOn {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
            (granted, error) in
               DispatchQueue.main.async {
                   if granted {
                       print("All set!")
                       UserDefaults.standard.set(true, forKey: "notificationEnabled")
                   } else if let error = error {
                       print(error.localizedDescription)
                       sender.isOn = false
                       UserDefaults.standard.set(false, forKey: "notificationEnabled")
                   }
               }
           }
       } else {
           UserDefaults.standard.set(false, forKey: "notificationEnabled")
       }
    }
    
    
    @IBAction func changePhotoButtonPressed(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func changeProfileImage(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImage.image = pickedImage
            saveImageToUserDefaults(image: pickedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func saveImageToUserDefaults(image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(imageData, forKey: "profileImage")
        }
    }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func changeUsername(_ sender: Any) {
        let alertController = UIAlertController(title: "Change Username", message: "Enter your new username, this is the name your friends will see", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "New Username"
        }
        let changeAction = UIAlertAction(title: "Change", style: .default) { [weak self] _ in
            guard let username = alertController.textFields?.first?.text else { return }
            self?.updateUsername(username)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(changeAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func updateUsername(_ newUsername: String) {
        usernameLabel.text = newUsername
        UserDefaults.standard.set(newUsername, forKey: "username")
    }

    @IBAction func signout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let loginVC = self.storyboard?.instantiateViewController(identifier: "LoginViewController")
            loginVC?.modalPresentationStyle = .fullScreen
            self.present(loginVC!, animated: true, completion: {
                self.navigationController?.popToRootViewController(animated: false)
                self.tabBarController?.selectedIndex = 0
            })
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

