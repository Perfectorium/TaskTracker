//
//  LoginViewController.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 23.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import UIKit

enum AuthType {
    case login
    case registration
}

class PFLoginViewController: UIViewController {
    
    
    // MARK: - Properties
    
    
    let authObject = PFAuthAdapter()
    let authType: AuthType? = nil
    
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    

    // MARK: - LifeCycle
    
    
    static func storyboardInstance() -> PFLoginViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? PFLoginViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupUI () {
        
    }
    
    func configurateAuthType() {
        
        
    }
    
    
    // MARK: - Actions
    
    
    @IBAction func loginButtonDidPressed(_ sender: Any) {
        
        if (inputIsValid()) {
            let email = emailTextField.text ?? ""
            let password = passwordTextField.text ?? ""
            authObject.signIn(withEmail: email,
                              password: password) { (success) in
                                if success
                                {
                                    print("signed in successful")
                                    self.loginButton.blink(color: .blue)
                                    self.performSegue(withIdentifier:"signInSuccesfulSegue", sender: nil)
                                }
                                else
                                {
                                    self.loginButton.blink(color: .red)
                                    print("signed in with error")
                                }
            }
        }
        else {
            self.loginButton.blink(color: .red)
            print("validation failed")
        }
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
