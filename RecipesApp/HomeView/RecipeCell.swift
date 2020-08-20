//
//  RecipeCell.swift
//  RecipesApp
//
//  Created by acon on 20/08/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class RecipeCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    static let identifier: String = "RecipeCell"
    let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.iconImageView.clipsToBounds = true
        self.iconImageView.layer.cornerRadius = 5.0
        self.iconImageView.layer.borderColor = UIColor.white.cgColor
        self.iconImageView.layer.borderWidth = 1.0
        
        activityIndicatorView.color = UIColor.lightGray
        activityIndicatorView.isHidden = true
        iconImageView.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor, constant: 0),
            activityIndicatorView.centerXAnchor.constraint(equalTo: iconImageView.centerXAnchor, constant: 0),
        ])
    }
    
    func update(viewModel: ViewModel) {
        let attrStr = NSAttributedString.concat([
            NSAttributedString.bold(str: "\(viewModel.title)\n\n", fontSize: 17.0, color: .white),
            NSAttributedString.normal(str: "\(viewModel.ingredientLines.joined(separator: "\n\n"))", fontSize: 15.0, color: .gray)
        ])
        self.titleLabel.attributedText = attrStr
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        if let imageUrl = viewModel.imageUrl, let url = URL(string: imageUrl) {
            self.iconImageView.sd_setImage(with: url) {[weak self] (image, error, _, _) in
                if image != nil {
                    self?.activityIndicatorView.isHidden = true
                    self?.activityIndicatorView.stopAnimating()
                }
            }
        }
    }
    
    private func enableBorder(enable: Bool) {
        self.iconImageView.layer.borderColor = enable ? UIColor.white.cgColor : UIColor.clear.cgColor
    }
}

//MARK: View model
extension RecipeCell {
    class ViewModel {
        let title: String
        let imageUrl: String?
        let ingredientLines: [String]
        
        init(title: String, imageUrl: String?, ingredientLines: [String]) {
            self.title = title
            self.imageUrl = imageUrl
            self.ingredientLines = ingredientLines
        }
        
        convenience init(recipe: Recipe) {
            self.init(title: recipe.title, imageUrl: recipe.imageUrl, ingredientLines: recipe.ingredientLines)
        }
    }
}
