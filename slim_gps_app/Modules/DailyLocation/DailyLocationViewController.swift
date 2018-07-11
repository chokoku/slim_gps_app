import UIKit
import GoogleMaps

class DailyLocationViewController: UIViewController {
    
    var presenter: DailyLocationPresenterInterface!
    var serial_num: String!
    var mapView : GMSMapView!
    var locationData = [(latitude: Double, longitude: Double, created_at: NSObject)]()
    var alertFlag: Bool = false
    var dateTimePickerBar = DateTimePickerBarView()
//    let datePickerButton = UIButton()
    var date: Date = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLocationData() // load location data and set markers on mapView
        self.view.addSubview(mapView)
        setTimeDatePickerBar()
    }
    
    func setTimeDatePickerBar(){
        
        // Configure datePickerButton
//        datePickerButton.addTarget(self, action: #selector(onTapShowPopup),for: .touchUpInside)
//        datePickerButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 25)
//        datePickerButton.setTitle(String.fontAwesomeIcon(name: .calendar), for: .normal)
//        datePickerButton.setTitleColor(UIColor.black, for: .normal) // タイトルの色
//        datePickerButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Set dateTimePickerButton view
//        let bundle = Bundle(for: type(of: self))
//        dateTimePickerBar = UINib(nibName: "DateTimePickerBarXib", bundle: bundle).instantiate(withOwner: self, options: nil).first as! DateTimePickerBarView
//        dateTimePickerBar.configure()
//        dateTimePickerBar.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(dateTimePickerBar)
        
        // Configure constraints
        
//        let _deviceView = UIView(frame: CGRect(x: 5, y: CGFloat(5+(270+5)*i), width: self.view.bounds.width-5*2, height: 270))
        let dateTimePickerBar = DateTimePickerBarView(frame: CGRect(x: (self.view.bounds.width-300)/2, y: self.view.bounds.height-(20+50), width: 300, height: 50))
        self.view.addSubview(dateTimePickerBar)
//        dateTimePickerBar.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
//        dateTimePickerBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -dateTimePickerBar.bounds.width/2).isActive = true // weird
//        self.view.addSubview(datePickerButton)

        // Configure constraints
//        datePickerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        datePickerButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
//        datePickerButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        datePickerButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func loadLocationData(){
        if let mapView = mapView { mapView.clear() }
        mapView = GMSMapView(frame: CGRect(x:0,y: 0, width:self.view.bounds.width, height:self.view.bounds.height))
        
        // Get locationData
        locationData = presenter.getDailyLocation( serial_num: serial_num, date: date )
        
        if(locationData.count != 0){
            
            // Set tracking markers
            for tuple in locationData {
                // TODO get radius
                let circle = GMSCircle(position: CLLocationCoordinate2D(latitude: tuple.latitude, longitude: tuple.longitude), radius:5)
                circle.fillColor = UIColor(red: 0, green: 0.6, blue: 0.8, alpha: 0.8)
                circle.strokeColor = UIColor.blue
                circle.strokeWidth = 0.5
                circle.map = mapView
            }
            
            // Set camera
            let camera = GMSCameraPosition.camera(withLatitude: locationData.last!.latitude, longitude: locationData.last!.longitude, zoom: 16.0)
            mapView.camera = camera
            
            // Set Marker
            let marker: GMSMarker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(locationData.last!.latitude, locationData.last!.longitude)
            marker.map = mapView
        } else {
            alertFlag = true
        }
    }
    
    // TODO 煩雑な手続きなので後で綺麗にすること
    func reloadLocationData(){
        mapView.removeFromSuperview()
        loadLocationData()
        self.view.addSubview(mapView)
        dateTimePickerBar.removeFromSuperview()
        setTimeDatePickerBar()
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
