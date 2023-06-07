//
//  AutenticacionViewController.swift
//  The-Wknd
//
//  Created by Joseba Iturrioz Aguirre on 29/5/23.
//

import UIKit
import FirebaseAnalytics
import FirebaseAuth

class AutenticacionViewController: UIViewController {

    //Inicio de sesion
    
    @IBOutlet weak var autenticacionStackview: UIStackView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var contraseñaTextField: UITextField!
    @IBOutlet weak var registrarBoton: UIButton!
    @IBOutlet weak var accederBoton: UIButton!
    
    let url = "https://api.escuelajs.co/api/v1/products"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Inicio de Sesión"
        
        Analytics.logEvent("InitScreen", parameters: ["Message ": "Integración de Firebase completa"])
        let defaults = UserDefaults.standard
        if let email = defaults.value(forKey: "email") as? String,
           let provider = defaults.value(forKey: "provider") as? String {
            
            autenticacionStackview.isHidden = true
            self.navigationController?.pushViewController(HomeViewController(email: email, provider: ProviderType(rawValue: provider)!), animated: false)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        autenticacionStackview.isHidden = false
    }
    

    @IBAction func registrarAccion(_ sender: Any) {
        
        if let email = emailTextField.text, let contraseña = contraseñaTextField.text {
            Auth.auth().createUser(withEmail: email, password: contraseña) { (result, error) in
                
                self.enseñarVistaHome(result: result, error: error, provider: .basic)
            }
        }
        
    }
    
    @IBAction func accederAccion(_ sender: Any) {
        
        if let email = emailTextField.text, let contraseña = contraseñaTextField.text {
            Auth.auth().signIn(withEmail: email, password: contraseña) { (result, error) in
                
                self.enseñarVistaHome(result: result, error: error, provider: .basic)
            }
        }
    }
    
    private func enseñarVistaHome(result: AuthDataResult?, error: Error?, provider: ProviderType) {
        
        if let result = result, error == nil {
            
            self.navigationController?.pushViewController(HomeViewController(email: result.user.email!, provider: .basic), animated: true)
            
        } else {
            let alertController = UIAlertController(title: "Error", message: "Se ha producido un error de autenticación mediante \(provider.hashValue)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }

    }
    
}




