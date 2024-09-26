//
//  Model.swift
//  SAMPLE TASK
//
//  Created by Toqsoft on 24/05/24.
//

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let id, partitionKey: String?
    let rowid: Int?
    let createddate, createdby, name, code: String?
    let sku, description, image: String?
    let categoryid: Int?
    let categoryname: String?
    let subcategoryid: Int?
    let subcategoryname: String?
    let brandid: Int?
    let brandname: String?
    let unitid: Int?
    let unitname: String?
    let reorderlevel, availableqty: Int?
    let status: Bool?
    
    
    }
    

