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
    var authType: AuthType? = nil
    
    
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
    
    
    // MARK: - General UI
    
    
    func setupUI () {
        
        configureButton()
        
        guard let auth = authType else {
            return
        }
        switch auth {
        case .login:
            configureSignInUI()
        case .registration:
            configureRegistrationUI()
        }
    }
    
    func configureButton() {
        
        self.loginButton.backgroundColor = .clear
    }
    
    
    // MARK: - Auth Specific UI
    
    
    func configureRegistrationUI() {
        
        configureRoleLabel()
        print("registration")
    }
    
    func configureSignInUI() {
        
        print("login")
    }
    
    func configureRoleLabel() {
        
        guard let parameters = UserDefaults.standard.value(forKey: kParametersKey) as! [String:Any]?
            else {
                return
        }
        let role = parameters[kRole] as! String? ?? "undefined role"
        self.roleLabel.text = role
    }
    
    
    // MARK: - Authentication
    
    
    func signIn() {
        
        if (inputIsValid()) {
            let email = emailTextField.text ?? ""
            let password = passwordTextField.text ?? ""
            signIn(withEmail: email,
                   password: password)
        }
        else {
            self.loginButton.blink(color: .red)
            print("validation failed")
        }
    }
    
    func signIn(withEmail email: String, password: String) {
        
        PFAuthAdapter.signIn(withEmail: email,
                             password: password) { (success) in
                                if success
                                {
                                    print("signed in successful")
                                    self.loginButton.blink(color: .blue)
                                    let homeViewController = PFProjectsListViewController.storyboardInstance()!
                                    self.navigationController?.present(homeViewController,
                                                                       animated: true,
                                                                       completion: {
                                                                        
                                    })
                                }
                                else
                                {
                                    self.loginButton.blink(color: .red)
                                    print("signed in with error")
                                }
        }
        
    }
    
    func registration() {
        
        if (inputIsValid()) {
            let password = passwordTextField.text ?? ""
            
            PFAuthAdapter.registration(password: password,
                                       completionHandler: { (success) in
                                        if success
                                        {
                                            print("Registered successful")
                                            let homeViewController = PFProjectsListViewController.storyboardInstance()!
                                            self.navigationController?.present(homeViewController,
                                                                               animated: true,
                                                                               completion: {
                                                                                
                                            })
                                        }
                                        else
                                        {
                                            self.loginButton.blink(color: .red)
                                            print("Registered with error")
                                        }
            })
        }
        else {
            self.loginButton.blink(color: .red)
            print("validation failed")
        }
        
    }
    
    
    // MARK: - Actions
    
    
    @IBAction func loginButtonDidPressed(_ sender: Any) {
        
        guard let auth = authType else {
            return
        }
        switch auth {
        case .login:
            signIn()
        case .registration:
            registration()
        }
        
    }
    
    @IBAction func hideKeyboard(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
    }
    
    
    //MARK: - Validation
    
    
    func inputIsValid() -> Bool {
        
        guard let auth = authType else {
            return false
        }
        var emailIsValid: Bool = false
        var passIsValid: Bool = false
        switch auth {
        case .login:
            emailIsValid    = validateEmail()
            passIsValid     = validatePassword()
        case .registration:
            emailIsValid    = true
            passIsValid     = validatePassword()
        }
        
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
