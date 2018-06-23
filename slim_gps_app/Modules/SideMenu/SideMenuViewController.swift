import UIKit

class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var sideMenuTable: UITableView!
    let sidemenu_items:[String] = ["ユーザー情報", "通知スポットの設定", "見守りリクエスト", "お問い合わせ", "利用規約"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuTable.dataSource = self
        sideMenuTable.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sidemenu_items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath)
        cell.textLabel!.text = sidemenu_items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //self.present(SecondViewController(), animated: true, completion: nil)
    }
}
