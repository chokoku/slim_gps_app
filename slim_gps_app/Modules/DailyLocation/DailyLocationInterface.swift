import UIKit

protocol DailyLocationViewInterface: class {
}

protocol DailyLocationWireframeInterface: class {
}

protocol DailyLocationPresenterInterface: class {
    func getDailyLocation( serial_num: String, date: Date ) -> [(latitude: Double?, longitude: Double?, created_at: NSObject?)]
}

protocol DailyLocationInteractorInterface: class {
    func fetchDailyLocation( serial_num: String, date: Date ) -> [(latitude: Double?, longitude: Double?, created_at: NSObject?)]
}
