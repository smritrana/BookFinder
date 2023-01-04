//
//  LoadContainer.swift
//  BookFinder
//
//  Created by Smriti Rana on 13/12/22.
//

import UIKit

class Routing {
    
    fileprivate func currentRootViewController() -> UINavigationController? {
        if #available(iOS 13, *) {
            if let window = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.first, let root = window.rootViewController {
                return root as? UINavigationController
            }
        } else {
            return UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
        }
        return UINavigationController()
    }

    func load(on window: UIWindow?) {
        let viewController = DependencyContainer().generateViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func showDetailViewController(_ bookInfo: BookViewModelMapper) {
        let viewController = DependencyContainer().generateDetailViewController(bookInfo)
        currentRootViewController()?.pushViewController(viewController, animated: true)
    }
}
