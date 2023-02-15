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
        
        UNUserNotificationCenter.current().requestPermission()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = homeFactory()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func homeFactory() -> UINavigationController {
        
        let homeViewModel = HomeViewModel(providers: getHomeViewModelProviders())
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        homeViewModel.delegate = homeViewController
        homeViewModel.scheduledServiceDelegate = homeViewController
        
        return UINavigationController(rootViewController: homeViewController)
    }
    
    private func getHomeViewModelProviders() -> HomeViewModelProviders {
        let providers = HomeViewModelProviders(
            currentDate: PSCurrentDate(),
            aboutUs: DefaultAboutUs(),
            countdown: PSCountdown()
        )
        
        return providers
    }
}
