//
//  Translation.swift
//  Translate
//
//  Created by Apurva Deshmukh on 6/8/22.
//

import Foundation

struct Translation: Hashable, Codable {
    let text: String

    enum CodingKeys: String, CodingKey {
        case text = "translatedText"
    }
}
