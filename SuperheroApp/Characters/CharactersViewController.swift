//
//  CharactersViewController.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

import UIKit
import Dip_UI

class CharactersViewController: UITableViewController {
    
    var detailViewController: CharacterDetailViewController?
    var presenter: CharactersMvpPresenter?
    var loadIndicator: UIActivityIndicatorView?
    var loadMoreIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? CharacterDetailViewController
        }
        
        self.loadIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.loadMoreIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        self.tableView.backgroundView = self.loadIndicator
        self.tableView.tableFooterView = self.loadMoreIndicator
        
        self.presenter?.takeView(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension CharactersViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.presenter != nil else {
            return 0
        }
        return self.presenter!.charactersCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = self.presenter?.characters()[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = character?.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastItemReached = indexPath.row == (self.presenter?.charactersCount())! - 1
        
        if (lastItemReached) {
            self.presenter?.loadMoreCharacters()
        }
    }
}

extension CharactersViewController: CharactersMvpView {
    func showLoadingIndicator() {
        self.loadIndicator?.startAnimating()
    }
    
    func hideLoadingIndicator() {
        self.loadIndicator?.stopAnimating()
    }
    
    func showMoreLoadingIndicator() {
        self.loadMoreIndicator?.startAnimating()
    }
    
    func hideMoreLoadingIndicator() {
        self.loadMoreIndicator?.stopAnimating()
    }
    
    func refreshCharacters() {
        self.tableView.reloadData()
    }
    
    func showLoadingCharactersError(message: String) {
        // TODO show error
    }
    
    func showNoCharacters() {
        // TODO show no characters ui
    }
}

extension CharactersViewController: StoryboardInstantiatable {}
