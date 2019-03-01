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
    
    private func getNewString(str: String) -> String {
        let leftStr = str[0 ..< str.count/2]
        let rightStr = str[str.count/2 ..< str.count]
        var countLeft = 0
        var countRight = 0
        var newStr = ""
        if str.filter({ $0 == " "}).count != 0 {
            for (i, _) in leftStr.enumerated().reversed() {
                print(i)
                if leftStr[i] == " " {
                    print("\(i) --- \(countLeft)")
                    newStr = leftStr[0 ..< i] + "\n" + leftStr[i+1 ..< leftStr.count]
                    break
                }
                countLeft += 1
            }
            
            for (i, _) in rightStr.enumerated() {
                print(i)
                if rightStr[i] == " " {
                    print("\(i) --- \(countRight)")
                    if countLeft > countRight {
                        newStr = leftStr + rightStr[0 ..< i] + "\n" + rightStr[i+1 ..< rightStr.count]
                    } else {
                        newStr += rightStr
                    }
                    break
                }
                countRight += 1
            }
            return newStr
        }
        return str
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
        return 188
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
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
        let minWith: CGFloat = 84
        let keyword = getNewString(str: keywords[indexPath.row].keyword ?? "")
        
        var itemWidth = ((keyword.size(withAttributes:[.font: UIFont.systemFont(ofSize:10.5)]).width) + 17).rounded()
        
        if minWith > itemWidth {
            itemWidth = minWith
        }

        return CGSize(width: itemWidth, height: collectionView.bounds.height)
    }
    
}



