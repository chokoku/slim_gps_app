import UIKit
import GoogleMaps
import CoreLocation

class NotifSpotViewController: UIViewController, GMSMapViewDelegate, UITableViewDelegate, UITableViewDataSource {

    var presenter: NotifSpotPresenterInterface!
    var mapView : GMSMapView!
    let tableHeight: CGFloat = 150
    @IBOutlet weak var notifSpotTable: UITableView!
    var notifSpots = [(notifSpotID: String, name: String, latitude: Double, longitude: Double, radius: Double, circle: GMSCircle)]()
    var locationManager: CLLocationManager = CLLocationManager()
    var circles = [GMSCircle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "通知スポットの設定"
        
        notifSpotTable.dataSource = self
        notifSpotTable.delegate = self
        
        //  現在地情報の取得許可と取得
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
                
        addMapView()
        self.view.addSubview(self.mapView)
        
        presenter.getNotifSpots()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addMapView(){
        let defaultCamera = GMSCameraPosition.camera(withLatitude: 38.258595, longitude: 137.6850225, zoom: 4.5) // center of Japan
        mapView = GMSMapView(frame: CGRect(x:0,y: 0, width:self.view.bounds.width, height:self.view.bounds.height-tableHeight))
        mapView.camera = defaultCamera
        mapView.animate(to: defaultCamera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        mapView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifSpots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotifSpotViewCell") as! NotifSpotViewCell
        cell.tag = indexPath.row
        let NotifSpot = notifSpots[indexPath.row]
        let name = NotifSpot.name
        cell.nameLabel.text = name
        cell.deleteButton.tag = indexPath.row
        cell.editButton.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        let alert = UIAlertController( title: "通知スポットの追加", message: "スポット名を入力してください", preferredStyle: UIAlertControllerStyle.alert )
        alert.addTextField(configurationHandler: { (textField) in textField.placeholder = "スポット名" })
        let cancelAction:UIAlertAction = UIAlertAction( title: "キャンセル", style: UIAlertActionStyle.cancel, handler:nil )
        let saveAction:UIAlertAction = UIAlertAction( title: "追加", style: UIAlertActionStyle.default,handler:{ (action) in
            var name = alert.textFields![0].text
            if (name!.isEmpty){ name = "名無しスポット" }
            self.presenter.addNotifSpot(name: name!, latitude: coordinate.latitude, longitude: coordinate.longitude, radius: 100.0)
        })
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
    }
    
    func editNotifSpot(tag: Int){
        let notifSpot = notifSpots[tag]
        let alert = UIAlertController( title: "スポット名の編集", message: "", preferredStyle: UIAlertControllerStyle.alert )
        alert.addTextField(configurationHandler: { (textField) in textField.placeholder = "スポット名" })
        alert.textFields![0].text = notifSpot.name
        let cancelAction:UIAlertAction = UIAlertAction( title: "キャンセル", style: UIAlertActionStyle.cancel, handler:nil )
        let saveAction:UIAlertAction = UIAlertAction( title: "保存", style: UIAlertActionStyle.default,handler:{ (action) in
            var name = alert.textFields![0].text
            if (name!.isEmpty){ name = "名無しスポット" }
            self.presenter.updateNotifSpot(notifSpotID: notifSpot.notifSpotID, name: name!, tag: tag)
        })
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
    }
    
    func deleteNotifSpot(tag:Int) {
        presenter.deleteNotifSpot(notifSpotID: notifSpots[tag].notifSpotID)
    }
}

extension NotifSpotViewController: NotifSpotViewInterface {
    func showNotifSpot(notifSpotID: String, name: String, latitude: Double, longitude: Double, radius: Double){
        
        // Set a tracking circle
        let circle = GMSCircle(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), radius: radius)
        circle.fillColor = UIColor(red: 0.35, green: 0, blue: 0, alpha: 0.05)
        circle.strokeColor = UIColor.red
        circle.strokeWidth = 1
        circle.map = mapView
        
        // Add a notifSpot
        notifSpots += [(notifSpotID, name, latitude, longitude, radius, circle)]
        notifSpotTable.reloadData()
        
        // Set a camera
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15.0)
        mapView.camera = camera
    }
    
    func showAlert(message: String){
        let alert = UIAlertController( title: " エラー", message: message, preferredStyle: UIAlertControllerStyle.alert )
        let OKAction:UIAlertAction = UIAlertAction( title: "OK", style: UIAlertActionStyle.cancel, handler:nil )
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
    }
    
    func notifSpotIsUpdated(name: String, tag: Int){
        notifSpots[tag].name = name
        notifSpotTable.reloadData()
    }
    
    func notifSpotIsDeleted(notifSpotID: String){
        notifSpots.filter( {$0.notifSpotID == notifSpotID} ).first!.circle.map = nil
        notifSpots = notifSpots.filter( {$0.notifSpotID != notifSpotID} )
        notifSpotTable.reloadData()
    }
}


extension NotifSpotViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("ユーザーはこのアプリケーションに関してまだ選択を行っていません")
            // 許可を求めるコードを記述する（後述）
            break
        case .denied:
            print("ローケーションサービスの設定が「無効」になっています (ユーザーによって、明示的に拒否されています）")
            // 「設定 > プライバシー > 位置情報サービス で、位置情報サービスの利用を許可して下さい」を表示する
            break
        case .restricted:
            print("このアプリケーションは位置情報サービスを使用できません(ユーザによって拒否されたわけではありません)")
            // 「このアプリは、位置情報を取得できないために、正常に動作できません」を表示する
            break
        case .authorizedAlways:
            print("常時、位置情報の取得が許可されています。")
            // 位置情報取得の開始処理
            break
        case .authorizedWhenInUse:
            print("起動時のみ、位置情報の取得が許可されています。")
            // 位置情報取得の開始処理
            break
        }
    }
    
    // when location data is given
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("位置情報の取得に失敗しました")
    }
}
