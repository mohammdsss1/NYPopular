//
//  Article.swift
//  NYPopular
//
//  Created by Hammoda on 5/22/20.
//  Copyright © 2020 salah. All rights reserved.
//

import Foundation

struct Article: Codable{
    var id = ""
    var source = ""
    
    enum CodingKeys: String, CodingKey {
        case id, source
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.source = try container.decode(String.self, forKey: .source)
    }
}
