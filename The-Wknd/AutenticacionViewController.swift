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
        
        //Pasamos automáticamente con sesión iniciada a primera vista
        let defaults = UserDefaults.standard
        if let _ = defaults.value(forKey: "email") as? String,
           let _ = defaults.value(forKey: "provider") as? String {
            
            autenticacionStackview.isHidden = true
            let storyboard = UIStoryboard(name: "RopaTableView", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "RopaTableView") as! RopaTableViewController
            viewController.email = emailTextField.text!
            navigationController?.pushViewController(viewController, animated: true)
            
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
                    
                    if let _ = result, error == nil {
                        let storyboard = UIStoryboard(name: "RopaTableView", bundle: nil)
                        let viewController = storyboard.instantiateInitialViewController() as! RopaTableViewController
                        viewController.email = emailTextField.text!
                        self.navigationController?.pushViewController(viewController, animated: true)
                        
                        
                        //self.enseñarVistaRopa(result: result, error: error, provider: .basic)
                        
                    } else {
                        let alertController = UIAlertController(title: "Error", message: "Se ha producido un error de autenticación mediante \(provider.hashValue)", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                        self.present(alertController, animated: true, completion: nil)
                        
                    }
                    
                }
                
            
            private func enseñarVistaHome(result: AuthDataResult?, error: Error?) {
                
                if let result = result, error == nil {
                    let storyboard = UIStoryboard(name: "VistaPerfilViewController", bundle: nil)
                    let viewController = storyboard.instantiateInitialViewController() as! VistaPerfilViewController
                    viewController.email = result.user.email!
                    self.navigationController?.pushViewController(viewController, animated: true)
                    
                } else {
                    let errorMessage = "Se ha producido un error de autenticación"
                    let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
      


