import UIKit

class AccessApprovalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var accessApprovalTable: UITableView!
    var presenter: AccessApprovalPresenterInterface!
    var requesters = [(access_auth_id: String, first_name: String?, last_name: String?)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accessApprovalTable.delegate = self
        accessApprovalTable.dataSource = self
        self.navigationItem.title = "アクセスの承認"
        presenter.getRequesters()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addRequesters(access_auth_id: String, first_name: String?, last_name: String?) {
        if !access_auth_id.isEmpty{
            requesters += [(access_auth_id, first_name, last_name)]
            self.accessApprovalTable.reloadData()
        }
    }
    
    func showAlert(message: String){
        let alert = UIAlertController( title: " エラー", message: message, preferredStyle: UIAlertControllerStyle.alert )
        let OKAction:UIAlertAction = UIAlertAction( title: "OK", style: UIAlertActionStyle.cancel, handler:nil )
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
    }

    func approveAccessRequest(tag:Int) {
        let access_auth_id = requesters[tag].access_auth_id
        presenter.approveAccessRequest(access_auth_id: access_auth_id){ (err: String?) in
            if let err = err {
                self.showAlert(message: err)
            } else {
                self.requesters = self.requesters.filter( {$0.access_auth_id != access_auth_id} )
                self.accessApprovalTable.reloadData()
            }
        }
    }
    
    func rejectAcessRequest(tag:Int) {
        let access_auth_id = requesters[tag].access_auth_id
        presenter.rejectAccessRequest(access_auth_id: access_auth_id){ (err: String?) in
            if let err = err {
                self.showAlert(message: err)
            } else {
                self.requesters = self.requesters.filter( {$0.access_auth_id != access_auth_id} )
                self.accessApprovalTable.reloadData()
            }
        }
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
        cell.rejectButton.tag = indexPath.row
        cell.approveButton.tag = indexPath.row
        cell.delegate = self
        return cell
    }
}

extension AccessApprovalViewController: AccessApprovalViewInterface {
    
}
