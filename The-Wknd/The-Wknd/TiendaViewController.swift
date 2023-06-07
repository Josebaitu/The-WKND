//
//  TiendaViewController.swift
//  The-WKND
//
//  Created by Joseba Iturrioz Aguirre on 7/6/23.
//

import UIKit

class TiendaViewController: UIViewController {
    
    @IBOutlet weak var tablaRopa: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tablaRopa.delegate = self
        tablaRopa.dataSource = self
    }

}

extension TiendaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaRopa.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        celda.textLabel?.text = "Hola"
        return celda
    }
    
    
}
