import UserNotifications

class PSLocalPushNotification: LocalPushNotification {
    
    private let notificationCenter: UNUserNotificationCenter
    private var pushNotification: PushNotificationModel?
    
    init(
        notificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()
    ) {
        self.notificationCenter = notificationCenter
    }
    
    func register(_ pushNotification: PushNotificationModel) {
        
        self.pushNotification = pushNotification

        notificationCenter.getNotificationSettings { [unowned self] settings in
            
            switch settings.authorizationStatus {
            case .notDetermined:
                notificationCenter.requestPermission()
            
            case .denied:
                print("Log: Permission for Push Notification not granted.")
                break
            
            default:
                self.registerPushNotification()
            }
        }
    }
    
    func cancelPendingPushNotification(with identifiers: [String]) {
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
    private func registerPushNotification() {
        
        guard let pushNotification = self.pushNotification else {
            print("Log: Push Notification not configured.")
            return
        }
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = pushNotification.title
        notificationContent.body = pushNotification.body
        notificationContent.sound = .default
        
        let intervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: pushNotification.timeInterval,
                                                                repeats: false)
        
        let notificationRequest = UNNotificationRequest(
            identifier: pushNotification.identifier,
            content: notificationContent,
            trigger: intervalTrigger
        )
        
        cancelPendingPushNotification(with: [pushNotification.identifier])
        notificationCenter.add(notificationRequest)
        
        print("Log: Did register push notification for \(pushNotification.timeInterval)")
    }
}
