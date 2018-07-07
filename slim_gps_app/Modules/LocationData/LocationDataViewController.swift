import UIKit
import GoogleMaps

class LocationDataViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    weak var currentViewController: UIViewController?
    var presenter: LocationDataPresenterInterface!
    var serial_num: String!
    var mapView : GMSMapView!

    override func viewDidLoad() {
        serial_num = "dfasdfaeadaerq"
        self.currentViewController = LatestLocationWireframe().configureModule( serial_num: serial_num )
        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(self.currentViewController!)
        self.addSubview(subView:self.currentViewController!.view, toView: self.containerView)
        super.viewDidLoad()
//        serial_num = "product_1"
//        presenter.getLocationData( serial_num: serial_num, date:new )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showComponent(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            let newViewController = LatestLocationWireframe().configureModule( serial_num: serial_num )
            newViewController.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(oldViewController: self.currentViewController!, toViewController: newViewController)
            self.currentViewController = newViewController
        } else {
            let newViewController = DailyLocationWireframe().configureModule( serial_num: serial_num )
            newViewController.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(oldViewController: self.currentViewController!, toViewController: newViewController)
            self.currentViewController = newViewController
        }
    }
    
    func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController) {
        oldViewController.willMove(toParentViewController:nil)
        self.addChildViewController(newViewController)
        self.addSubview(subView:newViewController.view, toView:self.containerView!)
        newViewController.view.layoutIfNeeded()
    
        UIView.animate( withDuration:0.5,
                        animations:{ newViewController.view.layoutIfNeeded() },
                        completion: { finished in
                            oldViewController.view.removeFromSuperview()
                            oldViewController.removeFromParentViewController()
                            newViewController.didMove(toParentViewController:self)
        })
    }
    
    func addSubview(subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|", metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|", metrics: nil, views: viewBindingsDict))
    }
}

extension LocationDataViewController: LocationDataViewInterface {
    
}

