//
//  SelectDateViewController.swift
//  PoliServices
//
//  Created by Rodrigo Policante Martins on 01/12/22.
//

import UIKit

class SelectDateViewController: UIViewController {
    
    private let viewModel: SelectDateViewModelProtocol
    
    init(viewModel: SelectDateViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var selectDateView = SelectDateView()

    override func loadView() {
        view = selectDateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()        
    }
    
    private func configureNavigationBar() {
        
        title = "Novo Serviço"
        
        let rightBarButtomItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(didTapSaveButton)
        )
        
        navigationItem.rightBarButtonItem = rightBarButtomItem
    }
    
    @objc private func didTapSaveButton() {
        
        viewModel.saveService(timeIntervalSince1970: selectDateView.timeIntervalSince1970)
    }
}

extension SelectDateViewController: SelectDateViewDelegate {
    
    func didSavePoliService() {
        dismiss(animated: true)
    }
}
