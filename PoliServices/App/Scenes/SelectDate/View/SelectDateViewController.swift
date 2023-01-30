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
    
    private lazy var selectDateView: SelectDateView = {
        let view = SelectDateView()
        view.didChangeTime = { [unowned self] in
            self.configureEstimatedTimeLabels()
        }
        
        return view
    }()

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
    
    private func configureEstimatedTimeLabels() {
        
        let duration = viewModel.poliService.duration
        let dateTimeInterval = selectDateView.timeIntervalSince1970 + duration * 60
        let date = Date(timeIntervalSince1970: dateTimeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let estimatedEndText = dateFormatter.string(from: date)
        
        selectDateView.configureDurationLabels(durationText: "\(Int(duration))",
                                               estimatedEndText: estimatedEndText)
    }
}

extension SelectDateViewController: SelectDateViewDelegate {
    
    func didSavePoliService() {
        dismiss(animated: true)
    }
}
