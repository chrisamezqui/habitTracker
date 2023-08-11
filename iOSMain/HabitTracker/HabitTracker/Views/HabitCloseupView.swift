//
//  HabitCloseupView.swift
//  Habit Tracker
//
//  Created by Chris Amezquita on 7/30/23.
//

import UIKit

class HabitCloseupView: UIView {
    
    let margin = 8.0
//    var footerHeight :CGFloat {
//        return 83.0 + safeAreaInsets.bottom
//    }
    let footerHeight = 140.0
    
    var textViewDelegate : UITextViewDelegate? {
        didSet {
            configureTextViewDelegates()
        }
    }
    
    var habitCloseupViewDelegate : HabitCloseupViewDelegate? {
        didSet {
            configureHabitCloseupViewDelegate()
        }
    }
    
    var titleText : String? {
        get {
            if titleTextView.placeholderTextIsVisible {
                return nil
            }
            return titleTextView.text
        }
        set {
            titleTextView.hidePlaceholderText()
            titleTextView.text = newValue
        }
    }
    
    var descriptionText : String? {
        get {
            if descriptionTextView.placeholderTextIsVisible {
                return nil
            }
            return descriptionTextView.text
        }
        set {
            descriptionTextView.hidePlaceholderText()
            descriptionTextView.text = newValue
        }
    }
    
    let descriptionTextView : PlaceholderTextView = {
        let textView = PlaceholderTextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.font = .preferredFont(forTextStyle: .body)
        textView.textColor = .darkGray
        textView.placeholderText = "To do this, I will..."
        return textView
    }()
    
    let footerView = HabitCloseupFooterView()
    
    let titleTextView : PlaceholderTextView = {
        let textView = PlaceholderTextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isEditable = true
        textView.isScrollEnabled = false
        textView.textAlignment = .center
        textView.font = .preferredFont(forTextStyle: .largeTitle)
        textView.placeholderText = "I would like to..."
        textView.textContainer.maximumNumberOfLines = 3
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
//        isScrollEnabled = true
//        contentSize = CGSize(width: bounds.size.width, height: 100000)
        configureAutoLayout()
//        configureFooterView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    private func configureTextViewDelegates() {
        titleTextView.delegate = textViewDelegate
        descriptionTextView.delegate = textViewDelegate
    }
    
    private func configureHabitCloseupViewDelegate() {
        footerView.leftButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        footerView.rightButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    
    @objc private func didTapCancelButton(_ button: UIButton) {

        habitCloseupViewDelegate?.closeupView(self, didTapCancelButton: button)
    }
    
    @objc private func didTapSaveButton(_ button: UIButton) {
        habitCloseupViewDelegate?.closeupView(self, didTapSaveButton: button)
    }
    
    func configureAutoLayout() {
        titleTextView.center = center
        descriptionTextView.center = center
        addSubview(titleTextView)
        addSubview(descriptionTextView)
        addSubview(footerView)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // Title Text View
            titleTextView.topAnchor.constraint(equalTo: topAnchor, constant: margin * 2.0),
            titleTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: margin),
            titleTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: margin),
            titleTextView.widthAnchor.constraint(equalToConstant: bounds.width),
            titleTextView.heightAnchor.constraint(equalToConstant: 200.0),
    
            
            //Description Text View
            descriptionTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: margin),
            descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: margin),
            descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: margin),
            descriptionTextView.widthAnchor.constraint(equalToConstant: bounds.width),
//            descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -footerHeight),
            
            //Footer View
            footerView.leftAnchor.constraint(equalTo: leftAnchor),
            footerView.rightAnchor.constraint(equalTo: rightAnchor),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            footerView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: margin),
            footerView.heightAnchor.constraint(equalToConstant: 120.0)
            
        ])
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        configureFooterView()
//    }
    
//    func configureFooterView() {
//        addSubview(footerView)
//        footerView.frame = CGRect(x: 0, y: bounds.height - footerHeight, width: bounds.width, height: footerHeight)
//    }
    
//    override func layoutMarginsDidChange() {
//        super.layoutMarginsDidChange()
//        NSLayoutConstraint.deactivate([
//            footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//        NSLayoutConstraint.activate([
//            footerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -layoutMargins.bottom)
//        ])
//    }
}


class HabitCloseupFooterView : UIView {
    
    let margin :CGFloat = 8.0
    
    let rightButton : UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "checkmark")
        button.setImage(image, for: .normal)
//        button.contentMode = .scaleAspectFill
        button.imageView?.contentMode = .scaleToFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let leftButton : UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "x.circle")
        button.setImage(image, for: .normal)
//        button.contentMode = .scaleAspectFill
        button.imageView?.contentMode = .scaleToFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    var habitCloseupViewDelegate : HabitCloseupViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        configureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        addSubview(leftButton)
        addSubview(rightButton)
        
        let buttonDimension = 100.0// bounds.size.height * 0.8
        
        NSLayoutConstraint.activate([
            leftButton.leftAnchor.constraint(equalTo: leftAnchor, constant: margin * 2.0),
            leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftButton.heightAnchor.constraint(equalToConstant: buttonDimension),
            leftButton.widthAnchor.constraint(equalToConstant: buttonDimension),
            rightButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -margin*2.0),
            rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightButton.heightAnchor.constraint(equalToConstant:buttonDimension),
            rightButton.widthAnchor.constraint(equalToConstant: buttonDimension),
        ])
    }
    
}
