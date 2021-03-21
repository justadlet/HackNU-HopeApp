//
//  LoginViewController.swift
//  HackNU
//
//  Created by Adlet Zeineken on 21.03.2021.
//  Copyright © 2021 justadlet. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    var userImage: UIImage?
    
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
        button.setTitleColor(Color.blue, for: .normal)
        button.setTitleColor(Color.darkBlue.withAlphaComponent(0.7), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = Color.blue
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return button
    }()
    
    private var firstNameTextField: UITextField = {
        let textField = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        textField.placeholder = "First name"
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
    
    private var lastNameTextField: UITextField = {
        let textField = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        textField.placeholder = "Last name"
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
    
    private var addPhotoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.borderColor = Color.lightBorder.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 90
        button.imageView?.layer.cornerRadius = 5
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
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
        
        view.addSubview(addPhotoButton)
        
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(phoneTextField)
    }
    
    func addConstraints() {
        let safeArea = view.layoutMarginsGuide
        welcomeLabel.addConstraint(top: safeArea.topAnchor, leading: nil, bottom: nil, trailing: nil, centerXAnchor: view.centerXAnchor, centerYAnchor: nil, paddingTop: 60, height: 50)
        signUpToContinueLabel.addConstraint(top: welcomeLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, centerXAnchor: view.centerXAnchor, centerYAnchor: nil, height: 22)
        dontHaveAccountLabel.addConstraint(top: nil, leading: view.leadingAnchor, bottom: safeArea.bottomAnchor, trailing: nil, centerXAnchor: nil, centerYAnchor: nil, paddingLeading: 80, paddingBottom: -30, height: 22)
        signInButton.addConstraint(top: nil, leading: dontHaveAccountLabel.trailingAnchor, bottom: safeArea.bottomAnchor, trailing: nil, centerXAnchor: nil, centerYAnchor: nil, paddingLeading: 4, paddingBottom: -30, height: 22)
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        
        addPhotoButton.addConstraint(top: signUpToContinueLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, centerXAnchor: view.centerXAnchor, centerYAnchor: nil, paddingTop: 40, width: 180, height: 180)
        addPhotoButton.addTarget(self, action: #selector(addPhotoButtonHighlight), for: .touchDown)
        addPhotoButton.addTarget(self, action: #selector(addPhotoButtonPressed), for: .touchUpInside)
        
        firstNameTextField.addConstraint(top: addPhotoButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 16, paddingLeading: 16, paddingTrailing: -16, height: 50)
        lastNameTextField.addConstraint(top: firstNameTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 16, paddingLeading: 16, paddingTrailing: -16, height: 50)
        passwordTextField.addConstraint(top: lastNameTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 16, paddingLeading: 16, paddingTrailing: -16, height: 50)
        phoneTextField.addConstraint(top: passwordTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 16, paddingLeading: 16, paddingTrailing: -16, height: 50)
        
        signUpButton.addConstraint(top: nil, leading: view.leadingAnchor, bottom: signInButton.topAnchor, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingLeading: 16, paddingBottom: -30, paddingTrailing: -16, height: 55)
        signUpButton.addTarget(self, action: #selector(signUpButtonHighlight), for: .touchDown)
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        
    }
    
    func changeAddPhotoButton(to image: UIImage) {
        addPhotoButton.setImage(image, for: .normal)
        addPhotoButton.imageView?.layer.cornerRadius = 90
    }
    
    @objc
    func addPhotoButtonHighlight() {
        addPhotoButton.layer.borderColor = Color.blue.cgColor
    }
    
    @objc
    func addPhotoButtonPressed() {
        addPhotoButton.layer.borderColor = Color.lightBorder.cgColor
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc
    func signUpButtonHighlight() {
        signUpButton.backgroundColor = Color.blue.withAlphaComponent(0.7)
    }
    
    @objc
    func signUpButtonPressed() {
        signUpButton.backgroundColor = Color.blue
        if let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let password = passwordTextField.text,
            let phoneNumber = phoneTextField.text,
            let signUpURL = URL(string: "\(Constants.baseURL)/signup") {
            
            let params: [String : String] = [
                "first_name" : firstName,
                "last_name" : lastName,
                "password" : password,
                "login" : phoneNumber
            ]
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                AF.upload(multipartFormData: { (multipartFormData) in
                    if let imageToUpload = self.userImage?.pngData() {
                        multipartFormData.append(imageToUpload, withName: "photo", fileName: "photo.png", mimeType: "image/png")
                    }
                    multipartFormData.append(jsonData, withName: "json")
                }, to: signUpURL, method: .post)
                    .responseJSON { (response) in
                        switch response.result {
                        case .success(let JSON):
                            let response = JSON as! NSDictionary
                            if let token = response.object(forKey: "token") {
                                UserDefaults.standard.set(token, forKey: "token")
                                let nextViewController = LoginViewController()
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
            } catch {
                
            }
            
        }
    }
    
    
    @objc
    func signInButtonPressed() {
        let nextViewController = LoginViewController()
        guard let navigationController = self.navigationController else { return }
        var navigationArray = navigationController.viewControllers
        navigationArray.removeAll()
        navigationArray.append(nextViewController)
        self.navigationController?.viewControllers = navigationArray
    }
    
    func reloadTextFields() {
        
    }
}
