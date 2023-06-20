//
//  HomeViewController.swift
//  The-WKND
//
//  Created by Joseba Iturrioz Aguirre on 30/5/23.
//

import UIKit
import FirebaseAuth

enum ProviderType: String{
    case basic
}

class HomeViewController: UIViewController {

    @IBOutlet weak var imagenPerfil: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var proveedorLabel: UILabel!
    @IBOutlet weak var cerrarSesionBoton: UIButton!
    
    private let email: String
    private let provider: ProviderType
    
    init(email: String, provider: ProviderType){
        self.email = email
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home"
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        emailLabel.text = email
        proveedorLabel.text = provider.rawValue
        
        //Guardar datos de usuario
        
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(provider.rawValue, forKey: "provider")
        defaults.synchronize()
        
    }
    

    @IBAction func cerrarSesionAccion(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "provider")
        defaults.synchronize()
        
        switch provider {
        case .basic:
            firebaseLogOut()
        }
        navigationController?.popViewController(animated: true)
        
        }
    
    private func firebaseLogOut() {
        
        do {
            try Auth.auth().signOut()
            
        } catch {
            //Error
        }
    }
}
