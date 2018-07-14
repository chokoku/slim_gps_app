import Foundation
import Firebase
import FirebaseFirestore

final class DailyLocationInteractor {
    var presenter: DailyLocationPresenterInterface!
    let db = Firestore.firestore()
    var listener:ListenerRegistration! = nil

    init () {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}

extension DailyLocationInteractor: DailyLocationInteractorInterface {

    func setDailyLocationListener( deviceID: String, date: Date ){
        
        let calendar = Calendar(identifier: .gregorian)
        let beginnigOfTheDate = calendar.startOfDay(for: date)
        let endOfTheDate = beginnigOfTheDate.addingTimeInterval(60*60*24-1)
        
        listener = db.collection("locationData")
            .whereField("deviceID", isEqualTo: deviceID)
            .order(by: "createdAt", descending: false)
            .whereField("createdAt", isGreaterThanOrEqualTo: beginnigOfTheDate)
            .whereField("createdAt", isLessThanOrEqualTo: endOfTheDate)
            .addSnapshotListener { (snap, err) in
                guard let snap = snap else{
                    self.presenter.showAlert(message: "エラーが発生しました")
                    return
                }
                if(snap.documents.count == 0){ self.presenter.locationDataIsEmpty() }
                snap.documentChanges.forEach{ diff in
                    if (diff.type == .added){
                        let docData = diff.document.data()
                        if  let latitude = docData["latitude"] as? Double,
                            let longitude = docData["longitude"] as? Double,
                            let radius = docData["radius"] as? Double,
                            let createdAt = docData["createdAt"] as? Timestamp
                        {
                            self.presenter.locationDataIsGotten(data:(latitude: latitude, longitude: longitude, radius: radius, createdAt: createdAt.dateValue()))
                        }
                    }
                }
        }
    }

    func removeSnapshotListener(){
        listener.remove()
    }
}

