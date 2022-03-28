//
//  ColorViewController.swift
//  testdemo
//
//  Created by Pavle D Stevanović on 28.3.22..
//

import Foundation
import UIKit

class ColorViewController: UIViewController {
    var color: UIColor = .white {
        didSet {
            view.backgroundColor = color
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color
    }
}
