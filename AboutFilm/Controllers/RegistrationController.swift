//
//  RegistrationController.swift
//  AboutFilm
//
//  Created by илья on 04.04.23.
//

import UIKit

class RegistrationController: UIViewController {
    @IBOutlet weak var nicknameTF: UITextField!
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func registrationButton(_ sender: UIButton) {
        if nicknameTF.text! == "" || loginTF.text! == "" || passwordTF.text! == "" {
            self.present(getAllert(message: "Field nickname, login or password is empty"), animated: true)
        }
        let user = User(nickname: nicknameTF.text!, login: loginTF.text!, password: passwordTF.text!)
        if Auth().registration(user: user){
            let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HiController") as! FilmsController
            self.navigationController?.pushViewController(destination, animated: true)
        }else{
            self.present(getAllert(message: "Account already exist"), animated: true)

        }
    }
    
}
