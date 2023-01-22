import Foundation

protocol NetworkProviderProtocol {
    
    func load(_ request: ApiRequestProtocol, onComplete: @escaping (Result<Data, CustomError>) -> Void)
}
