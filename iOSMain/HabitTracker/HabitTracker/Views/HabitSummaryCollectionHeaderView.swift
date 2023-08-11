//
//  HabitSummaryCollectionHeaderView.swift
//  Habit Tracker
//
//  Created by Chris Amezquita on 7/27/23.
//

import UIKit

class HabitSummaryCollectionHeaderView : UICollectionReusableView {
    
    static let reuseIdentifier = "habit-summary-header-view-reuse-identifier"
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "My Habits"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    func configure() {
        backgroundColor = .cyan
        titleLabel.frame = bounds
        addSubview(titleLabel)
//
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.con
//        ])
        
    }
    
}
