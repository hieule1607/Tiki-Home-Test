//
//  KeywordCVCell.swift
//  TikiHomeTest
//
//  Created by Hieu Lam on 2/27/19.
//  Copyright © 2019 Hieu Lam. All rights reserved.
//

import UIKit
import Kingfisher

class KeywordCVCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var lblContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContent.layer.cornerRadius = 5
        lblContent.textColor = UIColor.white
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
        lblContent.text = nil
    }
    
    func configure(keyword: KeywordModel) {
        if let url = URL(string: keyword.icon ?? "") {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url,  placeholder: UIImage(named: "default_logo"))
        }
        lblContent.text = keyword.keyword
    }

}
