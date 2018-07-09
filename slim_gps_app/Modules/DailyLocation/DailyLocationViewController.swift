import UIKit
import GoogleMaps

class DailyLocationViewController: UIViewController {
    
    var presenter: DailyLocationPresenterInterface!
    var serial_num: String!
    var mapView : GMSMapView!
    var alertFlag: Bool = false
    let datePickerButton = UIButton()
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLocationData() // load location data and set marker on mapView
        self.view.addSubview(mapView)
        setDatePickerButton()
    }
    
    func setDatePickerButton(){
        
        // general setting
        datePickerButton.addTarget(self, action: #selector(onTapShowPopup),for: .touchUpInside)
        datePickerButton.setTitleColor(UIColor.white, for: .normal)
        datePickerButton.translatesAutoresizingMaskIntoConstraints = false
        datePickerButton.setTitle("日付", for: .normal)
        datePickerButton.backgroundColor = UIColor.brown
        
        self.view.addSubview(datePickerButton)

        // constraints
        datePickerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        datePickerButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        datePickerButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        datePickerButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func loadLocationData(){
        if let mapView = mapView { mapView.clear() }
        mapView = GMSMapView(frame: CGRect(x:0,y: 0, width:self.view.bounds.width, height:self.view.bounds.height))
        let locationData:[(latitude: Double?, longitude: Double?, created_at: NSObject?)] = presenter.getDailyLocation( serial_num: serial_num, date: date )
        if(locationData.count != 0){
            let camera = GMSCameraPosition.camera(withLatitude: locationData[0].latitude!, longitude: locationData[0].longitude!, zoom: 15.0)
            mapView.camera = camera
            for tuple in locationData {
                let marker: GMSMarker = GMSMarker()
                marker.position = CLLocationCoordinate2DMake(tuple.latitude!, tuple.longitude!)
                marker.map = mapView
            }
        } else {
            alertFlag = true
        }
    }
    
    // TODO 煩雑な手続きなので後で綺麗にすること
    func reloadLocationData(){
        mapView.removeFromSuperview()
        loadLocationData()
        self.view.addSubview(mapView)
        datePickerButton.removeFromSuperview()
        setDatePickerButton()
    }
    
    // ポップアップを表示がタップされた時
    @objc func onTapShowPopup(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popupViewController: PopupViewController = storyBoard.instantiateViewController(withIdentifier: "popupView") as! PopupViewController
        popupViewController.modalPresentationStyle = .overFullScreen
        popupViewController.modalTransitionStyle = .crossDissolve
        popupViewController.delegate = self
        self.present(popupViewController, animated: false, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAlert()
    }
    
    func showAlert(){
        if alertFlag {
            let alert = UIAlertController(title: "お知らせ", message: "データがありません", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
            alertFlag = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension DailyLocationViewController: DailyLocationViewInterface {
    
}
