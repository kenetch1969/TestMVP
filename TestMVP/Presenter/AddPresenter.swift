//
//  AddPresenter.swift
//  TestMVP
//
//  Created by Juan Gerardo Cruz on 1/19/20.
//  Copyright © 2020 inventaapps. All rights reserved.
//

import Foundation


protocol AddPresenterDelegate {
    func addDidSucceed()
    func addDidFailed(message: String)
}

class AddPresenter {
    private var model: MoviesDAO
    private var delegate: AddPresenterDelegate?
    
    init(model: MoviesDAO) {
        self.model = model
    }
    
    func attachView(delegate: AddPresenterDelegate) {
        self.delegate = delegate
    }
    
    func addMovie(titulo: String, genero: String, anio: String, url: String, favorito: Bool) {
        
        let movie: Dictionary<String, Any> = ["titulo":titulo,
                                              "genero": genero, "anio": anio,
                                              "url": url, "favorito": favorito]
        
        self.model.insertaMovie(data: movie) { (respo, message) in
            if respo {
                self.delegate?.addDidSucceed()
            } else {
                self.delegate?.addDidFailed(message: message)
            }
        }
        
    }
    
}
