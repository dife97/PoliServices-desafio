//
//  SelectServiceViewController.swift
//  PoliServices
//
//  Created by Rodrigo Policante Martins on 30/11/22.
//

import UIKit

class SelectPoliServiceViewController: PSViewController {

    private let viewModel: SelectServiceViewModelProtocol
    
    init(viewModel: SelectServiceViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var selectServiceView: SelectServiceView = {
        let view = SelectServiceView()
        view.configureCollectionView(delegate: self, dataSource: self)
        return view
    }()

    override func loadView() {
        view = selectServiceView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        viewModel.getPoliServicesList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startLoading()
    }
    
    private func configureNavigationBar() {
        title = "Novo Serviço"
        
        let leftBarButtomItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(didTapCancelButton)
        )
        
        navigationItem.leftBarButtonItem = leftBarButtomItem
    }
    
    @objc private func didTapCancelButton() {
        dismiss(animated: true)
    }
}

extension SelectPoliServiceViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let poliService = viewModel.poliServices[indexPath.row]
        let selectDateViewController = selectDateViewControllerFactory(poliService: poliService)
        navigationController?.pushViewController(selectDateViewController, animated: true)
    }
}

extension SelectPoliServiceViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return getServiceCollectionViewCell(from: collectionView, indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.poliServices.count
    }
}

extension SelectPoliServiceViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150, height: 150)
    }
}

extension SelectPoliServiceViewController: SelectPoliServiceViewDelegate {
    
    func didGetPoliServicesList() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.stopLoading()
            self.selectServiceView.updateSelectServicesCollectionView()
        }
    }
    
    func failedToGetPoliServicesList() {
        
        DispatchQueue.main.async { [weak self] in 
            guard let self else { return }
            self.stopLoading()
            self.showAlert(
                title: "Oops",
                message: "Não foi possível carregar os PoliServices disponíveis.\n\nPor favor, tente novamente.") {
                    self.dismiss(animated: true)
            }
        }
    }
}

extension SelectPoliServiceViewController {
    
    func selectDateViewControllerFactory(poliService: PoliServiceModel) -> PSViewController {
        
        let poliServiceModel = PoliServiceModel(
            name: poliService.name,
            icon: poliService.icon,
            color: poliService.color,
            duration: poliService.duration
        )
        let selectDateViewModel = SelectDateViewModel(poliService: poliServiceModel,
                                                      pushNotificationProvider: PSLocalPushNotification())
        
        let selectDateViewController = SelectDateViewController(viewModel: selectDateViewModel)
        selectDateViewModel.delegate = selectDateViewController
        
        return selectDateViewController
    }
    
    func getServiceCollectionViewCell(from collectionView: UICollectionView,
                                      indexPath: IndexPath) -> ServiceCollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ServiceCollectionViewCell.identifier,
            for: indexPath
        )

        let poliService = viewModel.poliServices[indexPath.row]

        guard let serviceCollectionViewCell = cell as? ServiceCollectionViewCell else {
            return ServiceCollectionViewCell()
        }
        
        serviceCollectionViewCell.configure(with: poliService)
        
        return serviceCollectionViewCell
    }
}
