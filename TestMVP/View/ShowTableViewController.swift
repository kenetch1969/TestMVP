//
//  ShowTableViewController.swift
//  TestMVP
//
//  Created by Juan Gerardo Cruz on 1/19/20.
//  Copyright © 2020 inventaapps. All rights reserved.
//

import UIKit
import CoreData

protocol ShowTableViewCellDelegate {
    func favorito(_ cell: ShowTableViewCell,_ isFavorito: Bool )
}


class ShowTableViewCell: UITableViewCell {

    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var generoLabel: UILabel!
    @IBOutlet weak var anioLabel: UILabel!
    @IBOutlet weak var favoritoButton: UIButton!
    @IBOutlet weak var imageMovie: UIImageView!
    
    
    private var isFavorite = false
    var delegate: ShowTableViewCellDelegate?
    
    var movie: NSManagedObject? {
        didSet {
            guard let item = movie else { return }
            tituloLabel.text = item.value(forKey: "titulo") as? String ?? ""
            generoLabel.text = item.value(forKey: "genero") as? String ?? ""
            anioLabel.text = item.value(forKey: "anio") as? String ?? ""
            isFavorite = item.value(forKey: "favorito") as? Bool ?? false
            if isFavorite {
                self.favoritoButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                self.favoritoButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            imageMovie.dowloadFromServer(link: item.value(forKey: "url") as? String ?? "")
        }
    }
    
    @IBAction func favoritoAction(_ sender: UIButton) {
        isFavorite = !isFavorite
        if isFavorite {
            self.favoritoButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.delegate?.favorito(self, true)
        } else {
            self.favoritoButton.setImage(UIImage(systemName: "heart"), for: .normal)
            self.delegate?.favorito(self, false)
        }
    }
}

class ShowTableViewController: UITableViewController {
    
    
    private var movie = [NSManagedObject]()
    private var presenter: ShowPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.rowHeight = 136
        self.presenter?.showMovies()
    }
    
    func attachPresenter(presenter: ShowPresenter) {
        self.presenter = presenter
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movie.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShowTableViewCell
        
        cell.delegate = self
        cell.movie = movie[indexPath.item]
        
        return cell
    }
    
}

extension ShowTableViewController: ShowPresenterDelegate {
    func favoriteDidSucced() {
        print("Exitoso")
    }
    
    func favoriteDidFailed(message: String) {
        print(message)
    }
    
    func showDidSucceed(data: [NSManagedObject]) {
        self.movie = data
        self.tableView.reloadData()
    }
    
    func showDidFailed(message: String) {
        print(message)
    }
}

extension ShowTableViewController: ShowTableViewCellDelegate {
    func favorito(_ cell: ShowTableViewCell, _ isFavorito: Bool) {
        if let indexPath = tableView.indexPath(for: cell) {
            self.presenter?.updateFavorite(data: movie[indexPath.item], favorito: isFavorito)
        }
    }
}
