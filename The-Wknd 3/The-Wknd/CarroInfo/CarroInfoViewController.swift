//
//  CarroInfoViewController.swift
//  The-WKND
//
//  Created by Joseba Iturrioz Aguirre on 20/6/23.
//

import UIKit

class CarroInfoViewController: UIViewController {

    @IBOutlet weak var carritoInfoTableView: UITableView!
    @IBOutlet weak var vistaAbajo: UIView!
    var controlProductosCarrito: RopaTableViewController!
    @IBOutlet weak var itemsCarritoLabel: UILabel!
    @IBOutlet weak var carritoTotalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        carritoInfoTableView.backgroundColor = .clear
        
        carritoInfoTableView.delegate = self
        carritoInfoTableView.dataSource = self
        
        itemsCarritoLabel.text = "Items: \(controlProductosCarrito.carrito.contarCarritoCompra(carrito: controlProductosCarrito.carrito))"
        carritoTotalLabel.text = "Total: \(controlProductosCarrito.carrito.calcularTotal(carrito: controlProductosCarrito.carrito)) €"
        carritoInfoTableView.separatorColor = .clear
    }
    
    @IBAction func vistaVuelta(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func quitarDeCarrito(_ sender: Any) {
        let alerta = UIAlertController(title: "¡Espera!", message: "¿Seguro que quieres quitar el producto del carrito?", preferredStyle: .alert)
        self.present(alerta, animated: true, completion: nil)
        alerta.addAction(UIAlertAction(title: "Seguro", style: .default, handler: {
            (action) in self.controlProductosCarrito.carrito.listaProductos.remove(at: (sender as AnyObject).tag) //sender.tag igualamos al crear la celda
            self.carritoInfoTableView.reloadData()
            self.setupUI()
        }))
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) in
            
        }))
    }
}

extension CarroInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controlProductosCarrito.carrito.listaProductos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let producto = self.controlProductosCarrito.carrito.listaProductos[indexPath.row]
        let celda = tableView.dequeueReusableCell(withIdentifier: "celdaCarritoInfo") as! CeldaCarrito
        celda.ponerProductoCarrito(productoCarrito: producto.0, cantidad: producto.1, subtotal: producto.2)
        celda.quitarDeCarrito.tag = indexPath.row
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
