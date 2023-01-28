import Foundation

protocol ServiceFetcherProtocol {
    
    var provider: NetworkProviderProtocol { get }
    
    func getServices(onComplete: @escaping (Result<Data, CustomError>) -> Void)
}

class ServiceFetcher: ServiceFetcherProtocol {
    
    var provider: NetworkProviderProtocol
    
    init(provider: NetworkProviderProtocol) {
        self.provider = provider
    }
    
    func getServices(onComplete: @escaping (Result<Data, CustomError>) -> Void) {
        
        provider.load(ServiceFetcherRequest.getServices) { result in

            switch result {
            case .success(let data):
                onComplete(.success(data))

            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
}
