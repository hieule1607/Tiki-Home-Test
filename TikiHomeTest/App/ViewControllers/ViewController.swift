//
//  ViewController.swift
//  TikiHomeTest
//
//  Created by Hieu Lam on 2/27/19.
//  Copyright © 2019 Hieu Lam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var keywords: [KeywordModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData()
    }
    
    // MARK: - Functions
    private func fetchData() {
        ApiClient.shared.request(urlRequest: APIRouter.keywords) { [weak self] (json) in
            if let json = json {
                self?.keywords = KeywordDataModel(json: json).data ?? []
            }
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KeywordTVCell", for: indexPath) as! KeywordTVCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? KeywordTVCell {
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 178
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordCVCell", for: indexPath) as! KeywordCVCell
        cell.configure(keyword: keywords[indexPath.row])
        cell.viewContent.backgroundColor = UIColor(hexString: contentColors[indexPath.row % contentColors.count])
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 12
        let minWidth: CGFloat = 82
        let maxWidth: CGFloat = 112
        let lineNumber: CGFloat = 2
        let keyword = keywords[indexPath.row].keyword ?? ""
        var itemWidth = (keyword.size(withAttributes:[.font: UIFont.systemFont(ofSize:10.5)]).width) / lineNumber + 16
        if itemWidth < minWidth {
            itemWidth = minWidth
        } else if itemWidth > maxWidth {
            itemWidth = maxWidth
        }
        
        return CGSize(width: itemWidth, height: collectionView.bounds.height)
    }
    
}



