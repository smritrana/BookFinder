//
//  AppFlow.swift
//  BookFinder
//
//  Created by Smriti Rana on 16/12/22.
//

import UIKit


protocol AppFlowManagerProtocol {
    func moveToDetailViewController()
}

class AppFlowManager: AppFlowManagerProtocol {
    static let shareInstance: AppFlowManager = AppFlowManager()
    // Private Initialier
    private init() {}
    
    private static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: self.bundle)
    }
    private static var bundle: Bundle {
        return Bundle(for: AppFlowManager.self)
    }
    
    fileprivate func currentRootViewController() -> UINavigationController? {
        if #available(iOS 13.0, *) {
            let sceneDelegate = UIApplication.shared.connectedScenes //
                .first!.delegate as! SceneDelegate
            return sceneDelegate.window?.rootViewController as? UINavigationController
        // iOS12 or earlier
        } else {
            return UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
        }
    }
    
    func moveToDetailViewController() {
        if let nextViewController = AppFlowManager.storyboard.instantiateViewController(withIdentifier: String(describing: BookDetailViewController.self)) as? UIViewController {
        self.currentRootViewController()?.pushViewController(nextViewController, animated: true)
        }
    }
}

   

