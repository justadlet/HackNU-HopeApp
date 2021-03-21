//
//  LoginViewControllerExtension.swift
//  HackNU
//
//  Created by Adlet Zeineken on 21.03.2021.
//  Copyright © 2021 justadlet. All rights reserved.
//

import Foundation
import UIKit

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = Color.blue.cgColor
        textField.textColor = Color.darkBlue
        reloadTextFields()
        textField.activate()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = Color.lightBorder.cgColor
    }
}
