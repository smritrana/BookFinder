//
//  LoadContainer.swift
//  BookFinder
//
//  Created by Smriti Rana on 13/12/22.
//

import UIKit

class LoadContainer {
    
    var networkManager: NetworkManagerProtocol = {
        let networkManager = NetworkManager()
        return networkManager
    }()
    
    func load(on window: UIWindow?) {
        let module = LoadModule(networkManager: networkManager)
        let viewController = module.generateViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
