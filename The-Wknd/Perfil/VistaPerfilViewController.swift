//
//  VistaPerfilViewController.swift
//  The-WKND
//
//  Created by Joseba Iturrioz Aguirre on 11/7/23.
//

import UIKit
import FirebaseAuth

enum ProviderType: String{
    case basic
}

class VistaPerfilViewController: UIViewController {

    @IBOutlet weak var imagenPerfil: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var proveedorLabel: UILabel!
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var apellidosLabel: UILabel!
    
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var apellidosTextField: UITextField!
    
    var email: String = ""
    let provider: ProviderType = .basic
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Perfil"
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        proveedorLabel.text = "Provider: Basic"
        emailLabel.text = "Email: \(email)"
        
        
        //Guardar datos de usuario
        
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(provider.rawValue, forKey: "provider")
        defaults.synchronize()
        
    }
    
    @IBAction func aceptarAccionBoton(_ sender: Any) {
        let nombre = nombreTextField.text!
        let apellidos = apellidosTextField.text!
        
        nombreLabel.text = "Nombre: \(nombre)"
        apellidosLabel.text = "Apellidos: \(apellidos)"
        
        nombreTextField.isHidden = true
        apellidosTextField.isHidden = true
        
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
        //navigationController?.pushViewController(AutenticacionViewController(), animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Main") as! AutenticacionViewController
        navigationController?.pushViewController(viewController, animated: false)
        }
    
    @IBAction func vistaVuelta(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    private func firebaseLogOut() {
        
        do {
            try Auth.auth().signOut()
        } catch {
            //Error
        }
    }
}
