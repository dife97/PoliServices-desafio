class RemoteAvailablePoliServices: AvailablePoliServices {
    
    private let urlString: String
    private let httpGetClient: HttpGetClient
    
    init(
        urlString: String,
        httpGetClient: any HttpGetClient
    ) {
        self.urlString = urlString
        self.httpGetClient = httpGetClient
    }
    
    func get(onComplete: @escaping (Result<AvailablePoliServicesModel, Error>) -> Void) {
        
        httpGetClient.load(urlString: urlString) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

import Foundation

protocol HttpGetClient {
    
    func load(urlString: String,
              onComplete: @escaping (Result<Data, Error>) -> Void)
}

class URLSessionClient: HttpGetClient {
    
    private var urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func load(urlString: String,
              onComplete: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            // TODO: implement error
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        urlSession.dataTask(with: urlRequest) { data, response, error in
            
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    // TODO: implement error
                    return
                }
                
                guard let data = data else {
                    // TODO: implement error
                    return
                }
                
                if response.statusCode >= 200 && response.statusCode < 300 {
                    onComplete(.success(data))
                    
                    return
                }
                
                // TODO: implement error
            } else {
                // TODO: implement error
            }
        }.resume()
    }
}
