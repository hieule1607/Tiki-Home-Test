//
//  KeywordTVCell.swift
//  TikiHomeTest
//
//  Created by Hieu Lam on 2/28/19.
//  Copyright © 2019 Hieu Lam. All rights reserved.
//

import UIKit

class KeywordTVCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "KeywordCVCell", bundle: Bundle.main), forCellWithReuseIdentifier: "KeywordCVCell")
    }
    
}
