class SelectServiceViewModel: SelectServiceViewModelProtocol {
    
    var serviceFetcher: ServiceFetcherProtocol
    
    init(serviceFetcher: ServiceFetcherProtocol) {
        self.serviceFetcher = serviceFetcher
    }
    
    var services: ServicesModel = []
    
    weak var delegate: SelectServiceViewDelegate?
    
    func getServices() {
        
        serviceFetcher.getServices { [weak self] result in
            
            guard let self else { return }
            
            switch result {
            case .success(let data):
                
                guard let services = data.decode(to: SelectServicesModel.self)?.data else {
                    self.delegate?.failedToGetServicesDate()
                    
                    return
                }
                
                self.services = services
                
                self.delegate?.didGetSelectServices()
            case .failure(_):
                
                fatalError()
            }
        }
    }
}
