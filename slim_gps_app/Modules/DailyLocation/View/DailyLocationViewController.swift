import UIKit
import GoogleMaps

class DailyLocationViewController: UIViewController {
    
    var presenter: DailyLocationPresenterInterface!
    var deviceID: String!
    var mapView : GMSMapView!
    var locationData = [(latitude: Double, longitude: Double, radius: Double, createdAt: Date)]()
    var dateTimePickerBar = DateTimePickerBarView()
    var date: Date = Date()
    var marker: GMSMarker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        marker = GMSMarker()
        loadLocationData() // load location data and set markers on mapView
    }

    func loadLocationData(){
        
        // Initiate locationData
        locationData = [(latitude: Double, longitude: Double, radius: Double, createdAt: Date)]()

        // Set mapView
        if let mapView = mapView { mapView.clear() }
        mapView = GMSMapView(frame: CGRect(x:0,y: 0, width:self.view.bounds.width, height:self.view.bounds.height))
        self.view.addSubview(mapView)
        
        // Relocate Google logo
        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
        mapView.padding = padding
        
        // Set default camera
        let defaultCamera = GMSCameraPosition.camera(withLatitude: 38.258595, longitude: 137.6850225, zoom: 4.5) // center of Japan
        mapView.camera = defaultCamera
        
        // Get locationData
        presenter.setDailyLocationListener( deviceID: deviceID, date: date )
    }
    
    func setMarker( locationData:(latitude: Double, longitude: Double, radius: Double, createdAt: Date) ){
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
        print(locationData)
        print(intValue)
        setMarker(locationData: locationData[intValue])
    }
    
    // Set dateTimePickerBar view
    func setDateTimePickerBar(isEnabled: Bool, maximumValue: Float){
        dateTimePickerBar = DateTimePickerBarView(frame: CGRect(x: (self.view.bounds.width-300)/2, y: self.view.bounds.height-(20+50), width: 300, height: 50))
        dateTimePickerBar.delegate = self
        dateTimePickerBar.timeSlider.minimumValue = 0
        dateTimePickerBar.timeSlider.maximumValue = maximumValue
        dateTimePickerBar.timeSlider.value = maximumValue
        dateTimePickerBar.timeSlider.isEnabled = isEnabled
        self.view.addSubview(dateTimePickerBar)
    }
}

extension DailyLocationViewController: DailyLocationViewInterface {
    
    func locationDataIsGotten(data:(latitude: Double, longitude: Double, radius: Double, createdAt: Date)){
        locationData += [(data.latitude, data.longitude, data.radius, data.createdAt)]
        
        // Set tracking circles
        let circle = GMSCircle(position: CLLocationCoordinate2D(latitude: data.latitude, longitude: data.longitude), radius: 5) // radius is not used
        circle.fillColor = UIColor(red: 0, green: 0.6, blue: 0.8, alpha: 0.8)
        circle.strokeColor = UIColor.blue
        circle.strokeWidth = 0.5
        circle.map = mapView
        
        // Set the target marker
        setMarker(locationData: locationData.last!)
        
        // Configure dateTimePickerBar
        let steps = locationData.count - 1
        setDateTimePickerBar(isEnabled: true, maximumValue: Float(steps))
    }
    
    func setBounds(){
        var bounds = GMSCoordinateBounds()
        for data in locationData {
            bounds = bounds.includingCoordinate(CLLocationCoordinate2DMake(data.latitude, data.longitude))
        }
        mapView.animate(with: GMSCameraUpdate.fit(bounds, with: UIEdgeInsets.init(top: 160.0, left: 50.0, bottom: 50.0 ,right: 50.0)))
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func locationDataIsEmpty(){
        // Disable dateTimePickerBar
        setDateTimePickerBar(isEnabled: false, maximumValue: Float(0))
        
        // Show Alert
        let alert = UIAlertController(title: "お知らせ", message: "位置情報のデータがありません", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
    }
}
