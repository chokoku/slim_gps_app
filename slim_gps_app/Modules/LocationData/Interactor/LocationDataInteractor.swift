import Foundation
import Firebase
import FirebaseFirestore

final class LocationDataInteractor {
    var presenter: LocationDataPresenterInterface!
    let db = Firestore.firestore()
    
    init () {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}

extension LocationDataInteractor: LocationDataInteractorInterface {
}
