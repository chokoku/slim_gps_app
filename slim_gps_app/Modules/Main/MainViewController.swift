import UIKit
import SlideMenuControllerSwift
import GoogleMaps
import FontAwesome_swift
import Firebase
import FirebaseAuth

class MainViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var presenter: MainPresenterInterface!
    var deviceInfo = [(serial_num: String?, admin: Bool?, mode: String?, name: String?, latitude: Double?, longitude: Double?, battery: Int?)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize( width: CGFloat(self.view.bounds.width), height: CGFloat(5+(270+5)*(deviceInfo.count)) )
        self.addLeftBarButtonWithImage(UIImage(named: "menu_icon")!)
        
        let user = Auth.auth().currentUser
        if let user = user {
            print("uid:\(user.uid)")
            
            deviceInfo = presenter.getDeviceInfo(uid: user.uid)
            //    deviceInfo = [(serial_num: String?, admin: Bool?, mode: String?, name: String?, latitude: Double?, longitude: Double?, battery: Int?)]
            print(deviceInfo)
            
            for i in 0..<deviceInfo.count {
                let _deviceView = UIView(frame: CGRect(x: 5, y: CGFloat(5+(270+5)*i), width: self.view.bounds.width-5*2, height: 270))
                _deviceView.translatesAutoresizingMaskIntoConstraints = false
                _deviceView.layer.cornerRadius=10
                _deviceView.layer.borderWidth=1
                _deviceView.tag = i
                
                let nameLabel:UILabel = UILabel()
                nameLabel.frame = CGRect(x: 20, y: 220, width: 100, height: 50)
                nameLabel.text = deviceInfo[i].name
                _deviceView.addSubview(nameLabel)
                
                if(deviceInfo[i].admin == true){
                    let settingButton = UIButton()
                    settingButton.frame = CGRect(x:_deviceView.bounds.width-50, y:220, width:50, height:50)
                    settingButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 25)
                    settingButton.setTitle(String.fontAwesomeIcon(name: .cog), for: .normal)
                    settingButton.setTitleColor( UIColor.gray, for: .normal)
                    settingButton.tag = i
                    settingButton.addTarget(self, action: #selector(self.settingButtonTapped(sender:)),for: .touchUpInside)
                    _deviceView.addSubview(settingButton)
                }
                
                let mapViewFrame = CGRect(x:0, y:0, width:_deviceView.bounds.width, height:_deviceView.bounds.height-50)
                // if location data exists
                if let latitude = deviceInfo[i].latitude, let longitude = deviceInfo[i].longitude{
                    
                    // this _mapButton is transparent
                    let _mapButton = UIButton()
                    _mapButton.frame = mapViewFrame
                    _mapButton.backgroundColor = .clear
                    _mapButton.tag = i
                    _mapButton.addTarget(self, action: #selector(self.mapViewIsTapped(sender:)), for: .touchUpInside)
                    
                    //                let latitude = deviceInfo[i].latitude
                    //                let longitude = deviceInfo[i].longitude
                    let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 16)
                    let _googleMapView = GMSMapView.map(withFrame: mapViewFrame, camera: camera)
                    _googleMapView.settings.scrollGestures = false
                    _googleMapView.settings.zoomGestures = false
                    _googleMapView.layer.cornerRadius=10
                    _googleMapView.isUserInteractionEnabled = false
                    
                    let position = CLLocationCoordinate2D( latitude: latitude, longitude: longitude )
                    let marker = GMSMarker(position: position)
                    marker.map = _googleMapView
                    _deviceView.addSubview(_mapButton)
                    _deviceView.addSubview(_googleMapView)
                } else { // if location data does not exist
                    let emptyView = UIView.init(frame: mapViewFrame)
                    emptyView.layer.cornerRadius=10
                    emptyView.backgroundColor = UIColor.lightGray
                    _deviceView.addSubview(emptyView)
                    
                    let infoLabel:UILabel = UILabel()
                    infoLabel.text = "測定を開始していません"
                    infoLabel.textColor = UIColor.white
                    infoLabel.sizeToFit()
                    infoLabel.center = emptyView.center
                    emptyView.addSubview(infoLabel)
                }
                
                scrollView.addSubview(_deviceView)
            }
        } else {
            // No user is signed in.
        }
    }

    @objc func settingButtonTapped(sender : AnyObject) {
        let i = Int(sender.tag)
        presenter.getDeviceSettingPage( serial_num: deviceInfo[i].serial_num!,
                                        name:       deviceInfo[i].name!,
                                        mode:       deviceInfo[i].mode! )
    }

    @objc func mapViewIsTapped(sender : AnyObject){
        let i = Int(sender.tag)
        presenter.getLocationDataPage( serial_num: deviceInfo[i].serial_num! )
    }
}

extension MainViewController: MainViewInterface {
    
}
