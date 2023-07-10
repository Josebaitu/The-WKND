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
        
/*
        let defaults = UserDefaults.standard
        if let email = defaults.value(forKey: "email") as? String,
           let provider = defaults.value(forKey: "provider") as? String {
            
            autenticacionStackview.isHidden = true
            self.navigationController?.pushViewController(RopaTableViewController(), animated: false)
               */
        }
        
        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        autenticacionStackview.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        enseñarTabla()
    }

    @IBAction func registrarAccion(_ sender: Any) {
        
        if let email = emailTextField.text, let contraseña = contraseñaTextField.text {
            Auth.auth().createUser(withEmail: email, password: contraseña) { (result, error) in
                
                self.enseñarVistaHome(result: result, error: error)
            }
        }
        
    }
    
    @IBAction func accederAccion(_ sender: Any) {
        
        if let email = emailTextField.text, let contraseña = contraseñaTextField.text {
            Auth.auth().signIn(withEmail: email, password: contraseña) { (result, error) in
                
                self.enseñarVistaHome(result: result, error: error)
            }
        }
    }
    
    private func enseñarVistaHome(result: AuthDataResult?, error: Error?) {
        
        if let result = result, error == nil {
            let storyboard = UIStoryboard(name: "HomeViewController", bundle: nil)
            let viewController = storyboard.instantiateInitialViewController() as! HomeViewController
            viewController.email = result.user.email
            self.navigationController?.pushViewController(viewController, animated: true)
            
        } else {
            let errorMessage = "Se ha producido un error de autenticación"
            let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }

    }
    
    private func enseñarTabla() {
        let storyboard = UIStoryboard(name: "RopaTableView", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()!
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}




