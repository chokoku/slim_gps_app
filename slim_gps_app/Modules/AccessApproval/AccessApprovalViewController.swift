import UIKit

class AccessApprovalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var presenter: AccessApprovalPresenterInterface!
    var requesters = [(access_auth_id: String, first_name: String?, last_name: String?)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "アクセスの承認"
        requesters = presenter.getRequesters()
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

    @IBAction func approveAccessRequest(_ sender: Any) {
    }
    @IBAction func rejectAcessRequest(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requesters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccessApprovalViewCell") as! AccessApprovalViewCell
        cell.tag = indexPath.row
        let requester = requesters[indexPath.row]
        let last_name = requester.last_name ?? ""
        let first_name = requester.first_name ?? ""
        cell.nameLabel.text = last_name+" "+first_name
        return cell
    }
}

extension AccessApprovalViewController: AccessApprovalViewInterface {
    
}
