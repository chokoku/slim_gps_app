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
        
        db.collection("location_data")
            .whereField("device_id", isEqualTo: serialNum)
            .order(by: "created_at", descending: false)
            .whereField("created_at", isGreaterThanOrEqualTo: beginnigOfTheDate)
            .whereField("created_at", isLessThanOrEqualTo: endOfTheDate)
            .addSnapshotListener { (querySnapshot, error) in
                if let _ = error {
                    self.presenter.showAlert(message: "エラーが発生しました")
                } else {
                    if(querySnapshot?.documents.count == 0) {
                        self.presenter.locationDataIsEmpty()
                    } else {
                        var i = 0
                        for document in querySnapshot!.documents {
                            if  let latitude = document.data()["latitude"] as? Double,
                                let longitude = document.data()["longitude"] as? Double,
                                let radius = document.data()["radius"] as? Double,
                                let createdAt = document.data()["created_at"] as? Timestamp {
                                
                                i += 1
                                let lastFlag = querySnapshot?.documents.count == i
                                self.presenter.locationDataIsGotten(data:(latitude: latitude, longitude: longitude, radius: radius, createdAt: createdAt.dateValue(), lastFlag: lastFlag))
                            }
                        }
                    }
                }
        }
    }
}

