//
//  LoginViewController.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 23.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

enum AuthType {
    case login
    case registration
}

class PFLoginViewController: UIViewController {
    
    let kRegisterConstant = -60
    let kSignInConstant = -30
    
    
    // MARK: - Properties
    
    
    let authObject = PFAuthAdapter()
    var authType: AuthType? = nil
    
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var emailLine: UIView!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var emailCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    
    // MARK: - LifeCycle
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    static func storyboardInstance() -> PFLoginViewController? {
        
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? PFLoginViewController
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
        addNotifications()
    }
    
    func addNotifications()  {
        
        UITextField.connectFields(fields: [emailTextField, passwordTextField])
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(keyboardWillShow(notification:)),
                           name: .UIKeyboardWillShow,
                           object: nil)
        
        center.addObserver(self,
                           selector: #selector(keyboardWillHide(notification:)),
                           name: .UIKeyboardWillHide,
                           object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Notification Actions
    
    
    func keyboardWillShow(notification: NSNotification) {
        
        let value = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        if value == nil {
            return
        }
        emailCenterConstraint.constant = -((value?.size.width)! / 3)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        let value = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        if value == nil {
            return
        }
        emailCenterConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - General UI
    
    
    func setupUI () {
        
        
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
        
        //self.loginButton.backgroundColor = .clear
    }
    
    
    
    // MARK: - Auth Specific UI
    
    
    func configureRegistrationUI() {
        
        emailCenterConstraint.constant = CGFloat(kRegisterConstant)
        emailTextField.isHidden = true
        emailLine.isHidden = true
        passwordTextField.placeholder = "Create a password"
        descriptionLabel.text = "To complete the registration create a password.\nPassword must be at least 8 characters!"
        nextButton.isHidden = false
        loginButton.isHidden = true
        forgotPasswordButton.isHidden = true
        
        
        print("registration")
    }
    
    func configureSignInUI() {
        
        emailCenterConstraint.constant = CGFloat(kSignInConstant)
        emailTextField.isHidden = false
        emailLine.isHidden = false
        nextButton.isHidden = true
        loginButton.isHidden = false
        forgotPasswordButton.isHidden = false
        passwordTextField.placeholder = "Password"
        emailTextField.placeholder = "Email"
        
        print("login")
    }
    
    func configureRoleLabel(withRole: String) {
        
        let role = withRole
        let font = UIFont(name: "ProximaNovaCond-Black", size: 36.0)
        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
        let attributes = [NSFontAttributeName: font!,
                          NSForegroundColorAttributeName: UIColor.init(red: 0.16,
                                                                       green: 0.16,
                                                                       blue: 0.16,
                                                                       alpha: 1.0)
            ] as [String : Any]
        
        let attributedRole = NSMutableAttributedString(string: role,
                                                       attributes: attributes)
        let purple = UIColor.init(red:0.55,
                                  green:0.37,
                                  blue:0.85,
                                  alpha:1.0)
        
        let attributedDot = NSAttributedString(string: ".",
                                               attributes: [NSForegroundColorAttributeName: purple])
        let label = NSMutableAttributedString()
        label.append(attributedRole)
        label.append(attributedDot)
        
        self.roleLabel.attributedText = label
        configureRegistrationUI()
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
        loginButton.blinkAndRepeatStart()
        PFAuthAdapter.signIn(withEmail: email,
                             password: password) { (success) in
                                if success
                                {
                                    print("signed in successful")
                                    self.loginButton.blink(color: .blue)
                                    let homeViewController = self.presentedController()
                                    self.navigationController?.present(homeViewController,
                                                                       animated: true,
                                                                       completion: {
                                                                        self.loginButton.blinkAndRepeatFinish()
                                                                        
                                    })
                                }
                                else
                                {
                                    self.loginButton.blink(color: .red)
                                    print("signed in with error")
                                    self.loginButton.blinkAndRepeatFinish()
                                }
        }
        
    }
    
    func presentedController() -> SlideMenuController {
        
        let homeViewController = PFProjectsListViewController.storyboardInstance()!
        let slideViewController = PFSlideMenuController.newRigthController(with: homeViewController)
        return slideViewController
    }
    
    func registration() {
        
        if (inputIsValid()) {
            let password = passwordTextField.text ?? ""
            nextButton.blinkAndRepeatStart()
            PFAuthAdapter.registration(password: password,
                                       completionHandler: { (success) in
                                        if success
                                        {
                                            self.nextButton.blinkAndRepeatFinish()
                                            print("Registered successful")
                                            let homeViewController = self.presentedController()
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
        
        let senderNew = sender as! UIButton
        senderNew.blink(scale: 0.98)
        signIn()
    }
    
    @IBAction func registrationButtonDidPressed(_ sender: UIButton) {
        
        sender.blink(scale: 0.98)
        registration()
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
