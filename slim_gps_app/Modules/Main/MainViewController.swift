import UIKit
import SlideMenuControllerSwift
import GoogleMaps
import FontAwesome_swift
import Firebase
import FirebaseAuth

class MainViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var presenter: MainPresenterInterface!
    var deviceInfo = [(deviceID: String?, admin: Bool?, mode: String?, name: String?, latitude: Double?, longitude: Double?, battery: Int?)]()
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = Auth.auth().currentUser
        self.addLeftBarButtonWithImage(UIImage(named: "menu_icon")!)
    }

    override func viewWillAppear(_ animated: Bool) {
        
        // Initialize Main page
        let subViews = self.scrollView.subviews
        for subview in subViews{ subview.removeFromSuperview() }
        deviceInfo = [(deviceID: String?, admin: Bool?, mode: String?, name: String?, latitude: Double?, longitude: Double?, battery: Int?)]()
        
        if let user = user {
            scrollView.contentSize = CGSize( width: CGFloat(self.view.bounds.width), height: CGFloat(5+(270+5)*(deviceInfo.count)) ) // scrollView doesn't scroll if this func is removed
            presenter.getDeviceInfo(uid: user.uid)
        } else {
            // TODO set example views
            // No user is signed in.
        }
    }

    @objc func settingButtonTapped(sender : AnyObject) {
        let i = Int(sender.tag) // tag accepts number only
        presenter.pushDeviceSettingPage( deviceID: deviceInfo[i].deviceID!,
                                         name:      deviceInfo[i].name!,
                                         mode:      deviceInfo[i].mode! )
    }

    @objc func mapViewIsTapped(sender : AnyObject){
        let i = Int(sender.tag)
        presenter.pushLocationDataPage( deviceID: deviceInfo[i].deviceID!,
                                        mode: deviceInfo[i].mode! )
    }
    
}

extension MainViewController: MainViewInterface {
    func addMapView(index: Int, lastFlag: Bool, deviceID: String, admin: Bool, mode: String, name: String, latitude: Double?, longitude: Double?, battery: Int?){
                
        // Set device setting into deviceInfo
        deviceInfo += [(deviceID: deviceID, admin: admin, mode: mode, name: name, latitude: latitude, longitude: longitude, battery: battery)]
        
        let deviceView = UIView(frame: CGRect(x: 5, y: CGFloat(5+(270+5)*index), width: self.view.bounds.width-5*2, height: 270))
        deviceView.translatesAutoresizingMaskIntoConstraints = false
        deviceView.layer.cornerRadius=10
        deviceView.layer.borderWidth=1
        deviceView.tag = index
        
        let nameLabel:UILabel = UILabel()
        nameLabel.frame = CGRect(x: 20, y: 220, width: 100, height: 50)
        nameLabel.text = name
        deviceView.addSubview(nameLabel)
        
        if(admin == true){
            let settingButton = UIButton()
            settingButton.frame = CGRect(x:deviceView.bounds.width-50, y:220, width:50, height:50)
            settingButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 25)
            settingButton.setTitle(String.fontAwesomeIcon(name: .cog), for: .normal)
            settingButton.setTitleColor( UIColor.gray, for: .normal)
            settingButton.tag = index
            settingButton.addTarget(self, action: #selector(self.settingButtonTapped(sender:)),for: .touchUpInside)
            deviceView.addSubview(settingButton)
        }
        
        let mapViewFrame = CGRect(x:0, y:0, width:deviceView.bounds.width, height:deviceView.bounds.height-50)
        
        // if location data exists
        if let latitude = latitude, let longitude = longitude{
            
            // this mapButton is transparent
            let mapButton = UIButton()
            mapButton.frame = mapViewFrame
            mapButton.backgroundColor = .clear
            mapButton.tag = index
            mapButton.addTarget(self, action: #selector(self.mapViewIsTapped(sender:)), for: .touchUpInside)
            
            let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 16)
            let googleMapView = GMSMapView.map(withFrame: mapViewFrame, camera: camera)
            googleMapView.settings.scrollGestures = false
            googleMapView.settings.zoomGestures = false
            googleMapView.layer.cornerRadius=10
            googleMapView.isUserInteractionEnabled = false
            
            let position = CLLocationCoordinate2D( latitude: latitude, longitude: longitude )
            let marker = GMSMarker(position: position)
            marker.map = googleMapView
            deviceView.addSubview(mapButton)
            deviceView.addSubview(googleMapView)
        } else { // if location data does not exist
            
            let emptyView = UIView.init(frame: mapViewFrame)
            emptyView.layer.cornerRadius=10
            emptyView.backgroundColor = UIColor.lightGray
            deviceView.addSubview(emptyView)
            
            let infoLabel:UILabel = UILabel()
            infoLabel.text = "測定を開始していません"
            infoLabel.textColor = UIColor.white
            infoLabel.sizeToFit()
            infoLabel.center = emptyView.center
            emptyView.addSubview(infoLabel)
        }
        
        scrollView.addSubview(deviceView)
        
        if(lastFlag){
            scrollView.contentSize = CGSize( width: CGFloat(self.view.bounds.width), height: CGFloat(5+(270+5)*(deviceInfo.count)) ) // scrollView doesn't scroll if this func is removed
        }
    }
    
    func showAlert(message: String){
        let alert = UIAlertController( title: " エラー", message: message, preferredStyle: UIAlertControllerStyle.alert )
        let OKAction:UIAlertAction = UIAlertAction( title: "OK", style: UIAlertActionStyle.cancel, handler:nil )
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
    }
}
