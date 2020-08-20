//
//  HomePresenter.swift
//  RecipesApp
//
//  Created by acon on 20/08/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit

class HomePresenter {
    private let router: HomeRouting
    private let interactor: HomeInteracting
    weak var vc: HomeViewing?
    var viewModel: HomeViewController.ViewModel = HomeViewController.ViewModel(title: NSLocalizedString("Recipes", comment: ""))
    private var stateMachine: StateMachine!
    
    init(router: HomeRouting, interactor: HomeInteracting, vc: HomeViewing) {
        self.router = router
        self.interactor = interactor
        self.vc = vc
        stateMachine = StateMachine(vc: vc as! UIViewController)
        stateMachine.didChanged = {[weak self] state in
            guard let weakSelf = self else { return }
            if state == .ready {
                weakSelf.vc?.updateData(viewModel: weakSelf.viewModel)
            }
        }
    }
    
    func updateViewModel(recipes: [Recipe]) {
        self.viewModel.cells = recipes.map { recipe in
            return RecipeCell.ViewModel(recipe: recipe)
        }
    }
}

protocol HomePresenting: class {
    var viewModel: HomeViewController.ViewModel { get set }
    func searchButtonClicked(text: String?, completion: (()->Void)?)
}

extension HomePresenter: HomePresenting {
    
    func searchButtonClicked(text: String?, completion: (()->Void)? = nil) {
        guard let text = text, !text.isEmpty else { return }
        self.stateMachine.state = .loading
        interactor.search(query: text) {[weak self] result in
            switch result {
            case .failure(let error):
                self?.vc?.showErrorAlert(error: error)
                break
            case .success(let recipes):
                self?.updateViewModel(recipes: recipes)
                break
            }
            completion?()
            self?.stateMachine.state = .ready
        }
    }
}
