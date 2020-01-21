//
//  ShowPresenter.swift
//  TestMVP
//
//  Created by Juan Gerardo Cruz on 1/19/20.
//  Copyright © 2020 inventaapps. All rights reserved.
//

import Foundation
import CoreData

protocol ShowPresenterDelegate {
    func showDidSucceed(data: [NSManagedObject])
    func showDidFailed(message: String)
    func favoriteDidSucced()
    func favoriteDidFailed(message: String)
}

class ShowPresenter {
    private var model: MoviesDAO
    private var delegate: ShowPresenterDelegate?
    
    init(model: MoviesDAO) {
        self.model = model
    }
    
    func attachView(delegate: ShowPresenterDelegate) {
        self.delegate = delegate
    }
    
    func showMovies() {
        self.model.fetchMovieAll { (resp, data) in
            if resp {
                self.delegate?.showDidSucceed(data: data)
            } else {
                self.delegate?.showDidFailed(message: "No hay")
            }
        }
    }
    
    func updateFavorite(data: NSManagedObject, favorito: Bool) {
        let favorito: Dictionary<String,Any> = ["favorito": favorito]
        
        self.model.updateMovie(data: favorito, update: data) { (resp, message) in
            if resp {
                self.delegate?.favoriteDidSucced()
            } else {
                self.delegate?.favoriteDidFailed(message: message)
            }
        }
    }
}
