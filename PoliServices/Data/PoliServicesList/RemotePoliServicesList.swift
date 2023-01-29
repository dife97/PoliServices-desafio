class RemotePoliServicesList: PoliServicesList {
    
    private var httpGetClient: HttpGetClient
    var urlString = "https://9a1c098c-8f75-47ad-a938-ad3f9179490a.mock.pstmn.io/services"
    
    init(httpGetClient: HttpGetClient) {
        self.httpGetClient = httpGetClient
    }
    
    func getPoliServicesList(onComplete: @escaping (Result<PoliServices, PSError>) -> Void) {
        
        httpGetClient.get(from: urlString) { result in
            switch result {
            case .success(let data):
                guard let remotePoliServices = data.decode(to: RemotePoliServiceModel.self) else {
                    // TODO: implement PSError
                    return
                }
                
                if remotePoliServices.success {
                    var poliServices: PoliServices = []
                    
                    for remotePoliService in remotePoliServices.data {
                        
                        let poliService = PoliServiceModel(
                            name: remotePoliService.name,
                            icon: remotePoliService.icon,
                            color: remotePoliService.color,
                            duration: remotePoliService.duration
                        )
                        
                        poliServices.append(poliService)
                    }
                    
                    onComplete(.success(poliServices))
                } else {
                    // TODO: implement PSError
                    print("")
                }
            case .failure(_):
                // TODO: implement PSError
                print("")
            }
        }
    }
    
    
}
