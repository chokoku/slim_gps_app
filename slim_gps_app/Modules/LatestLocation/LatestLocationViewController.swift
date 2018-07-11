import UIKit
import GoogleMaps

class LatestLocationViewController: UIViewController {
    
    var presenter: LatestLocationPresenterInterface!
    var serialNum: String!
    var mapView : GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.getLatestLocationData( serialNum: serialNum ){ (latitude: Double?, longitude: Double?, err: String?) in
            if let err = err {
                self.showAlert(message: err)
            } else {
                let latestLocationData:(latitude: Double?, longitude: Double?) = (latitude: latitude, longitude: longitude)
                
                if let lat = latestLocationData.latitude, let long = latestLocationData.longitude{
                    
                    // Configure mapView
                    let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
                    self.mapView = GMSMapView(frame: CGRect(x:0,y: 0, width:self.view.bounds.width, height:self.view.bounds.height))
                    self.mapView.camera = camera
                    self.mapView.isMyLocationEnabled = true // ??

                    // Set marker
                    let marker: GMSMarker = GMSMarker()
                    marker.position = CLLocationCoordinate2DMake(lat, long)
                    marker.map = self.mapView
                    
                    // Show mapView
                    self.view.addSubview(self.mapView)
                } else {
                    self.presenter.goBackToMainPage()
                }
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showAlert(message: String){
        let alert = UIAlertController( title: " エラー", message: message, preferredStyle: UIAlertControllerStyle.alert )
        let OKAction:UIAlertAction = UIAlertAction( title: "OK", style: UIAlertActionStyle.cancel, handler:nil )
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
    }
}

extension LatestLocationViewController: LatestLocationViewInterface {
    
}


