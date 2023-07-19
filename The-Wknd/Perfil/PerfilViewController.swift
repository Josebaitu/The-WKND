//
//  PerfilViewController.swift
//  The-WKND
//
//  Created by Joseba Iturrioz Aguirre on 22/6/23.
//

import UIKit
import FirebaseAuth

enum ProviderType: String{
    case basic
}

class PerfilViewController: UIViewController {

    @IBOutlet weak var imagenPerfil: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var proveedorLabel: UILabel!
    
    var email: String = ""
    let provider: ProviderType = .basic
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Perfil"
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        //Guardar datos de usuario
        
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(provider.rawValue, forKey: "provider")
        defaults.synchronize()
        
    }
    

    @IBAction func cerrarSesionAccionBoton(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "provider")
        defaults.synchronize()
        
        switch provider {
        case .basic:
            firebaseLogOut()
        }
        navigationController?.pushViewController(AutenticacionViewController(), animated: true)
        
        }
    
    private func firebaseLogOut() {
        
        do {
            try Auth.auth().signOut()
            
        } catch {
            //Error
        }
    }
}
