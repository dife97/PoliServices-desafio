//
//  AppDelegate.swift
//  PoliServices
//
//  Created by Rodrigo Policante Martins on 30/11/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = homeFactory()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func homeFactory() -> UINavigationController {
        
        let currentDateProvider = FoundationCurrentDateProvider()
        let currentDate = CurrentDateUseCase(currentDateProviders: currentDateProvider)
        let homeViewModel = HomeViewModel(currentDate: currentDate)
        let homeViewController = HomeViewController(viewModel: homeViewModel)

        return UINavigationController(rootViewController: homeViewController)
    }
}
