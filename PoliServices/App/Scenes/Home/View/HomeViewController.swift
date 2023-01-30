//
//  HomeViewController.swift
//  PoliServices
//
//  Created by Rodrigo Policante Martins on 30/11/22.
//

import UIKit

class HomeViewController: UIViewController {

    private let viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var homeView: HomeView = {
        let view = HomeView()
        view.serviceButtonAction = { [unowned self] in
            self.didTapNewServiceButton()
        }
        
        return view
    }()
    
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
    
    private func configureView() {
        viewModel.getCurrentDate()
        configureDescriptionLabel()
    }
    
    private func configureDescriptionLabel() {
        viewModel.getDescriptionLabel { [unowned self] descriptionText in
            self.homeView.descriptionText = descriptionText
        }
    }
    
    private func didTapNewServiceButton() {
        let selectServiceNavigationController = selectServiceNavigationControllerFactory()
        show(selectServiceNavigationController, sender: self)
    }
    
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

extension HomeViewController: HomeViewModelDelegate {
    
    func didGet(_ currentDate: String) {
        homeView.currentDateLabelText = currentDate
    }
    
    func failedToGetCurrentDate() {
        homeView.currentDateLabelText = ""
    }
}

extension HomeViewController: ScheduledServiceDelegate {

    func didGetScheduledService(service: PoliServiceViewModel) {
        
        homeView.serviceNameText = service.name
        homeView.serviceDateText = "\(service.date) - \(service.statusMessage)"
        homeView.serviceHexColor = service.hexColor
        homeView.configureServiceView(hasService: true)
    }

    func noScheduledService() {
        
        homeView.configureServiceView(hasService: false)
    }
}
