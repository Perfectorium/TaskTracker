//
//  LoginViewController.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 23.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    // MARK: - Actions
    
    
    @IBAction func loginButtonDidPressed(_ sender: Any) {
        
    }
    
    
    
    static func storyboardInstance() -> LoginViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? LoginViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Validation
    
    
    func inputIsValid() -> Bool {
        
        let emailIsValid = validateEmail()
        let passIsValid = validatePassword()
        
        return emailIsValid && passIsValid
    }
    
    func validateEmail() -> Bool {
        guard let emailText = emailTextField.text else {
            return false
        }
        if emailText.isValidEmail() {
            return true
        }
        else {
            return false
        }
    }
    
    func validatePassword() -> Bool {
        guard let passwordText = passwordTextField.text else {
            return false
        }
        if passwordText.isValidPassword() {
            return true
        }
        else {
            return false
        }
    }
    
}
