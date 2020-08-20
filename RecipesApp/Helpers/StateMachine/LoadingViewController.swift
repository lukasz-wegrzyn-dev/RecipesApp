//
//  LoadingViewController.swift
//  RecipesApp
//
//  Created by acon on 20/08/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit

class LoadingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = UIColor.lightGray
        activity.startAnimating()
        view.addSubview(activity)
        activity.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activity.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            activity.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
        ])
        let infoLabel = UILabel()
        view.addSubview(infoLabel)
        infoLabel.textColor = UIColor.lightGray
        infoLabel.backgroundColor = .clear
        infoLabel.font = UIFont.boldSystemFont(ofSize: 25)
        infoLabel.text = NSLocalizedString("Loading...", comment: "")
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.bottomAnchor.constraint(equalTo: activity.topAnchor, constant: -10),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
}
