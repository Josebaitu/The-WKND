//
//  CeldaRopaTableViewCell.swift
//  The-WKND
//
//  Created by Joseba Iturrioz Aguirre on 10/6/23.
//

import UIKit

class CeldaRopaTableViewCell: UITableViewCell {

    @IBOutlet weak var imagenRopa: UIImageView!
    @IBOutlet weak var tituloRopa: UILabel!
    @IBOutlet weak var precioRopa: UILabel!
    
    func colocarProducto(product: Product){
        self.imagenRopa.image = product.image
        self.tituloRopa.text = product.title
        self.precioRopa.text = "Precio: \(product.price) €"
    }
    
}
