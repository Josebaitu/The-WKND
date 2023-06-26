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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Inicio de Sesión"
        
        
        let defaults = UserDefaults.standard
        if let email = defaults.value(forKey: "email") as? String,
           let provider = defaults.value(forKey: "provider") as? String {
            
            autenticacionStackview.isHidden = true
            self.navigationController?.pushViewController(RopaTableViewController(email: email, provider: ProviderType.init(rawValue: provider)!), animated: false)
            
        }
    }
        @IBAction func registrarAccion(_ sender: Any) {
            //Contraseña de mínimo 6 carácteres
            if let email = emailTextField.text, let contraseña = contraseñaTextField.text {
                Auth.auth().createUser(withEmail: email, password: contraseña) { (result, error) in
                    
                    self.enseñarVistaRopa(result: result, error: error, provider: .basic)
                }
            }
            
        }
        
        @IBAction func accederAccion(_ sender: Any) {
            // Contraseña de mínimo 6 carácteres
            if let email = emailTextField.text, let contraseña = contraseñaTextField.text {
                Auth.auth().signIn(withEmail: email, password: contraseña) { (result, error) in
                    
                    self.enseñarVistaRopa(result: result, error: error, provider: .basic)
                }
            }
        }
        
        private func enseñarVistaRopa(result: AuthDataResult?, error: Error?, provider: ProviderType) {
            
            if let result = result, error == nil {
                
                self.navigationController?.pushViewController(RopaTableViewController(email: result.user.email!, provider: .basic), animated: true)
                
            } else {
                let alertController = UIAlertController(title: "Error", message: "Se ha producido un error de autenticación mediante \(provider.hashValue)", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
        
        /*private func enseñarTabla() {
            let storyboard = UIStoryboard(name: "RopaTableView", bundle: nil)
            let viewController = storyboard.instantiateInitialViewController()!
            navigationController?.pushViewController(viewController, animated: true)
        }*/
    
    }
    



