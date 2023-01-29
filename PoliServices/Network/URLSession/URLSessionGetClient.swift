import Foundation

class URLSessionGetClient: HttpGetClient {
    
    private let urlSession: URLSession
    private var urlRequestAdapter: URLSessionRequestAdapter?
//    private let urlRequestAdapter: URLSessionRequest?
    
    init(
        urlSession: URLSession = URLSession.shared
    ) {
        self.urlSession = urlSession
    }
    
    func get(from urlString: String, onComplete: @escaping (Result<Data, Error>) -> Void) {
        
        let urlRequest = URLSessionRequestAdapter(
            method: .get,
            urlString: urlString
        ).makeURLRequest()
        
        urlSession.dataTask(with: urlRequest) { data, urlResponse, error in
            if error == nil {
                guard let urlResponse = urlResponse as? HTTPURLResponse else {
                    // TODO: implement error
                    return
                }
                
                guard let data else {
                    // TODO: implement error
                    return
                }
                
                if 200..<300 ~= urlResponse.statusCode {
                    onComplete(.success(data))
                    return
                }
                
                // TODO: implement error
            }
        }.resume()
    }
}
