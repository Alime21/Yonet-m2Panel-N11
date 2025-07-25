//
//  GalleryCell.swift
//  Yonetım2PanelıN11
//
//  Created by alime.kilinc on 25.07.2025.
//
import UIKit

class GalleryCell: UICollectionViewCell {
    static let identifier = "GalleryCell"
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
}
