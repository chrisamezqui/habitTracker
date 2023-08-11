//
//  HabitCloseupViewController.swift
//  Habit Tracker
//
//  Created by Chris Amezquita on 7/30/23.
//

import UIKit

enum CloseupViewControllerMode {
    case createMode
    case editeMode
}

class HabitCloseupViewController: UIViewController {
    
    var viewControllerDelegate : HabitCloseupViewControllerDelegate? {
        didSet {
            closeupView?.habitCloseupViewDelegate = self
        }
    }
    
    var titleText : String? {
        didSet {
            closeupView?.titleText = title
        }
    }
    
    var descriptionText: String? {
        didSet {
            closeupView?.descriptionText = descriptionText
        }
    }
    
    var modelId : HabitTrackerSchema.ID?
    var routineID : HabitTrackerSchema.ID?
    
    var mode : CloseupViewControllerMode
    
    var closeupView : HabitCloseupView?
    
    init(withMode mode: CloseupViewControllerMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let closeupView = HabitCloseupView(frame: view.bounds)
        closeupView.textViewDelegate = self
        closeupView.habitCloseupViewDelegate = self
        if titleText != nil {
            closeupView.titleText = titleText
        }
        if descriptionText != nil {
            closeupView.descriptionText = descriptionText
        }
        self.closeupView = closeupView
        view.addSubview(closeupView)
    }
}

extension HabitCloseupViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if let placeholderTextView = textView as? PlaceholderTextView {
            if placeholderTextView.placeholderTextIsVisible {
                placeholderTextView.hidePlaceholderText()
            }
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if let placeholderTextView = textView as? PlaceholderTextView {
            if placeholderTextView.text.isEmpty && !placeholderTextView.placeholderTextIsVisible {
                placeholderTextView.showPlaceholderText()
            }
        }
    }
}

extension HabitCloseupViewController : HabitCloseupViewDelegate {
    func closeupView(_ closeupView : HabitCloseupView, didTapCancelButton : UIButton) {
        switch mode {
        case .createMode:
            dismiss(animated: true)
        case .editeMode:
            self.viewControllerDelegate?.closeupViewController(self, didDeleteHabitWithId: modelId!)
            dismiss(animated: true)
        }
    }
    
    func closeupView(_ closeupView : HabitCloseupView, didTapSaveButton TapSaveButton: UIButton) {
        switch mode {
        case .createMode:
            if let titleText = closeupView.titleText, let descriptionText = closeupView.descriptionText {
                self.viewControllerDelegate?.didCreateNewHabit(withTitle: titleText, description:descriptionText )
            }
            dismiss(animated: true)
        case .editeMode:
            if let titleText = closeupView.titleText, let descriptionText = closeupView.descriptionText, let modelId = modelId {
                self.viewControllerDelegate?.didUpdateHabit(withId: modelId, title: titleText, description: descriptionText)
            }
            dismiss(animated: true)
        }
    }
}
