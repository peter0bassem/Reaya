//
//  LoginViewController.swift
//  Reyaya
//
//  Created by Peter Bassem on 7/30/19.
//  Copyright © 2019 Peter Bassem. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginUsingFacebookButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loginUsingFacebookButton.moveImageLeftTextCenter(image: #imageLiteral(resourceName: "facebook icon"), imagePadding: 30, renderingMode: .alwaysOriginal)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard emailTextField.text != "", passwordTextField.text != "", let email = emailTextField.text, let password = passwordTextField.text else {
            AlertView.instance.showAlert(title: "Error", message: "Enter all inputs to continue.", buttonTitle: "Ok", alertType: AlertView.AlertType.failure, onCompletion: nil)
            return
        }
        ActivityIndicatorManager.shared.showProgressView()
        login(with: email, and: password)
    }
    
    private func login(with email: String, and password: String) {
        let loginFuture = LoginAPIClient.login(email: email, password: password)
        loginFuture.execute(onSuccess: { (loginModel) in
            guard let status = loginModel.status else { return }
            if status == 200 {
                guard let id = loginModel.id, let fName = loginModel.fname, let lName = loginModel.lname, let email = loginModel.email, let phone = loginModel.phone, let token = loginModel.token else { return }
                user = User(status: status, id: id, fname: fName, lname: lName, email: email, phone: phone, token: token)
                DispatchQueue.main.async {
                    ActivityIndicatorManager.shared.hideProgressView()
                    if let mainTabbar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "main_tab_bar") as? TabBarController {
//                        if let homeNavigationController = mainTabbar.controllers.first as? UINavigationController {
//                            if let homeVC = homeNavigationController.viewControllers.first as? HomeViewController {
//                                homeVC.currentUser = user
//                            }
//                        }
                        appDelegate?.window?.rootViewController = mainTabbar
                        appDelegate?.window?.makeKeyAndVisible()
                    }
                }
            }
        }) { (error) in
            ActivityIndicatorManager.shared.hideProgressView()
            print(error)
        }
    }
}
