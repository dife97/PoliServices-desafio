protocol LocalPushNotification {
    
    func register(_ pushNotification: PushNotificationModel)
    func cancelPendingPushNotification(with identifiers: [String])
}
