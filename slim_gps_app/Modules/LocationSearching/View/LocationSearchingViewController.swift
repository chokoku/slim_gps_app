import UIKit
import GoogleMaps

class LocationSearchingViewController: UIViewController {
    
    var presenter: LocationSearchingPresenterInterface!
    var deviceID: String!
    var mapView : GMSMapView!
    var marker: GMSMarker!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var message: UILabel!
    @IBAction func searchButtonTapped(_ sender: Any) {
        presenter.requestLocationSearching(deviceID: deviceID)
        message.text = "位置を検索しています"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show mapView
        mapView = GMSMapView(frame: CGRect(x:0,y: 0, width:self.view.bounds.width, height:self.view.bounds.height))
        mapView.isMyLocationEnabled = true
        marker = GMSMarker()
        self.view.addSubview(mapView)
        
        // Set the request Button after the mapView was added
        self.view.bringSubviewToFront(searchButton)
        
        // Init message
        message.text = nil
        self.view.bringSubviewToFront(message)
        
        // Get latest location
        presenter.setLatestLocationListener( deviceID: deviceID )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.removeSnapshotListener()
    }
}

extension LocationSearchingViewController: LocationSearchingViewInterface {
    
    func locationDataIsGotten(latitude: Double, longitude: Double, radius: Double, updatedAt: Date){ // radius is not used
        
        print("locationDataIsGotten")
        
        // Init message
        message.text = nil
        
        // Configure camera
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15.0)
        self.mapView.camera = camera
        
        // Set circle
        let circle = GMSCircle(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), radius: radius)
        circle.fillColor = UIColor(red: 0, green: 0.6, blue: 0.8, alpha: 0.2)
        circle.strokeColor = UIColor.blue
        circle.strokeWidth = 0
        circle.map = mapView
        
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
