import Foundation

class PSCurrentDate: CurrentDate {
    
    func getCurrentDate(onComplete: (CurrentDateModel?) -> Void) {
        
        let today = Date()
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: today)
        
        guard
            let day = dateComponents.day,
            let month = dateComponents.month,
            let monthString = MonthModel.brazilian[month],
            let year = dateComponents.year
        else {
            onComplete(nil)
            return
        }
        
        let currentDate = CurrentDateModel(
            day: day,
            month: monthString,
            year: year
        )
        
        onComplete(currentDate)
    }
}
