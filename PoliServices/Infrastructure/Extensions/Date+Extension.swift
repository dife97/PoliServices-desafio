import Foundation

extension Date {
    
    func toStandardString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        
        let date = dateFormatter.string(from: self)
        
        dateFormatter.dateFormat = "HH:mm"
        let hour = dateFormatter.string(from: self)
        
        return "\(date) às \(hour)"
    }
    
    func getStandardCurrentDateString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "pt_BR")
        
        return dateFormatter.string(from: self)
    }
}
