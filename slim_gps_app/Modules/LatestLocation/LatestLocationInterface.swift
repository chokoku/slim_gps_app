import UIKit

protocol LatestLocationViewInterface: class {
}

protocol LatestLocationWireframeInterface: class {
    func popBackToMainPage()
}

protocol LatestLocationPresenterInterface: class {
    func getLatestLocationData( serial_num: String, completion: @escaping (Double?, Double?, String?) -> Void ) // latitude, longitude, error
    func goBackToMainPage()
}

protocol LatestLocationInteractorInterface: class {
    func fetchLatestLocationData( serial_num: String, completion: @escaping (Double?, Double?, String?) -> Void ) // latitude, longitude, error
}
