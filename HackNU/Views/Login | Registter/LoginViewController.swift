//
//  Lofin.swift
//  HackNU
//
//  Created by Adlet Zeineken on 21.03.2021.
//  Copyright © 2021 justadlet. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Hope"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = Color.darkBlue
        return label
    }()
    
    private let signUpToContinueLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign up to continue"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = Color.unselectedBlue
        return label
    }()
    
    private let dontHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = Color.unselectedBlue
        return label
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = Color.blue
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(Color.blue, for: .normal)
        button.setTitleColor(Color.darkBlue.withAlphaComponent(0.7), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return button
    }()
    
    private var passwordTextField: UITextField = {
        let textField = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        textField.placeholder = "Password"
        textField.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = Color.lightBorder.cgColor
        textField.layer.borderWidth = 1
        textField.layer.masksToBounds = true
        textField.textColor = Color.darkBlue
        textField.textAlignment = .left
        
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    private var phoneTextField: UITextField = {
        let textField = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        textField.placeholder = "Phone number"
        textField.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = Color.lightBorder.cgColor
        textField.layer.borderWidth = 1
        textField.layer.masksToBounds = true
        textField.textColor = Color.darkBlue
        textField.textAlignment = .left
        
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        passwordTextField.delegate = self
        phoneTextField.delegate = self
        addSubviews()
        addConstraints()
    }
    
    func addSubviews() {
        view.addSubview(welcomeLabel)
        view.addSubview(signUpToContinueLabel)
        view.addSubview(dontHaveAccountLabel)
        view.addSubview(signUpButton)
        view.addSubview(signInButton)
        
        view.addSubview(passwordTextField)
        view.addSubview(phoneTextField)
    }
    
    func addConstraints() {
        let safeArea = view.layoutMarginsGuide
        welcomeLabel.addConstraint(top: safeArea.topAnchor, leading: nil, bottom: nil, trailing: nil, centerXAnchor: view.centerXAnchor, centerYAnchor: nil, paddingTop: 60, height: 50)
        signUpToContinueLabel.addConstraint(top: welcomeLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, centerXAnchor: view.centerXAnchor, centerYAnchor: nil, height: 22)
        dontHaveAccountLabel.addConstraint(top: nil, leading: view.leadingAnchor, bottom: safeArea.bottomAnchor, trailing: nil, centerXAnchor: nil, centerYAnchor: nil, paddingLeading: 80, paddingBottom: -30, height: 22)
        signUpButton.addConstraint(top: nil, leading: dontHaveAccountLabel.trailingAnchor, bottom: safeArea.bottomAnchor, trailing: nil, centerXAnchor: nil, centerYAnchor: nil, paddingLeading: 4, paddingBottom: -30, height: 22)
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        
        phoneTextField.addConstraint(top: signUpToContinueLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 80, paddingLeading: 16, paddingTrailing: -16, height: 50)
        passwordTextField.addConstraint(top: phoneTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 16, paddingLeading: 16, paddingTrailing: -16, height: 50)
        
        signInButton.addConstraint(top: nil, leading: view.leadingAnchor, bottom: signUpButton.topAnchor, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingLeading: 16, paddingBottom: -30, paddingTrailing: -16, height: 55)
        signInButton.addTarget(self, action: #selector(signInButtonHighlight), for: .touchDown)
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        
    }
    
    @objc
    func signUpButtonPressed() {
        let nextViewController = RegisterViewController()
        guard let navigationController = self.navigationController else { return }
        var navigationArray = navigationController.viewControllers
        navigationArray.removeAll()
        navigationArray.append(nextViewController)
        self.navigationController?.viewControllers = navigationArray
    }
    
    @objc
    func signInButtonPressed() {
        signInButton.backgroundColor = Color.blue
        if let password = passwordTextField.text,
            let phoneNumber = phoneTextField.text,
            let loginURL = URL(string: "\(Constants.baseURL)/login") {
            
            let params: [String : String] = [
                "password" : password,
                "login" : phoneNumber
            ]
            AF.request(loginURL, method: .post, parameters: params, encoder: JSONParameterEncoder.prettyPrinted).responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    let response = JSON as! NSDictionary
                    if let token = response.object(forKey: "token") {
                        UserDefaults.standard.set(token, forKey: "token")
                        let nextViewController = MainTabBarController()
                        guard let navigationController = self.navigationController else { return }
                        var navigationArray = navigationController.viewControllers
                        navigationArray.removeAll()
                        navigationArray.append(nextViewController)
                        self.navigationController?.viewControllers = navigationArray
                    }
                case .failure(_):
                    break
                }
                
            }
        }
    }
    
    @objc
    func signInButtonHighlight() {
        signInButton.backgroundColor = Color.blue.withAlphaComponent(0.7)
    }
    
    func reloadTextFields() {
        
    }
}
