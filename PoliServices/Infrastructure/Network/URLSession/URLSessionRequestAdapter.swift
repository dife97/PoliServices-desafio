import Foundation

protocol URLSessionRequest {
    var method: HTTPMethod { get }
    var urlString: String { get }
    var body: Data? { get }
    var parameters: [String: Any]? { get }
}

extension URLSessionRequest {
    var url: URL? { URL(string: urlString) }
}

class URLSessionRequestAdapter: URLSessionRequest {
    
    var method: HTTPMethod
    var urlString: String
    var body: Data?
    var parameters: [String : Any]?
    
    init(method: HTTPMethod, urlString: String, body: Data? = nil, parameters: [String : Any]? = nil) {
        self.method = method
        self.urlString = urlString
        self.body = body
        self.parameters = parameters
    }
    
    func makeURLRequest() -> URLRequest {
        guard let url = self.url else { return URLRequest(url: URL(string: "")!) }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        return request
    }
}
