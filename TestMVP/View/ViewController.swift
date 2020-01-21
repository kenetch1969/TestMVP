//
//  ViewController.swift
//  TestMVP
//
//  Created by Juan Gerardo Cruz on 1/19/20.
//  Copyright © 2020 inventaapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAdd" {
            if let addVC = segue.destination as? AddViewController {
                let model = MoviesDAOImp()
                let presenter = AddPresenter(model: model)
                presenter.attachView(delegate: addVC)
                addVC.attachPresenter(presenter: presenter)
            }
        }
        if segue.identifier == "segueShow" {
            if let showVC = segue.destination as? ShowTableViewController {
                let model = MoviesDAOImp()
                let presenter = ShowPresenter(model: model)
                presenter.attachView(delegate: showVC)
                showVC.attachPresenter(presenter: presenter)
            }
        }
    }
}

