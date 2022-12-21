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

    fileprivate func currentRootViewController() -> UINavigationController? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController as? UINavigationController
        } else {
            return UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
        }
    }

    func load(on window: UIWindow?) {
        let module = LoadModule(networkManager: networkManager)
        let viewController = module.generateViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func showDetailViewController(_ bookInfo: BookViewModelMapper) {
        let module = LoadModule(networkManager: networkManager)
        let viewController = module.generateDetailViewController(bookInfo)
        currentRootViewController()?.pushViewController(viewController, animated: true)
    }
}
