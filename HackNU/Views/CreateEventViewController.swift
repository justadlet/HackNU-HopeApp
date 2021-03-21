//
//  CreateEventViewController.swift
//  HackNU
//
//  Created by Adlet Zeineken on 20.03.2021.
//  Copyright © 2021 justadlet. All rights reserved.
//

import Foundation
import UIKit
import FSCalendar

protocol CreateEventViewControllerDelegate: AnyObject {
    func reloadTableView()
}

class CreateEventViewController: UIViewController {
    var currentChosenType = Type.none
    let scrollView = UIScrollView()
    var newPost = Event()
    var calendarViewHeightConstraint = NSLayoutConstraint()
    weak var delegate: CreateEventViewControllerDelegate?
    private let chooseTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.darkBlue
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Post type"
        return label
    }()
    
    private var donateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Donate", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(Color.darkBlue.withAlphaComponent(0.6), for: .highlighted)
        button.titleLabel?.textColor = Color.unselectedBlue
        button.layer.borderColor = Color.lightBorder.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    private var seminarButton: UIButton = {
        let button = UIButton()
        button.setTitle("Seminar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(Color.darkBlue.withAlphaComponent(0.6), for: .highlighted)
        button.titleLabel?.textColor = Color.unselectedBlue
        button.layer.borderColor = Color.lightBorder.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    private var articleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Article", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(Color.darkBlue.withAlphaComponent(0.6), for: .highlighted)
        button.titleLabel?.textColor = Color.unselectedBlue
        button.layer.borderColor = Color.lightBorder.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.darkBlue
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Title"
        return label
    }()
    
    private var titleTextField: UITextField = {
        let textField = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        textField.placeholder = "Donate to autism charity"
        textField.font = UIFont.systemFont(ofSize: 16, weight: .bold)
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
    
    private let addPhotoLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.darkBlue
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Add Photo"
        return label
    }()
    
    private var addPhotoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.borderColor = Color.lightBorder.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.imageView?.layer.cornerRadius = 5
        
        return button
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.darkBlue
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Description"
        return label
    }()
    
    private var descriptionTextField: DescriptionTextField = {
        let textField = DescriptionTextField()
        textField.placeholder = "Write your description here"
        textField.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = Color.lightBorder.cgColor
        textField.layer.borderWidth = 1
        textField.layer.masksToBounds = true
        textField.textColor = Color.darkBlue
        textField.textAlignment = .left
        
        textField.leftViewMode = .always
        textField.isUserInteractionEnabled = true
        
        return textField
    }()
    
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.darkBlue
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Deadline"
        return label
    }()
    
    var deadlineButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.tintColor = Color.blue
        button.setImage(UIImage(systemName: "calendar"), for: .normal)
        button.setTitle(" 12/12/2021", for: .normal)
        button.setTitleColor(Color.darkBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.borderColor = Color.lightBorder.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    private let calendarView: FSCalendar = {
        let calendarView = FSCalendar()
        calendarView.scope = .month
        calendarView.firstWeekday = 2
        calendarView.appearance.weekdayTextColor = Color.darkBlue
        calendarView.appearance.eventSelectionColor = Color.darkBlue
        calendarView.appearance.headerTitleColor = Color.darkBlue
        calendarView.appearance.selectionColor = Color.blue
        calendarView.appearance.todayColor = Color.lightRed
        return calendarView
    }()
    
    private var timeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.tintColor = Color.blue
        button.setImage(UIImage(systemName: "clock"), for: .normal)
        let currentHour = String(format: "%0.2d", Date().get(.hour))
        let currentMinute = String(format: "%.2d", Date().get(.minute))
        button.setTitle(" \(currentHour):\(currentMinute)", for: .normal)
        button.setTitleColor(Color.darkBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.borderColor = Color.lightBorder.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    private let timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        
        return timePicker
    }()
    
    private var publishButton: UIButton = {
        let button = UIButton()
        button.setTitle("Publish", for: .normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.titleLabel?.textColor = .white
        button.backgroundColor = Color.blue
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted  )
//        button.layer.borderWidth = 2
//        button.layer.borderColor = Color.lightBorder.cgColor
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addSubviews()
        addConstraints()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        scrollView.contentSize = view.frame.size
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        titleTextField.delegate = self
        descriptionTextField.delegate = self
        
        calendarView.delegate = self
        calendarView.dataSource = self
        
        reloadButtons()
        reloadPostTypeButtons()
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(chooseTypeLabel)
        scrollView.addSubview(donateButton)
        scrollView.addSubview(seminarButton)
        scrollView.addSubview(articleButton)
        
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(titleTextField)
        
        scrollView.addSubview(addPhotoLabel)
        scrollView.addSubview(addPhotoButton)
        
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(descriptionTextField)
        
        scrollView.addSubview(deadlineLabel)
        scrollView.addSubview(deadlineButton)
        scrollView.addSubview(calendarView)
        
        scrollView.addSubview(timeButton)
        scrollView.addSubview(timePicker)
        
        scrollView.addSubview(publishButton)
    }
    
    func addConstraints() {
        let safeArea = view.layoutMarginsGuide
        scrollView.addConstraint(top: safeArea.topAnchor, leading: view.leadingAnchor, bottom: safeArea.bottomAnchor, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil)
        
        chooseTypeLabel.addConstraint(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 16, paddingLeading: 16)
        
        donateButton.addConstraint(top: chooseTypeLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 12, paddingLeading: 16, paddingTrailing: -16, height: 50)
        donateButton.addTarget(self, action: #selector(donateButtonPressed), for: .touchUpInside)
        seminarButton.addConstraint(top: donateButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 12, paddingLeading: 16, paddingTrailing: -16, height: 50)
        seminarButton.addTarget(self, action: #selector(seminarButtonPressed), for: .touchUpInside)
        articleButton.addConstraint(top: seminarButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 12, paddingLeading: 16, paddingTrailing: -16, height: 50)
        articleButton.addTarget(self, action: #selector(articleButtonPressed), for: .touchUpInside)
        
        titleLabel.addConstraint(top: articleButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 12, paddingLeading: 16)
        titleTextField.addConstraint(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 12, paddingLeading: 16, paddingTrailing: -16, height: 50)
        
        addPhotoLabel.addConstraint(top: titleTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 12, paddingLeading: 16, paddingTrailing: -16)
        addPhotoButton.addConstraint(top: addPhotoLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 12, paddingLeading: 16, width: 90, height: 90)
        addPhotoButton.addTarget(self, action: #selector(highlightBorder), for: .touchDown)
        addPhotoButton.addTarget(self, action: #selector(addPhotoButtonPressed), for: .touchUpInside)
        
        descriptionLabel.addConstraint(top: addPhotoButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 12, paddingLeading: 16, paddingTrailing: -16)
        descriptionTextField.addConstraint(top: descriptionLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 12, paddingLeading: 16, paddingTrailing: -16, height: 150)
        
        deadlineLabel.addConstraint(top: descriptionTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 12, paddingLeading: 16, paddingTrailing: -16)
        deadlineButton.addConstraint(top: deadlineLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 12, paddingLeading: 16, paddingTrailing: -16, height: 50)
        deadlineButton.addTarget(self, action: #selector(deadlineButtonPressed), for: .touchUpInside)
        
        calendarView.addConstraint(top: deadlineButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 12, paddingLeading: 16, paddingTrailing: -16, height: 300)
        if let heightConstraint = calendarView.constraints.last {
            calendarViewHeightConstraint = heightConstraint
        }
        
        timeButton.addConstraint(top: calendarView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 12, paddingLeading: 16, paddingTrailing: -16, height: 50)
        timeButton.addTarget(self, action: #selector(timeButtonPressed), for: .touchUpInside)
        timePicker.addConstraint(top: timeButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 12, paddingLeading: 16, paddingTrailing: -16)
        timePicker.addTarget(self, action: #selector(timePickerDidChange), for: .valueChanged)
        
        publishButton.addConstraint(top: timePicker.bottomAnchor, leading: view.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 12, paddingLeading: 16, paddingBottom: -16, paddingTrailing: -16, height: 55)
        publishButton.addTarget(self, action: #selector(publishButtonHighlight), for: .touchDown)
        publishButton.addTarget(self, action: #selector(publishButtonPressed), for: .touchUpInside)
    }
    
    
    @objc
    func donateButtonPressed() {
        currentChosenType = .Donate
        reloadPostTypeButtons()
        
        activate(button: &donateButton)
    }
    @objc
    func seminarButtonPressed() {
        currentChosenType = .Seminar
        reloadPostTypeButtons()
        
        activate(button: &seminarButton)
    }
    @objc
    func articleButtonPressed() {
        currentChosenType = .Article
        reloadPostTypeButtons()
        
        activate(button: &articleButton)
    }
    
    @objc
    func highlightBorder() {
        reloadButtons()
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
    func deadlineButtonPressed() {
        reloadButtons()
        activate(button: &deadlineButton)
        calendarView.scope = .month
        calendarViewHeightConstraint.constant = 300
    }
    
    @objc
    func timeButtonPressed() {
        reloadButtons()
        activate(button: &timeButton)
    }
    
    @objc
    func timePickerDidChange() {
        reloadButtons()
        activate(button: &timeButton)
        let currentHour = String(format: "%0.2d", timePicker.date.get(.hour))
        let currentMinute = String(format: "%.2d", timePicker.date.get(.minute))
        timeButton.setTitle(" \(currentHour):\(currentMinute)", for: .normal)
    }
    
    @objc
    func publishButtonHighlight() {
        reloadButtons()
        publishButton.backgroundColor = Color.darkBlue.withAlphaComponent(0.5)
        
    }
    
    @objc
    func publishButtonPressed() {
        reloadButtons()
        publishButton.backgroundColor = Color.blue
        Constants.events = []
        Constants.events.append(Event(type: currentChosenType   , title: "Upbringing children", community: "Adlet Zeineken", communityImageURL: "https://akniga.org/uploads/media/topic/2019/03/22/09/preview/7ce9fc824d4682ebf054_400x.jpg", imageURL: nil, description: "A seminar where we will talk about raising children with diseases.", createdAt: "Now", peopleEngaged: 0, deadline: "21/03/2021 14:00", location: "Nur-Sultan"))
        Constants.events.append(Event(type: .Donate,
                 title: "Donate to autism charity",
                 community: "NU Red Crescent",
                 communityImageURL: "https://thewave.kz/wp-content/uploads/elementor/thumbs/photo_2020-12-10_16-31-57-oznon7svv1kkxujfxvxijpkgda5fruw9iti8jw9xf4.jpg",
                 imageURL: "https://static.wixstatic.com/media/fc8ec5_46177bcad089410ba699257037ffe46c~mv2.png/v1/fill/w_1540,h_540,al_c/fc8ec5_46177bcad089410ba699257037ffe46c~mv2.png",
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                 createdAt: "1 day ago",
                 peopleEngaged: 127,
                 deadline: "Thursday, January 10th, 4:00 am",
                 location: nil))
        Constants.events.append(
            Event(type: .Seminar,
                 title: "Understanding autism",
                 community: "NU Red Crescent",
                 communityImageURL: "https://thewave.kz/wp-content/uploads/elementor/thumbs/photo_2020-12-10_16-31-57-oznon7svv1kkxujfxvxijpkgda5fruw9iti8jw9xf4.jpg",
                 imageURL: "https://images.unsplash.com/photo-1587825140708-dfaf72ae4b04?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1650&q=80",
                 description: nil,
                 createdAt: "1 day ago",
                 peopleEngaged: 127,
                 deadline: "Thursday, January 10th, 4:00 am",
                 location: "Qabanbay Batyr Ave 53, Nazarbayev University"))
        Constants.events.append(
            Event(type: .Article,
                 title: "Autistic Kids and Cameras: A Good Combination",
                 community: "NU Red Crescent",
                 communityImageURL: "https://thewave.kz/wp-content/uploads/elementor/thumbs/photo_2020-12-10_16-31-57-oznon7svv1kkxujfxvxijpkgda5fruw9iti8jw9xf4.jpg",
                 imageURL: "https://autismawarenesscentre.com/wp-content/uploads/kid_with_camera.jpg",
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                 createdAt: "1 day ago",
                 peopleEngaged: 127,
                 deadline: nil,
                 location: nil))
        
        if let dlg = delegate {
            dlg.reloadTableView()
        }
        self.tabBarController?.selectedIndex = 0
    }
    
    func reloadPostTypeButtons() {
        deactivate(button: &donateButton)
        deactivate(button: &articleButton)
        deactivate(button: &seminarButton)
    }
    
    func reloadButtons() {
        deactivate(textField: &titleTextField)
        deactivate(textField: &descriptionTextField)
        deactivate(button: &addPhotoButton)
        deactivate(button: &deadlineButton)
        deactivate(button: &timeButton)
        deactivateBackground(button: &publishButton)
    }
    
    func deactivate(button: inout UIButton) {
        button.layer.borderColor = Color.lightBorder.cgColor
        button.setTitleColor(Color.unselectedBlue, for: .normal)
    }
    
    func deactivateBackground(button: inout UIButton) {
        button.backgroundColor = Color.blue
    }
    
    func deactivate(textField: inout UITextField) {
        textField.layer.borderColor = Color.lightBorder.cgColor
    }
    
    func deactivate(textField: inout DescriptionTextField) {
        textField.layer.borderColor = Color.lightBorder.cgColor
    }
    
    func activate(button: inout UIButton) {
        button.layer.borderColor = Color.blue.cgColor
        button.setTitleColor(Color.darkBlue, for: .normal)
    }
    
    func changeAddPhotoButtonImage(to image: UIImage) {
        addPhotoButton.setImage(image, for: .normal)
    }
    
    func changeDeadlineButtonTitle(to title: String) {
        deadlineButton.setTitle(title, for: .normal)
    }
}
