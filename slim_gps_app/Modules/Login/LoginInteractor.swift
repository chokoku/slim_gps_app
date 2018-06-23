//final class LoginInteractor {
//    weak var output: LoginInteractorOutputInterface?
//}
//
//// MARK: - Extensions -
//
//extension LoginInteractor: LoginInteractorInterface {
//    func saveUserInfo(_ userInfo: UserInfo) {
//
//        /// ログイン状態を作るための仮処理
//        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.loggedIn)
//
//        output?.userInfoSaveSucceeded()
//    }
//
//    func login(id: String, password: String) {
//        output?.loginSuceeded()
//    }
//}
