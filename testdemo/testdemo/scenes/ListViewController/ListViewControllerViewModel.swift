//
//  ListViewControllerViewModel.swift
//  testdemo
//
//  Created by Pavle D StevanoviÄ‡ on 28.3.22..
//

import Combine
import Foundation
import UIKit

struct Item: Hashable {
    var name: String
    var amount: String
    var color: String
}

class ListViewControllerViewModel {
    
    struct Const {
        static let socketURL = URL(string:"wss://superdo-groceries.herokuapp.com/receive")!
    }
    
    struct SocketItem: Codable {
        var bagColor: String?
        var name: String?
        var weight: String?
        
        var item: Item { .init(name: name ?? "", amount: weight ?? "", color: bagColor ?? "") }
    }

    
    @Published private(set) var items: [Item] = []
    @Published private(set) var isConnectionActive = true
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        startUpdating()
    }
    
    func stopUpdating() {
        cancellables = []
        isConnectionActive = false
        items.sort { $0.color > $1.color }
    }
    
    func startUpdating() {
        isConnectionActive = true
        CodableWebSocket<SocketItem>(url: Const.socketURL)
            .receive(on: DispatchQueue.main, options: nil)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error) // TODO: Log & show to user
                }
            } receiveValue: { [weak self] result in
                guard case let .success(item) = result else { return }
                switch item {
                case .codable(let codableItem):
                    self?.items.insert(codableItem.item, at: 0)
                case .message(let dicString):
                    guard
                        let data = dicString.data(using: .utf8),
                        let codableItem = try? JSONDecoder().decode(SocketItem.self, from: data)
                    else { return }
                    self?.items.insert(codableItem.item, at: 0)
                case .uncodable:
                    break
                }
            }
            .store(in: &cancellables)
    }
}
