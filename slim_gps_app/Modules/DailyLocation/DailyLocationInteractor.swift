import Foundation
import Firebase
import FirebaseFirestore

final class DailyLocationInteractor {
    var presenter: DailyLocationPresenterInterface!
    let db = Firestore.firestore()
    
    init () {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}

extension DailyLocationInteractor: DailyLocationInteractorInterface {
    func getDailyLocation( serialNum: String, date: Date ){

        let calendar = Calendar(identifier: .gregorian)
        let beginnigOfTheDate = calendar.startOfDay(for: date)
        let endOfTheDate = beginnigOfTheDate.addingTimeInterval(60*60*24-1)
        
        db.collection("locationData")
            .whereField("deviceID", isEqualTo: serialNum)
            .order(by: "createdAt", descending: false)
            .whereField("createdAt", isGreaterThanOrEqualTo: beginnigOfTheDate)
            .whereField("createdAt", isLessThanOrEqualTo: endOfTheDate)
            .addSnapshotListener { (locationDataSnap, error) in
                if let _ = error {
                    self.presenter.showAlert(message: "エラーが発生しました")
                } else {
                    if(locationDataSnap?.documents.count == 0) {
                        self.presenter.locationDataIsEmpty()
                    } else {
                        var i = 0
                        for locationDataDoc in locationDataSnap!.documents {
                            if  let latitude = locationDataDoc.data()["latitude"] as? Double,
                                let longitude = locationDataDoc.data()["longitude"] as? Double,
                                let radius = locationDataDoc.data()["radius"] as? Double,
                                let createdAt = locationDataDoc.data()["createdAt"] as? Timestamp {
                                
                                i += 1
                                let lastFlag = locationDataSnap?.documents.count == i
                                self.presenter.locationDataIsGotten(data:(latitude: latitude, longitude: longitude, radius: radius, createdAt: createdAt.dateValue(), lastFlag: lastFlag))
                            }
                        }
                    }
                }
        }
    }
}

