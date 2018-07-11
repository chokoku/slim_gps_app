import UIKit
import GoogleMaps

class DailyLocationViewController: UIViewController {
    
    var presenter: DailyLocationPresenterInterface!
    var serialNum: String!
    var mapView : GMSMapView!
    var locationData = [(latitude: Double, longitude: Double, createdAt: Date)]()
    var alertFlag: Bool = false
    var dateTimePickerBar = DateTimePickerBarView()
    var date: Date = Date()
    let marker: GMSMarker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLocationData() // load location data and set markers on mapView
    }

    func loadLocationData(){
        
        // Set mapView
        if let mapView = mapView { mapView.clear() }
        mapView = GMSMapView(frame: CGRect(x:0,y: 0, width:self.view.bounds.width, height:self.view.bounds.height))
        self.view.addSubview(mapView)
        
        // Set dateTimePickerBar view
        let dateTimePickerBar = DateTimePickerBarView(frame: CGRect(x: (self.view.bounds.width-300)/2, y: self.view.bounds.height-(20+50), width: 300, height: 50))
        dateTimePickerBar.delegate = self
        self.view.addSubview(dateTimePickerBar)
        
        // Get locationData
        locationData = presenter.getDailyLocation( serialNum: serialNum, date: date )
        
        if(locationData.count != 0){
            
            // Set tracking circles
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
            
            // Set the target marker
            setMarker(locationData: locationData.last!)
            
            // Configure dateTimePickerBar
            let steps = locationData.count - 1
            dateTimePickerBar.timeSlider.minimumValue = 0
            dateTimePickerBar.timeSlider.maximumValue = Float(steps)
            dateTimePickerBar.timeSlider.value = Float(steps)
            dateTimePickerBar.timeSlider.isEnabled = true
        } else {
            
            // Disable dateTimePickerBar
            dateTimePickerBar.timeSlider.isEnabled = false
            dateTimePickerBar.timeSlider.value = 0

            alertFlag = true
        }
    }
    
    func setMarker( locationData:(latitude: Double, longitude: Double, createdAt: Date) ){
        marker.position = CLLocationCoordinate2DMake(locationData.latitude, locationData.longitude)
        let f = DateFormatter()
        f.locale = Locale(identifier: "ja_JP")
        f.dateFormat = "MM/dd EEEEE h:mm"
        marker.title = f.string(from: locationData.createdAt)
        marker.map = mapView
        mapView.selectedMarker = marker
    }
    
    func reloadLocationData(){
        mapView.removeFromSuperview()
        dateTimePickerBar.removeFromSuperview()
        loadLocationData()
    }
    
    // [DELEGATE] Show PopupView
    func datePickerTapped() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popupViewController: PopupViewController = storyBoard.instantiateViewController(withIdentifier: "popupView") as! PopupViewController
        popupViewController.modalPresentationStyle = .overFullScreen
        popupViewController.modalTransitionStyle = .crossDissolve
        popupViewController.delegate = self
        self.present(popupViewController, animated: false, completion: nil)
    }
    
    // [DELEGATE]
    func sliderValueChanged(value: Float){
        marker.map = nil
        let intValue: Int = Int(round(value))
        setMarker(locationData: locationData[intValue])
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
