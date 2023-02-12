//
//  HomeViewController.swift
//  PoliServices
//
//  Created by Rodrigo Policante Martins on 30/11/22.
//

import UIKit

class HomeViewController: PSViewController {

    // MARK: - Dependencies
    private let viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - UI
    private lazy var homeView: HomeView = {
        let view = HomeView()
        view.serviceButtonAction = { [unowned self] in
            self.didTapNewServiceButton()
        }
        
        return view
    }()
    
    // MARK: - Lifecycles
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.checkScheduledPoliService()
    }
    
    // MARK: - View Configuration
    private func configureView() {
        viewModel.getCurrentDate()
        viewModel.getAboutUsDescription()
    }
    
    // MARK: - Actions
    private func didTapNewServiceButton() {
        let selectServiceNavigationController = selectServiceNavigationControllerFactory()
        show(selectServiceNavigationController, sender: self)
    }
    
    // MARK: - Navigation
    func selectServiceNavigationControllerFactory() -> UINavigationController {
        let urlSessionGetProvider = URLSessionGetClient()
        let poliServicesListProvider = RemotePoliServicesList(httpGetClient: urlSessionGetProvider)
        let viewModel = SelectServiceViewModel(poliServicesListProvider: poliServicesListProvider)
        let viewController = SelectPoliServiceViewController(viewModel: viewModel)
        viewModel.delegate = viewController

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen

        return navigationController
    }
}

// MARK: - Current Date
extension HomeViewController: HomeViewModelDelegate {
    
    func didGet(_ currentDate: String) {
        homeView.currentDateLabelText = currentDate
    }
    
    func failedToGetCurrentDate() {
        homeView.currentDateLabelText = ""
    }
}

// MARK: - About Us Description
extension HomeViewController {
    
    func didGetAboutUs(descriptionText: String) {
        homeView.descriptionText = descriptionText
    }
}

// MARK: - Scheduled PoliService
extension HomeViewController: ScheduledServiceDelegate {

    func didGetScheduledService(service: PoliServiceViewModel) {
        homeView.serviceNameText = service.name
        homeView.serviceDateText = "\(service.date) - \(service.statusMessage)"
        homeView.serviceHexColor = service.hexColor
        homeView.serviceImageViewName = service.icon
        homeView.configureServiceView(hasService: true)
    }

    func noScheduledService() {
        homeView.configureServiceView(hasService: false)
    }
}
