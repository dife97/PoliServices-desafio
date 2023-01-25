import Foundation

struct FoundationCurrentDateProvider: CurrentDateProviderProtocol {
    
    func getCurrentDate(with format: DateFormat,
                        onComplete: @escaping (String) -> Void) {
        
        let todayDate = Date()
        let dateFormatter = DateFormatter()
        
        switch format {
        case .fullDate:
            dateFormatter.dateStyle = .long
        }
        
        let todayString = dateFormatter.string(from: todayDate)
        
        onComplete(todayString)
    }
}
