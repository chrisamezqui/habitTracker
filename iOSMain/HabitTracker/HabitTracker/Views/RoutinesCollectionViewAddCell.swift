//
//  RoutinesCollectionAddCellCollectionViewCell.swift
//  Habit Tracker
//
//  Created by Chris Amezquita on 7/30/23.
//

import UIKit

class RoutinesCollectionViewAddCell: UICollectionViewCell {
    
    static let reuseIdentifier = "routines-colelction-add-cell-reuse-identifier"
    
    let leftButtonView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.image = UIImage(systemName: "plus.circle")?.withTintColor(.white)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .systemBackground
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }

    func configure() {
        contentView.addSubview(leftButtonView)
        leftButtonView.frame = contentView.bounds
    }
    
}
