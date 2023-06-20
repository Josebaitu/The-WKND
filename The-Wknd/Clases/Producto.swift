//
//  Producto.swift
//  The-WKND
//
//  Created by Joseba Iturrioz Aguirre on 12/6/23.
//

import Foundation
import UIKit

class Product {
    
    var image: UIImage
    var title: String
    var price: Int
    
    init(image: UIImage, title: String, price: Int) {
        self.image = image
        self.title = title
        self.price = price
    }
}
