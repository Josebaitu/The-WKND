//
//  RopaTableViewController.swift
//  The-WKND
//
//  Created by Joseba Iturrioz Aguirre on 8/6/23.
//

import UIKit
import FirebaseAuth

class RopaTableViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tiendaIcono: UIImageView!
    
    @IBOutlet weak var itemsEnCarrito: UILabel!
    @IBOutlet weak var comprarTotal: UILabel!
    
    var products: [Product] = []
    var carrito = CarritoCompra()
    
    var itemsCarrito = Int()
    var totalCarrito = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        products = crearArrayProductos()
        
        tableView.register(UINib(nibName: "CeldaRopaTableViewCell", bundle: nil), forCellReuseIdentifier: "celdaRopa")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        itemsCarrito = carrito.contarCarritoCompra(carrito: carrito)
        totalCarrito = carrito.calcularTotal(carrito: carrito)
        itemsEnCarrito.text = "Items: \(itemsCarrito)"
        comprarTotal.text = "Total: \(totalCarrito) €"
    }
    
    func crearArrayProductos() -> [Product] {
        var temp: [Product] = []
        
        let p1 = Product(image: UIImage(named: "camiseta1")!, title: "Camiseta Dibujo Espalda", price: 15)
        let p2 = Product(image: UIImage(named: "camiseta2")!, title: "Camiseta Blanca", price: 20)
        let p3 = Product(image: UIImage(named: "camiseta3")!, title: "Camiseta Blanca Estampado pecho", price: 20)
        let p4 = Product(image: UIImage(named: "camiseta4")!, title: "Camiseta Blanca Oversize", price: 20)
        let p5 = Product(image: UIImage(named: "camiseta5")!, title: "Camiseta Negra", price: 18)
        let p6 = Product(image: UIImage(named: "camiseta6")!, title: "Camiseta Verde", price: 12)
        let p7 = Product(image: UIImage(named: "camiseta7")!, title: "Camiseta Amarillo Claro", price: 25)
        let p8 = Product(image: UIImage(named: "sudadera1")!, title: "Sudadera Rosa", price: 35)
        let p9 = Product(image: UIImage(named: "sudadera2")!, title: "Sudadera Gris", price: 30)
        let p10 = Product(image: UIImage(named: "sudadera3")!, title: "Sudadera Verde", price: 30)
        let p11 = Product(image: UIImage(named: "sudadera4")!, title: "Sudadera Negra", price: 25)
        let p12 = Product(image: UIImage(named: "sudadera7")!, title: "Sudadera Azul Cielo", price: 30)
        
        temp.append(p1)
        temp.append(p2)
        temp.append(p3)
        temp.append(p4)
        temp.append(p5)
        temp.append(p6)
        temp.append(p7)
        temp.append(p8)
        temp.append(p9)
        temp.append(p10)
        temp.append(p11)
        temp.append(p12)
        
        
        
        return temp
    }
    
    func setupUI(){
        navigationItem.title = "Catálogo"
        
        tableView.backgroundColor = .clear
        
        itemsEnCarrito.text = "Items: \(itemsCarrito)"
        comprarTotal.text = "Total: \(totalCarrito) €"
        tiendaIcono.image = UIImage(named: "white cart")
        bottomView.backgroundColor = .clear
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "segueProductoInfo":
            let indexPath = tableView.indexPathForSelectedRow
            let productView = segue.destination as? ProductoInfoViewController
            productView?.producto = products[indexPath!.row]
            productView?.controlProductosCarrito = self
        case "segueCarritoInfo":
            let vistaCarrito = segue.destination as? CarroInfoViewController
            vistaCarrito?.controlProductosCarrito = self
        case "perfilInfo":
            _ = segue.destination as? HomeViewController
        default:
            print("Vaya.")
        }
    }

    @IBAction func botonEnseñarPerfil(_ sender: UIButton) {
    }
    
    
    func enseñarVistaHome(result: AuthDataResult?, error: Error?, provider: ProviderType) {
        
        if let result = result, error == nil {
            
            self.navigationController?.pushViewController(HomeViewController(email: result.user.email!, provider: .basic), animated: true)
            
        } else {
            let alertController = UIAlertController(title: "Error", message: "Se ha producido un error de autenticación mediante \(provider.hashValue)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }

    }
    
    
}

extension RopaTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let producto = products[indexPath.row]
        let celda = tableView.dequeueReusableCell(withIdentifier: "celdaRopa") as? CeldaRopaTableViewCell
        celda?.colocarProducto(product: producto)
        return celda!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueProductoInfo", sender: products[indexPath.row])
        //tableView.deselectRow(at: indexPath, animated: true)
    }
}
    

