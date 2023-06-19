//
//  CeldaCarrito.swift
//  The-WKND
//
//  Created by Joseba Iturrioz Aguirre on 13/6/23.
//

import Foundation
import UIKit

class CeldaCarrito: UITableViewCell {
    
    @IBOutlet weak var productoImageView: UIImageView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var precioLabel: UILabel!
    @IBOutlet weak var cantidadLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var quitarDeCarrito: UIButton!
    
    func ponerProductoCarrito(productoCarrito: Product, cantidad: Int, subtotal: Int){
        self.productoImageView.image = productoCarrito.image
        self.tituloLabel.text = productoCarrito.title
        self.precioLabel.text = "Precio: \(productoCarrito.price) €"
        self.cantidadLabel.text = "Cantidad: \(cantidad)"
        self.subtotalLabel.text = "Subtotal: \(subtotal) €"
        self.quitarDeCarrito.imageView?.image = UIImage(named: "cart.badge.minus")
    }
}
