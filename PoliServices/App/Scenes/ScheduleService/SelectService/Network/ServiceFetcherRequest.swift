import Foundation

enum ServiceFetcherRequest {
    
    case getServices
}

extension ServiceFetcherRequest: ApiRequestProtocol {
    
    var method: HTTPMethod { .get }
    
    var endpoint: String { "services" }
    
    var body: Data? { nil }
    
    var parameters: [String : Any]? { nil }
}
