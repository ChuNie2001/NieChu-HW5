//
//  LoginViewController.swift
//  NieChu-HW5
//
//  Created by Chu Nie on 10/21/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController{
    
    @IBOutlet weak var loginSignup: UISegmentedControl!
    @IBOutlet weak var userIDText: UITextField!
    @IBOutlet weak var pswrdText: UITextField!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var confirmPaswrdLabel: UILabel!
    @IBOutlet weak var confirmPswrdText: UITextField!
    
    var indicator = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = ""
        confirmPaswrdLabel.text = ""
        confirmPswrdText.isHidden = true
        pswrdText.isSecureTextEntry = true

    }
    
    @IBAction func loginSignupSegment(_ sender: Any) {
        switch loginSignup.selectedSegmentIndex {
        case 0:
            self.userIDText.text = nil
            self.pswrdText.text = nil
            confirmPswrdText.text = nil
            signButton.setTitle("Sign in", for: .normal)
            confirmPswrdText.isHidden = true
            confirmPaswrdLabel.text = ""
            indicator = 0
            statusLabel.text = ""

        case 1:
            signButton.setTitle("Sign up", for: .normal)
            confirmPaswrdLabel.text = "Confirm Password"
            confirmPswrdText.isHidden = false
            confirmPswrdText.isSecureTextEntry = true
            indicator = 1

            self.userIDText.text = nil
            self.pswrdText.text = nil
            statusLabel.text = ""
        
        default:
            signButton.setTitle("Sign in", for: .normal)
            confirmPaswrdLabel.text = ""
            confirmPswrdText.isHidden = true
            indicator = 0
        }
    }
    
    @IBAction func signButtonPressed(_ sender: Any) {
        
        if indicator == 0{
            Auth.auth().signIn(withEmail: userIDText.text!, password: pswrdText.text!) {
                authResult, error in
                if let error = error as NSError? {
                    self.statusLabel.text = "\(error.localizedDescription)"
                    self.statusLabel.numberOfLines = 4
                    self.statusLabel.lineBreakMode = .byWordWrapping
                } else {
                    self.confirmPswrdText.isHidden = true
                    self.statusLabel.numberOfLines = 4
                    self.statusLabel.text = "You're logged in!"
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                    self.userIDText.text = nil
                    self.pswrdText.text = nil
                }
            }
            
        }else if indicator == 1{
            if pswrdText.text == confirmPswrdText.text {
                Auth.auth().createUser(withEmail: userIDText.text!, password: pswrdText.text!){
                    authResult, error in
                    if let error = error as NSError? {
                        self.statusLabel.numberOfLines = 4
                        self.statusLabel.lineBreakMode = .byWordWrapping
                        self.statusLabel.text = "\(error.localizedDescription)"
                    }else{
                        self.confirmPswrdText.text = nil
                        self.userIDText.text = nil
                        self.pswrdText.text = nil
                        self.statusLabel.text = "You're signed up!"
                    }
                }
            }else {
                self.statusLabel.text = "Password does not match!"
            }
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard statusLabel.text == "You're logged in!"else {
            return false
        }
        return true
    }

}
