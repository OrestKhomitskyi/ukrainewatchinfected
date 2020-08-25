//
//  StructureClasses.swift
//  UkraineInfectedCount WatchKit Extension
//
//  Created by Orest Khomitskyi on 25.08.2020.
//  Copyright © 2020 Orest Khomitskyi. All rights reserved.
//

import Foundation

struct CountryInfo: Decodable {
    var Country: String
    var TotalConfirmed: Int
}

struct GlobalInfo: Decodable {
    var TotalConfirmed: Int
}

struct ResponseBody: Decodable {
    var Global: GlobalInfo
    var Countries: [CountryInfo]
}
