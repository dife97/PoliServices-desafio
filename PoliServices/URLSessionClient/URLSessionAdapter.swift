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


protocol URLSessionProtocol {
    
    // tudo que a classe URLSession genérica precisa pra saber como criar um URLRequest
}

class URLSessionGet: HttpGetClient {
    // cria um objeto URLRequest com que foi passado no httpGetClient
    // invoca a classe genérica de URLSession que vai devolver o resultado da API
    
    func load(urlString: String, onComplete: @escaping (Result<Data, Error>) -> Void) {
        
    }
}

class URLSessionPost {
    // conforma com HttpPostClient
    // cria um objeto URLRequest com que foi passado no httpGetClient
    // invoca a classe genérica de URLSession que vai devolver o resultado da API
    
    func load(urlString: String, onComplete: @escaping (Result<Data, Error>) -> Void) {
        
    }
}
