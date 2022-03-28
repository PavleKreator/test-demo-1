//
//  ItemTableViewCell.swift
//  testdemo
//
//  Created by Pavle D Stevanović on 28.3.22..
//

import Foundation
import Hero
import UIKit

class ItemTableViewCell: UITableViewCell {
    @IBOutlet private weak var colorView: UIView?
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subtitleLabel: UILabel?
    
    func setupWith(color: UIColor, title: String, subtitle: String) {
        colorView?.backgroundColor = color
        titleLabel?.text = title
        subtitleLabel?.text = subtitle
    }
    
    func set(heroID: String) {
        colorView?.heroID = heroID
    }
}
