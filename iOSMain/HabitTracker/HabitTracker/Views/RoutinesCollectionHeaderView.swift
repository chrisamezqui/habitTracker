//
//  RoutinesDividerSupplementaryView.swift
//  Habit Tracker
//
//  Created by Chris Amezquita on 7/30/23.
//

import UIKit

class RoutinesCollectionHeaderView: UICollectionViewCell {
    
    var delegate : RoutineHeaderDelegate?
    
    var isFirstSection : Bool = false
    
    let plusButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFill
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let margin : CGFloat = 8.0
    
    let routineNameLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dividerView : UIView = {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .darkGray
        return divider
    }()

    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .systemBackground
        configureButton()
        
    }
    
    @objc private func handleTapOnPlusButton() {
        delegate?.routineHeaderView(self, didTapAddHabitButton: plusButton)
    }
    
    func configureButton() {
        plusButton.addTarget(self, action: #selector(handleTapOnPlusButton), for: .touchDown)
    }

    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }
    
    func setTitle(_ title: String) {
        routineNameLabel.text = title
    }
    
    func configureConstraintsForFirstSection() {
        NSLayoutConstraint.activate([
            routineNameLabel.topAnchor.constraint(equalTo: topAnchor),
            routineNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: margin * 2.0)
        ])
    }
    
    func configureConstraintsForFollowingSection() {
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: topAnchor),
            dividerView.leftAnchor.constraint(equalTo: leftAnchor, constant: margin * 2.0),
            dividerView.rightAnchor.constraint(equalTo: rightAnchor),
            dividerView.bottomAnchor.constraint(equalTo: topAnchor, constant:1.0),
        
            routineNameLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant:margin),
            routineNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: margin * 2.0),
            
            plusButton.leftAnchor.constraint(equalTo: routineNameLabel.rightAnchor, constant: margin),
            plusButton.centerYAnchor.constraint(equalTo: routineNameLabel.centerYAnchor)
            
        ])
    }
    
    func configure() {
        addSubview(routineNameLabel)
        addSubview(plusButton)
//        if isFirstSection {
////            configureConstraintsForFirstSection()
//        } else {
        addSubview(dividerView)
        configureConstraintsForFollowingSection()
//        }
        
    }
}

class RoutinesCollectionTopHeaderView : RoutinesCollectionHeaderView {
    
    static let reuseIdentifier = "routines-top-header-reuse-identifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isFirstSection = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
}

class RoutinesCollectionFollowingHeaderView : RoutinesCollectionHeaderView
{
    static let reuseIdentifier = "routines-following-header-reuse-identifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isFirstSection = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
}
