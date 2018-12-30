import UIKit
import GoogleMaps

class LatestLocationViewController: UIViewController {
    
    var presenter: LatestLocationPresenterInterface!
    var deviceID: String!
    var latestLatitude: Double!
    var latestLongitude: Double!
    var mapView: GMSMapView!
    var marker: GMSMarker!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Show mapView
        mapView = GMSMapView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        marker = GMSMarker()
        self.view.addSubview(self.mapView)
        
        // Configure camera
        let camera = GMSCameraPosition.camera(withLatitude: latestLatitude, longitude: latestLongitude, zoom: 15.0)
        self.mapView.camera = camera
        
        // Get notifSpots
        presenter.getNotifSpots()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.removeSnapshotListener()
    }
}

extension LatestLocationViewController: LatestLocationViewInterface {
    
    func showNotifSpot(latitude: Double, longitude: Double, radius: Double){

        // Set a tracking circle
        let circle = GMSCircle(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), radius: radius)
        circle.fillColor = UIColor(red: 0.35, green: 0, blue: 0, alpha: 0.05)
        circle.strokeColor = UIColor.red
        circle.strokeWidth = 1
        circle.map = mapView
    }
    
    func giveLastNotifSpotFlag(){
        // Get latest location
        presenter.setLatestLocationListener( deviceID: deviceID )
    }
    
    func locationDataIsGotten(latitude: Double, longitude: Double, radius: Double, updatedAt: Date){ // radius is not used
        
        print("locationDataIsGotten")
        
        // Update latitude
        latestLatitude = latitude
        latestLongitude = longitude
        
        // Set circle
        let circle = GMSCircle(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), radius: radius)
        circle.fillColor = UIColor(red: 0, green: 0.6, blue: 0.8, alpha: 0.2)
        circle.strokeColor = UIColor.blue
        circle.strokeWidth = 0
        circle.map = mapView
        
        // Configure camera
        let camera = GMSCameraPosition.camera(withLatitude: latestLatitude, longitude: latestLongitude, zoom: 15.0)
        self.mapView.camera = camera
            
        // Set marker
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        let f = DateFormatter()
        f.locale = Locale(identifier: "ja_JP")
        f.dateFormat = "MM/dd EEEEE h:mm"
        marker.title = f.string(from: updatedAt)
        marker.map = mapView
        mapView.selectedMarker = marker
    }
    
    func showAlert(message: String){
        let alert = UIAlertController( title: " エラー", message: message, preferredStyle: UIAlertController.Style.alert )
        let OKAction:UIAlertAction = UIAlertAction( title: "OK", style: UIAlertAction.Style.cancel, handler:{ (action) in
            self.navigationController?.popViewController(animated:true)
        } )
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func locationDataIsEmpty(message: String){
        let defaultCamera = GMSCameraPosition.camera(withLatitude: 38.258595, longitude: 137.6850225, zoom: 4.5) // center of Japan
        mapView.camera = defaultCamera
        showAlert(message: message)
    }
}


