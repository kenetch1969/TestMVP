//
//  File.swift
//  TestMVP
//
//  Created by Juan Gerardo Cruz on 1/19/20.
//  Copyright © 2020 inventaapps. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol MoviesDAO {
    func insertaMovie(data: Dictionary<String, Any>, completion: (Bool, String ) ->())
    func fetchMovieAll(completion: (Bool, [NSManagedObject]) ->())
    func updateMovie(data: Dictionary<String, Any>, update: NSManagedObject, completion: (Bool, String) -> ())
}


class MoviesDAOImp: MoviesDAO {
    
    private var appDelegate:AppDelegate
    private var managerContext: NSManagedObjectContext
    
    init(){
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managerContext = appDelegate.persistentContainer.viewContext
    }
    
    func insertaMovie(data: Dictionary<String, Any>, completion: (Bool, String) -> ()) {
        let movie = Movies(context: managerContext)
        movie.titulo = data["titulo"] as? String ?? ""
        movie.genero = data["genero"] as? String ?? ""
        movie.anio = data["anio"] as? String ?? ""
        movie.url = data["url"] as? String ?? ""
        movie.favorito = data["favorito"] as? Bool ?? false
        do {
            try managerContext.save()
            completion(true, "Success")
        } catch let error as NSError {
            completion(false, error.userInfo.description)
        }
    }
    
    func updateMovie(data: Dictionary<String, Any>, update: NSManagedObject, completion: (Bool, String) -> ()) {
        update.setValue(data["favorito"] as? Bool ?? false, forKey: "favorito")
        
        do {
            try managerContext.save()
            completion(true, "Success")
        } catch let error as NSError {
            completion(false, error.userInfo.description)
        }
    }
    
    func fetchMovieAll(completion: (Bool, [NSManagedObject]) ->()) {
        let fetchMovies: NSFetchRequest<Movies> = Movies.fetchRequest()
        
        do {
            let fetch = try managerContext.fetch(fetchMovies)
            completion(true, fetch)
        } catch {
            completion(false, [NSManagedObject]())
        }
    }
    
}
