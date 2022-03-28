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
    @IBOutlet private weak var navigationButton: UIBarButtonItem!

    private let viewModel = ListViewControllerViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return !viewModel.isConnectionActive
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell),
            let destinationVC = segue.destination as? ColorViewController
        else { return }
        
        destinationVC.color = UIColor(hex: viewModel.items[indexPath.row].color)
    }
}

private extension ListViewController {
    func setupBindings() {
        viewModel.$items.bind(subscriber:
            tableView.rowsSubscriber(cellIdentifier: "cell", cellType: ItemTableViewCell.self, cellConfig: { cell, indexPath, item in
                cell.setupWith(color: UIColor(hex: item.color), title: item.name, subtitle: item.amount)
            }
        ))
        .store(in: &cancellables)
        
        viewModel.$isConnectionActive.sink { [weak self] isActive in
            self?.navigationButton.title = isActive ? "Stop" : "Start"
        }
        .store(in: &cancellables)
    }
    
    @IBAction func navbarButtonPressed() {
        if viewModel.isConnectionActive {
            viewModel.stopUpdating()
        } else {
            viewModel.startUpdating()
        }
    }
}
