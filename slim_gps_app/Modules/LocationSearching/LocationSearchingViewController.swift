import UIKit
import GoogleMaps

class LocationSearchingViewController: UIViewController {
    
    var presenter: LocationSearchingPresenterInterface!
    var deviceID: String!
    var mapView : GMSMapView!
    var marker: GMSMarker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show mapView
        mapView = GMSMapView(frame: CGRect(x:0,y: 0, width:self.view.bounds.width, height:self.view.bounds.height))
        mapView.isMyLocationEnabled = true
        marker = GMSMarker()
        self.view.addSubview(mapView)
        
        // Set the request Button after the mapView was added
        setRequestButton()
        
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
    
    func setRequestButton(){
        // Set request Button
        let requestButton = UIButton()
        requestButton.frame = CGRect(x: (self.view.bounds.width-100)/2, y: self.view.bounds.height-(50+20), width: 100, height: 50)
        requestButton.layer.cornerRadius = 5.0
        requestButton.backgroundColor = UIColor(hex: "0080FF")
        requestButton.setTitleColor(UIColor.white, for: .normal)
        requestButton.setTitle("位置検索", for: .normal)
        requestButton.addTarget(self, action: #selector(requestButtonTapped), for: .touchUpInside)
        self.view.addSubview(requestButton)
    }
    
    func showAlert(message: String){
        let alert = UIAlertController( title: " エラー", message: message, preferredStyle: UIAlertControllerStyle.alert )
        let OKAction:UIAlertAction = UIAlertAction( title: "OK", style: UIAlertActionStyle.cancel, handler:{ (action) in
            self.navigationController?.popViewController(animated:true)
        } )
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func requestButtonTapped(){
        presenter.requestLocationSearching(deviceID: deviceID)
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        let v = hex.map { String($0) } + Array(repeating: "0", count: max(6 - hex.count, 0))
        let r = CGFloat(Int(v[0] + v[1], radix: 16) ?? 0) / 255.0
        let g = CGFloat(Int(v[2] + v[3], radix: 16) ?? 0) / 255.0
        let b = CGFloat(Int(v[4] + v[5], radix: 16) ?? 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1.0)
    }
}
