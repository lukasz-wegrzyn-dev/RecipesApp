//
//  HomeViewController.swift
//  RecipesApp
//
//  Created by acon on 20/08/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var searchController: UISearchController = UISearchController()
    
    var presenter: HomePresenting!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData(viewModel: presenter.viewModel)
        setupLayout()
    }
    
    func setupLayout() {
        searchController.searchBar.tintColor = .white
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Find the best recipes...", comment: "")
        navigationItem.searchController = searchController
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
}

//MARK: View model
extension HomeViewController {
    class ViewModel {
        let title: String
        var cells: [RecipeCell.ViewModel]
        init(title: String, cells: [RecipeCell.ViewModel] = []) {
            self.cells = cells
            self.title = title
        }
    }
}

//MARK: Table view
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.viewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.identifier, for: indexPath)
        if let cell = cell as? RecipeCell {
            let viewModel = presenter.viewModel.cells[indexPath.row]
            cell.update(viewModel: viewModel)
        }
        return cell
    }
}

//MARK: Search bar
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchButtonClicked(text: searchBar.text, completion: nil)
    }
}

//MARK: Interface
protocol HomeViewing: class {
    func updateData(viewModel: HomeViewController.ViewModel)
    func showErrorAlert(error: Error)
}

extension HomeViewController: HomeViewing {
    func updateData(viewModel: HomeViewController.ViewModel) {
        guard isViewLoaded else { return }
        self.title = viewModel.title
        tableView.isHidden = viewModel.cells.isEmpty
        tableView.reloadData()
    }
    func showErrorAlert(error: Error) {
        let alert = UIAlertController.createErrorAlert(errorMessage: error.localizedDescription, completion: nil)
        self.present(alert, animated: true)
    }
}
