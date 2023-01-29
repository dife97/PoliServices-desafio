class SelectServiceViewModel: SelectServiceViewModelProtocol {
    
    var poliServicesList: PoliServicesList
    
    init(poliServicesListProvider: PoliServicesList) {
        self.poliServicesList = poliServicesListProvider
    }
    
    var poliServices: PoliServices = []
    
    weak var delegate: SelectPoliServiceViewDelegate?
    
    
    
    
    
    func getPoliServicesList() {
        poliServicesList.getPoliServicesList { [weak self] result in
            guard let self else { return } //TODO: implement error?
            
            switch result {
            case .success(let poliServices):
                self.poliServices = poliServices
                self.delegate?.didGetPoliServicesList()
                
            case .failure(_):
                self.delegate?.failedToGetPoliServicesList()
            }
        }
    }
}
