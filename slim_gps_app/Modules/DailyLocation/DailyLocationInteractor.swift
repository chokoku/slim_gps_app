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
    func fetchDailyLocation( serialNum: String, date: Date ) -> [(latitude: Double, longitude: Double, createdAt: Date)]{
        var locationData = [(latitude: Double, longitude: Double, createdAt: Date)]()

        let calendar = Calendar(identifier: .gregorian)
        let beginnigOfTheDate = calendar.startOfDay(for: date)
        let endOfTheDate = beginnigOfTheDate.addingTimeInterval(60*60*24-1)
        print(beginnigOfTheDate)
        print(endOfTheDate)
        var keepAlive = true
        let runLoop = RunLoop.current
        
        db.collection("location_data")
            .whereField("device_id", isEqualTo: serialNum)
            .order(by: "created_at", descending: false)
            .whereField("created_at", isGreaterThanOrEqualTo: beginnigOfTheDate)
            .whereField("created_at", isLessThanOrEqualTo: endOfTheDate)
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                    keepAlive = false
                } else {
                    for document in querySnapshot!.documents {
                        if  let latitude = document.data()["latitude"] as? Double,
                            let longitude = document.data()["longitude"] as? Double,
                            let createdAt = document.data()["created_at"] as? Timestamp {
                            locationData += [(latitude, longitude, createdAt.dateValue())]
                        }
                    }
                    keepAlive = false
                }
        }
        
        
        while keepAlive &&
            runLoop.run(mode: RunLoopMode.defaultRunLoopMode, before: NSDate(timeIntervalSinceNow: 0.1) as Date) {
        }
        print("locationData:\(locationData)")

        return locationData
    }
}
