import Foundation

class URLSessionGetClient: HttpGetClient {
    
    private let urlSession: URLSession
    private var urlRequestAdapter: URLSessionRequestAdapter?
    
    init(
        urlSession: URLSession = URLSession.shared
    ) {
        self.urlSession = urlSession
    }
    
    func get(from urlString: String, onComplete: @escaping (Result<Data, PSError>) -> Void) {
        
        let urlRequest = URLSessionRequestAdapter(
            method: .get,
            urlString: urlString
        ).makeURLRequest()
        
        urlSession.dataTask(with: urlRequest) { data, urlResponse, error in
            if error == nil {
                guard let urlResponse = urlResponse as? HTTPURLResponse else {
                    onComplete(.failure(.failedToGetHttpUrlResponse))
                    return
                }
                
                guard let data else {
                    onComplete(.failure(.missingData))
                    return
                }
                
                if 200..<300 ~= urlResponse.statusCode {
                    onComplete(.success(data))
                } else {
                    onComplete(.failure(.httpError(statusCode: urlResponse.statusCode)))
                }
            } else {
                onComplete(.failure(.networkError(message: error!.localizedDescription)))
            }
        }.resume()
    }
}
