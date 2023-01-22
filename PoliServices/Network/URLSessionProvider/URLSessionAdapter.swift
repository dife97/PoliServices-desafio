import Foundation

protocol URLSessionAdapter {
    
    func createURLRequest(from request: ApiRequestProtocol) -> URLRequest?
}

extension URLSessionAdapter {
    
    func createURLRequest(from request: ApiRequestProtocol) -> URLRequest? {
        
        guard let url = request.url else { return nil }
                
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        
        return urlRequest
    }
}
