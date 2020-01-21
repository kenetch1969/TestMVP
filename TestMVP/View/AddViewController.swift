//
//  AddViewController.swift
//  TestMVP
//
//  Created by Juan Gerardo Cruz on 1/19/20.
//  Copyright © 2020 inventaapps. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    
    @IBOutlet weak var titutloTextField: UITextField!
    @IBOutlet weak var generoTextField: UITextField!
    @IBOutlet weak var anioTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var favoritoButton: UIButton!
    
    private var isFavorite = false
    private var presenter: AddPresenter?
    private let genero = ["Accion","Horror","Suspenso"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        generoTextField.inputView = picker
        
    }
    
    func attachPresenter(presenter: AddPresenter) {
        self.presenter = presenter
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func favoritoAction(_ sender: UIButton) {
        isFavorite = !isFavorite
        if isFavorite {
            self.favoritoButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
             self.favoritoButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @IBAction func salvarAction(_ sender: UIButton) {
        self.presenter?.addMovie(titulo: titutloTextField.text ?? "",
                                 genero: generoTextField.text ?? "",
                                 anio: anioTextField.text ?? "",
                                 url: urlTextField.text ?? "",
                                 favorito: isFavorite)
        
    }
    
}

extension AddViewController: AddPresenterDelegate {
    func addDidSucceed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addDidFailed(message: String) {
        print("Error")
    }
}

extension AddViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genero.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genero[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.generoTextField.text = genero[row]
    }
    
}
