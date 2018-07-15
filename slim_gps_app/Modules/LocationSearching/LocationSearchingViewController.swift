import UIKit
import GoogleMaps

class LocationSearchingViewController: UIViewController {
    
    var presenter: LocationSearchingPresenterInterface!
    var deviceID: String!
    var mapView : GMSMapView!
    var marker: GMSMarker!
    @IBOutlet weak var searchButton: UIButton!
    @IBAction func searchButtonTapped(_ sender: Any) {
        presenter.requestLocationSearching(deviceID: deviceID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show mapView
        mapView = GMSMapView(frame: CGRect(x:0,y: 0, width:self.view.bounds.width, height:self.view.bounds.height))
        mapView.isMyLocationEnabled = true
        marker = GMSMarker()
        self.view.addSubview(mapView)
        
        // Set the request Button after the mapView was added
        self.view.bringSubview(toFront: searchButton)

        // Get latest location
        presenter.setLatestLocationListener( deviceID: deviceID )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.removeSnapshotListener()
    }
}

extension LocationSearchingViewController: LocationSearchingViewInterface {
    func locationDataIsGotten(latitude: Double, longitude: Double, radius: Double, createdAt: Date){ // radius is not used
        
        print("locationDataIsGotten")

        // Reset mapView and marker
        mapView.clear()
        marker.map = nil
        
        // Configure camera
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15.0)
        self.mapView.camera = camera
        
        // Set marker
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        let f = DateFormatter()
        f.locale = Locale(identifier: "ja_JP")
        f.dateFormat = "MM/dd EEEEE h:mm"
        marker.title = f.string(from: createdAt)
        marker.map = mapView
        mapView.selectedMarker = marker
    }
    
    func showAlert(message: String){
        let alert = UIAlertController( title: " エラー", message: message, preferredStyle: UIAlertControllerStyle.alert )
        let OKAction:UIAlertAction = UIAlertAction( title: "OK", style: UIAlertActionStyle.cancel, handler:{ (action) in
            self.navigationController?.popViewController(animated:true)
        } )
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
    }
}
