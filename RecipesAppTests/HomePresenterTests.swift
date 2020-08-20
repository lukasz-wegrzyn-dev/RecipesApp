//
//  HomePresenterTests.swift
//  RecipesAppTests
//
//  Created by acon on 20/08/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import XCTest
@testable import RecipesApp

class HomePresenterTests: XCTestCase {
    var homePresenter: HomePresenter!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        let interactor = HomeInteractor(networkService: MockNetworkService())
        let router = HomeRouter(vc: vc)
        let presenter = HomePresenter(router: router,
                                      interactor: interactor,
                                      vc: vc)
        vc.presenter = presenter
        self.homePresenter = presenter
    }
    
    func testInitialViewModel() {
        XCTAssertEqual(homePresenter.viewModel.cells.count, 0)
    }
    
    func testSearchPhrase() {
        homePresenter.searchButtonClicked(text: "search phrase")
        XCTAssertEqual(homePresenter.viewModel.cells.count, 7)
    }
    
    func testEmptySearchPhrase() {
        homePresenter.searchButtonClicked(text: "")
        XCTAssertEqual(homePresenter.viewModel.cells.count, 0)
    }
}
