import Foundation

extension Data {
    
    func decode<T: Decodable>(to: T.Type) -> T? {
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: self)
            
            return decodedData
        } catch {
            return nil
        }
    }
}
