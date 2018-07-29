//import Foundation
//
//enum Errors: Error {
//    case authenticationFailed(String)
//    case serverConnectionFailed
//    case serverError
//    case nanikanoError(String)
//
//    static func fromStatusCode(_ code: Int, _ index: Int, _ msg: String) -> Errors {
//        switch code {
//        case 401:
//            switch index {
//
//            }
//            return .authenticationFailed(401, index, msg)
//        case 500:
//            return .nanikanoError(msg)
//        default:
//            return .serverError
//        }
//    }
//}
