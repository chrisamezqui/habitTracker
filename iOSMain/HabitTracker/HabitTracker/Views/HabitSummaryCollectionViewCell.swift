//
//  HabitSummaryCollectionViewCell.swift
//  Habit Tracker
//
//  Created by Chris Amezquita on 7/24/23.
//

import UIKit

class HabitSummaryCollectionViewCell : UICollectionViewCell {
    
    var habitSummaryDelegate : HabitSummaryDelegate?
    
    var lastCompleted : String! = nil {
        didSet {
            lastCompletedLabel.text = lastCompleted
        }
    }
    
    var isCompleted : Bool! = false {
        didSet {
            updateBackgroundColorIfNecessary()
        }
    }
    
    let singleTapGestureRecognizer :UIGestureRecognizer = {
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.numberOfTapsRequired = 1
        return gestureRecognizer
    }()
    
    let doubleTapGestureRecognizer :UIGestureRecognizer = {
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.numberOfTapsRequired = 2
        return gestureRecognizer
    }()
    
    let habitSummaryCellCornerRadius = 16.0
    let habitSummaryCellContentMargin = 8.0
    
    
    
    let titleLabel = UILabel()
    var routineLabels : Array<String> = []
    let routineLabel = UILabel()
    let lastCompletedLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .footnote)
        label.text = "Last Completed: N/A"
        label.numberOfLines = 1
        label.textColor = .darkGray
        return label
    }()
    let streakLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .footnote)
        let fireEmoji = "\u{1F525}"
        label.text = "\(fireEmoji) 3"
        label.numberOfLines = 1
        label.textColor = .darkGray
        return label
    }()
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let lastCompletedImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Last Completed Icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let gradient = CAGradientLayer()

    static let reuseIdentifier = "habit-summary-cell-reuse-identifier"
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        clipsToBounds = true
        
        gradient.frame = bounds
        gradient.colors = [UIColor.habitCardDefaultColor().cgColor, UIColor.habitCardDefaultColor().cgColor]

        layer.addSublayer(gradient)
        layer.cornerRadius = habitSummaryCellCornerRadius

        configure()
        configureGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    private func updateBackgroundColorIfNecessary() {
        if isCompleted {
            self.gradient.colors = [UIColor.habitCardDefaultColor().cgColor, UIColor.habitCardCompleteColor().cgColor]
        }
    }
        
        
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
             
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
             
        layoutAttributes.frame = frame
             
        return layoutAttributes
    }
    
    func getRoutineString() -> String {
        var curString = ""
        for routineLabel in routineLabels {
            if curString.isEmpty {
                curString.append("\(routineLabel)")
            } else {
                curString.append(" \u{2022} \(routineLabel)")
            }
        }
        return curString
    }
    
    private func configureGestureRecognizers() {
        singleTapGestureRecognizer.addTarget(self, action: #selector(handleSingleTap))
        doubleTapGestureRecognizer.addTarget(self, action: #selector(handleDoubleTap))
        singleTapGestureRecognizer.require(toFail: doubleTapGestureRecognizer)
        addGestureRecognizer(singleTapGestureRecognizer)
        addGestureRecognizer(doubleTapGestureRecognizer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
    
    @objc private func handleSingleTap() {
        habitSummaryDelegate?.didSingleTapOnCollectionViewCell(self)
    }
    
    @objc private func handleDoubleTap() {
//        self.gradient.backgroundColor = UIColor.clear.cgColor
        UIView.animate(withDuration: 1.5) {
//            self.backgroundColor = .habitCardCompleteColor()
            self.gradient.colors =
//            [UIColor.habitCardDefaultColor().cgColor,
             [UIColor.habitCardDefaultColor().cgColor, UIColor.habitCardCompleteColor().cgColor]
        }
        habitSummaryDelegate?.didDoubleTapOnCollectionViewCell(self)
    }
        
    func configure() {
//        backgroundColor = .habitCardDefaultColor()
        
        titleLabel.numberOfLines = 0
        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        routineLabel.numberOfLines = 1
        routineLabel.font = .preferredFont(forTextStyle: .subheadline)
        routineLabel.translatesAutoresizingMaskIntoConstraints = false
        routineLabel.text = getRoutineString()
        routineLabel.textColor = .darkGray
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(routineLabel)
        contentView.addSubview(lastCompletedLabel)
        contentView.addSubview(streakLabel)
        
        layer.cornerRadius = habitSummaryCellCornerRadius
        
        NSLayoutConstraint.activate([
            //Title Label
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:habitSummaryCellContentMargin),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:habitSummaryCellContentMargin),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant:-habitSummaryCellContentMargin),
            
            // routine label
            routineLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            routineLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:habitSummaryCellContentMargin),
            routineLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant:-habitSummaryCellContentMargin),
            
            // streak label
            streakLabel.topAnchor.constraint(equalTo: routineLabel.bottomAnchor, constant: 16.0),
            streakLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:-habitSummaryCellContentMargin),
            streakLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant:-habitSummaryCellContentMargin),
            
            // last completed
            lastCompletedLabel.topAnchor.constraint(equalTo: routineLabel.bottomAnchor, constant: 16.0),
            lastCompletedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:-habitSummaryCellContentMargin),
            lastCompletedLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:habitSummaryCellContentMargin),
        ])
    }
    
}


