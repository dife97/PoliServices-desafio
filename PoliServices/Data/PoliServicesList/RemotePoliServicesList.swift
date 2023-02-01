class RemotePoliServicesList: PoliServicesList {
    
    private let httpGetClient: HttpGetClient
    private let urlString = "https://9a1c098c-8f75-47ad-a938-ad3f9179490a.mock.pstmn.io/services"
    
    init(httpGetClient: HttpGetClient) {
        self.httpGetClient = httpGetClient
    }
    
    func getPoliServicesList(onComplete: @escaping (Result<PoliServices, PSError>) -> Void) {
        
        httpGetClient.get(from: urlString) { result in
            
            switch result {
            case .success(let data):
                guard let remotePoliServices = data.decode(to: RemotePoliServiceModel.self) else {
                    onComplete(.failure(.failedToDecodeData))
                    return
                }
                
                if remotePoliServices.success {
                    var poliServices: PoliServices = []
                    
                    for remotePoliService in remotePoliServices.data {
                        let poliService = PoliServiceModel(
                            name: remotePoliService.name,
                            icon: remotePoliService.icon,
                            color: remotePoliService.color,
                            duration: Double(remotePoliService.duration)
                        )
                        
                        poliServices.append(poliService)
                    }
                    
                    onComplete(.success(poliServices))
                } else {
                    onComplete(.failure(.responseError))
                }
            case .failure(let error):
                onComplete(.failure(.networkError(message: error.localizedDescription)))
            }
        }
    }
}
