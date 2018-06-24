import Foundation

final class UserInfoInteractor {
    var output: UserInfoPresenterInterface!
}

extension UserInfoInteractor: UserInfoInteractorInterface {
    func fetchUserInfo(_ userId: String){
        
    }
}
