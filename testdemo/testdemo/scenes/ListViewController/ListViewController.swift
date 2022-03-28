//
//  ListViewController.swift
//  testdemo
//
//  Created by Pavle D Stevanović on 28.3.22..
//

import Combine
import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!

    private let viewModel = ListViewControllerViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel.$items.bind(subscriber:
            tableView.rowsSubscriber(cellIdentifier: "cell", cellType: ItemTableViewCell.self, cellConfig: { cell, indexPath, item in
                cell.setupWith(color: UIColor(hex: item.color), title: item.name, subtitle: item.amount)
            }
        ))
        .store(in: &cancellables)
    }
}
