//
//  ProductoInfoViewController.swift
//  The-WKND
//
//  Created by Joseba Iturrioz Aguirre on 12/6/23.
//

import UIKit

class ProductoInfoViewController: UIViewController {

    @IBOutlet weak var imagenProducto: UIImageView!
    @IBOutlet weak var tituloProducto: UILabel!
    @IBOutlet weak var precioProducto: UILabel!
    @IBOutlet weak var botonVolver: UIButton!
    @IBOutlet weak var cantidadTextField: UITextField!
    
    var producto: Product!
    var controlProductosCarrito: RopaTableViewController!
    var cantidad: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagenProducto.image = producto.image
        tituloProducto.text = producto.title
        precioProducto.text = "\(producto.price) €"
        
        navigationController?.isNavigationBarHidden = true
        
        botonVolver.setTitle("x", for: .normal)
        botonVolver.tintColor = .gray
        
        cantidadTextField.text = String(cantidad)
    }
   
    @IBAction func volverListaProductos(_ sender: Any) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func botonAgregarItem(_ sender: Any) {
        controlProductosCarrito.carrito.listaProductos.append((producto, cantidad, producto.price * cantidad))
        navigationController?.isNavigationBarHidden = false
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func añadirUno(_ sender: Any) {
        if cantidad < 99 {
            cantidad += 1
            cantidadTextField.text = String(cantidad)
            precioProducto.text = "\(producto.price * cantidad) €"
        }
    }
    
    @IBAction func quitarUno(_ sender: Any) {
        if cantidad > 1 {
            cantidad -= 1
            cantidadTextField.text = String(cantidad)
            precioProducto.text = "\(producto.price * cantidad) €"
        }
    }
}
