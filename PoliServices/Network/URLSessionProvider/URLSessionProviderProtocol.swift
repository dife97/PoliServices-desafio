import Foundation

protocol URLSessionProviderProtocol: NetworkProviderProtocol, URLSessionAdapter {
    
    var urlSession: URLSession { get }
}
