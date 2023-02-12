import Foundation

protocol HttpGetClient {
    
    func get(from urlString: String, onComplete: @escaping (Result<Data, PSError>) -> Void)
}
