import UIKit
import GoogleMaps

class LatestLocationViewController: UIViewController {
    
    var presenter: LatestLocationPresenterInterface!
    var serialNum: String!
    var mapView : GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getLatestLocationData( serialNum: serialNum )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension LatestLocationViewController: LatestLocationViewInterface {
    func locationDataIsGotten(latitude: Double, longitude: Double, radius: Double){ // radius is not used
        print(1)
        // Configure mapView
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15.0)
        self.mapView = GMSMapView(frame: CGRect(x:0,y: 0, width:self.view.bounds.width, height:self.view.bounds.height))
        self.mapView.camera = camera
        self.mapView.isMyLocationEnabled = true // ??
        
        // Set marker
        let marker: GMSMarker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.map = self.mapView
        
        // Show mapView
        self.view.addSubview(self.mapView)
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


