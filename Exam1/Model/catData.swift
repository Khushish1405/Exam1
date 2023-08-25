//
//  catData.swift
//  Exam1
//
//  Created by APPLE on 15/02/23.
//

import Foundation

struct CatData: Codable {
    
    let data: [deetail]
}


struct deetail: Codable {
    
    let breed: String
    let country: String
    let origin: String
    let coat: String
    let pattern: String    
    
}
