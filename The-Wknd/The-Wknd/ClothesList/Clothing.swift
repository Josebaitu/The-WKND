//
//  Clothing.swift
//  The-WKND
//
//  Created by Eneko Díaz Romero on 7/6/23.
//

import Foundation

struct Clothing: Identifiable, Decodable {
    let id: String
    let imageURL: URL
    let name: String
}
