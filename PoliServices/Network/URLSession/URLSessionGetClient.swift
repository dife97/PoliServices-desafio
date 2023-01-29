import Foundation

class URLSessionGetClient: HttpGetClient {
    
    private let urlSession: URLSession
    
    init(
        urlSession: URLSession = URLSession.shared
    ) {
        self.urlSession = urlSession
    }
    
    func get(from urlString: String, onComplete: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            // TODO: implement error
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
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
