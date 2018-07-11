import UIKit

protocol DailyLocationViewInterface: class {
}

protocol DailyLocationWireframeInterface: class {
}

protocol DailyLocationPresenterInterface: class {
    func getDailyLocation( serialNum: String, date: Date ) -> [(latitude: Double, longitude: Double, createdAt: Date)]
}

protocol DailyLocationInteractorInterface: class {
    func fetchDailyLocation( serialNum: String, date: Date ) -> [(latitude: Double, longitude: Double, createdAt: Date)]
}
