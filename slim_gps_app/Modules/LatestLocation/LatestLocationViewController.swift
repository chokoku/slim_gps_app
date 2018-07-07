import UIKit
import GoogleMaps

class LatestLocationViewController: UIViewController {
    
    var presenter: LatestLocationPresenterInterface!
    var serial_num: String!
    var mapView : GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        serial_num = "dfasdfaeadaerq"
        //          serial_num = "product_1"

        let latestLocationData:(latitude: Double?, longitude: Double?) = presenter.getLatestLocationData( serial_num: serial_num ) // latestLocationData can be nil

        if let lat = latestLocationData.latitude, let long = latestLocationData.longitude{
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
            mapView = GMSMapView(frame: CGRect(x:0,y: 0, width:self.view.bounds.width, height:self.view.bounds.height))
            mapView.camera = camera
            let marker: GMSMarker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(lat, long)
            marker.map = mapView
            self.view.addSubview(mapView)
        } else {
            presenter.goBackToMainPage()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension LatestLocationViewController: LatestLocationViewInterface {
    
}


