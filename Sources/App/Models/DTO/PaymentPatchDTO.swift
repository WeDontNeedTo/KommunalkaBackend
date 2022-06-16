//
//  File.swift
//  
//
//  Created by Данил Ломаев on 10.06.2022.
//

import Foundation

struct PaymentPatch: Codable {
    var hotWaterCount: Int?
    var coldWaterCount: Int?
    var electricity: Int?
    var date: String?
}
