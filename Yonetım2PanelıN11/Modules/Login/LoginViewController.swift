//
//  LoginViewController.swift
//  Yonetım2PanelıN11
//
//  Created by alime.kilinc on 24.07.2025.
//

import UIKit

protocol ViewProtocol: AnyObject {
    func showError(message: String)
}
class LoginViewController: UIViewController, ViewProtocol {
    var presenter: Presenter!
    @IBOutlet weak var emailBtn: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func deneme(_ sender: Any) {
        print("deneme")
        print("presenter is \(String(describing: presenter))")
        let email = emailBtn.text ?? ""
        presenter?.loginButtonTapped()
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
                present(alert, animated: true)
    }
    
}
