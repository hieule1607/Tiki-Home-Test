//
//  KeywordModel.swift
//  TikiHomeTest
//
//  Created by Hieu Lam on 2/27/19.
//  Copyright © 2019 Hieu Lam. All rights reserved.
//

import SwiftyJSON

class KeywordDataModel {
    var data: [KeywordModel]?
    
    init(json: JSON) {
        data = json["keywords"].array?.map({ (json) -> KeywordModel in
            return KeywordModel(json: json)
        })
    }
}

class KeywordModel {
    var keyword: String?
    var icon: String?
    
    init(json: JSON) {
        keyword = json["keyword"].string ?? ""
        icon = json["icon"].string ?? ""
    }
}
