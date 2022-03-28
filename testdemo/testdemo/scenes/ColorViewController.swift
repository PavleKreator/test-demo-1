//
//  ColorViewController.swift
//  testdemo
//
//  Created by Pavle D Stevanović on 28.3.22..
//

import Foundation
import UIKit

class ColorViewController: UIViewController {
    @IBOutlet private weak var colorView: UIView?
    
    var color: UIColor = .white {
        didSet {
            colorView?.backgroundColor = color
        }
    }
    
    var colorHeroID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView?.backgroundColor = color
        colorView?.heroID = colorHeroID
    }
}
