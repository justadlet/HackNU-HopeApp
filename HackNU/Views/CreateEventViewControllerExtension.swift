//
//  CreateEventViewControllerExtension.swift
//  HackNU
//
//  Created by Adlet Zeineken on 20.03.2021.
//  Copyright © 2021 justadlet. All rights reserved.
//

import Foundation
import UIKit
import FSCalendar

extension CreateEventViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = Color.blue.cgColor
        textField.textColor = Color.darkBlue
        reloadButtons()
        textField.activate()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = Color.lightBorder.cgColor
    }
}

extension CreateEventViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        changeAddPhotoButtonImage(to: image)
        
        dismiss(animated: true)
    }
}

extension CreateEventViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        reloadButtons()
        changeDeadlineButtonTitle(to: " \(date.get(.day))/\(date.get(.month))/\(date.get(.year))")
        activate(button: &deadlineButton)
    }
}
