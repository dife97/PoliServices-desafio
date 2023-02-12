import Foundation

class PSCountdown: Countdown {
    
    func start(duration: Double, action: @escaping () -> Void) {

        Timer.scheduledTimer(
            withTimeInterval: duration,
            repeats: false,
            block: { _ in
                action()
            }
        )
    }
}
