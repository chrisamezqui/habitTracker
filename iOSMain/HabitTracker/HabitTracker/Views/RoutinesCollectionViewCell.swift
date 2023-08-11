//
//  RoutinesCollectionViewCell.swift
//  Habit Tracker
//
//  Created by Chris Amezquita on 7/28/23.
//

import UIKit

class RoutinesCollectionViewCell : UICollectionViewCell {
    
    var routineCellDelegate : RoutineCellDelegate?
    
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
        
    static let reuseIdentifier = "routines-collection-cell-reuse-identifier"
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        label.numberOfLines = 4
        label.text = "test"
        return label
    }()
    
    let gradient = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        clipsToBounds = true
        
        gradient.frame = bounds
        gradient.colors = [UIColor.habitCardDefaultColor().cgColor, UIColor.habitCardDefaultColor().cgColor]
        layer.addSublayer(gradient)
        layer.cornerRadius = 16.0
        
        configure()
        configureGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    private func configureGestureRecognizers() {
        singleTapGestureRecognizer.addTarget(self, action: #selector(handleSingleTap))
        doubleTapGestureRecognizer.addTarget(self, action: #selector(handleDoubleTap))
        singleTapGestureRecognizer.require(toFail: doubleTapGestureRecognizer)
        addGestureRecognizer(singleTapGestureRecognizer)
        addGestureRecognizer(doubleTapGestureRecognizer)
    }
    
    @objc private func handleSingleTap() {
        routineCellDelegate?.didSingleTapOnCollectionViewCell(self)
    }
    
    @objc private func handleDoubleTap() {
        UIView.animate(withDuration: 1.5) {
            self.gradient.colors =
             [UIColor.habitCardDefaultColor().cgColor, UIColor.habitCardCompleteColor().cgColor]
        }
        routineCellDelegate?.didDoubleTapOnCollectionViewCell(self)
    }
    
    func configure() {
//        contentView.backgroundColor = UIColor(red:0.95 , green:0.95 , blue:0.9 , alpha: 1)
        contentView.addSubview(titleLabel)
        contentView.layer.cornerRadius = 16.0
        let margin = 8.0
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: margin),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -margin),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
}
