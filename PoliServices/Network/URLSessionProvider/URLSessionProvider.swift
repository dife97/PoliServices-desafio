import Foundation

class URLSessionProvider: URLSessionProviderProtocol {

    var urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func load(_ request: ApiRequestProtocol, onComplete: @escaping (Result<Data, CustomError>) -> Void) {

        guard let request = createURLRequest(from: request) else {
            onComplete(.failure(.failedToCreateRequest))

            return
        }

        urlSession.dataTask(with: request) { data, response, error in

            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onComplete(.failure(.responseError))

                    return
                }

                guard let data = data else {
                    onComplete(.failure(.missingData))

                    return
                }

                if response.statusCode >= 200 && response.statusCode < 300 {
                    onComplete(.success(data))

                    return
                }

                onComplete(.failure(.httpError(statusCode: response.statusCode)))
            } else {
                onComplete(.failure(.networkError(message: error?.localizedDescription ?? "")))
            }
        }.resume()
    }
}
