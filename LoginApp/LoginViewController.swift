//
//  LoginViewController.swift
//  LoginApp
//
//  Created by Артем Ермак on 3/29/21.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let userName = "Terminator3000"
    let userPassword = "123456"

    @IBOutlet var userNameTF: UITextField!
    @IBOutlet var userPasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userNameTF.delegate = self
        self.userPasswordTF.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.userNameTF:
            self.userPasswordTF.becomeFirstResponder()
        default:
            self.userPasswordTF.resignFirstResponder()
            loginButtonPressed()
            performSegue(withIdentifier: "goToHelloVC", sender: nil)
        }
    }
    
    // Очистка полей при выходе
    @IBAction func unwindToLogInScreen(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindSegue" else { return }
        self.userNameTF.text = nil
        self.userPasswordTF.text = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let helloVC = segue.destination as? HelloViewController else { return }
        helloVC.helloUserName = userName
    }
    
    @IBAction func userNameButtonPressed() {
        showAlert(with: "Forgot Username?", and: "Your user name is \(userName)")
    }
    
    @IBAction func passwordButtonPressed() {
        showAlert(with: "Forgot password?", and: "Your password is \(userPassword)")
    }
    
    //Валидация данных
    @IBAction func loginButtonPressed() {
        if userNameTF.text != userName || userPasswordTF.text != userPassword {
            showAlert(with: "Error", and: "Please check your username and password")
        }
    }
    
    //Скрыть клавиатуру
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
// MARK: - Move View While Keyboard Showing
   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }

    @objc func keyboardWillChange(notification: NSNotification) {

        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if userPasswordTF.isFirstResponder || userNameTF.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height
            }
        }
    }
}

// MARK: - Allert Controller
extension LoginViewController {
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle:.alert)
        present(alert, animated: true)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
    }
}
