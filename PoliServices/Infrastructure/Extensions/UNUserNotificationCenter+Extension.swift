import UserNotifications

extension UNUserNotificationCenter {
    
    func requestPermission() {
        
        requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Log: Did authorize PushNotification")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
