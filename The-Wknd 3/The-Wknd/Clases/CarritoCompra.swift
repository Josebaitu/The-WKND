//
//  CarritoCompra.swift
//  The-WKND
//
//  Created by Joseba Iturrioz Aguirre on 12/6/23.
//

import Foundation
import UIKit

class CarritoCompra {
    
    var listaProductos: [(Product, Int, Int)]
    var total: Int
    
    init(){
        self.listaProductos = []
        self.total = 0
    }
    
    func contarCarritoCompra(carrito: CarritoCompra) -> Int {
        var total = 0
        for producto in listaProductos {
            total += producto.1
        }
        return total
    }
    
    func calcularTotal(carrito: CarritoCompra) -> Int {
        var total = 0
        for producto in listaProductos{
            total += producto.1 * producto.0.price //Total = Cantidad * Precio del producto
        }
        return total
    }
    
    func imprimirContenidoCarrito(cart: CarritoCompra){
        for producto in listaProductos{
            print("\(producto.0.title)")
        }
    }

}
