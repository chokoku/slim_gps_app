import UIKit

class AccessApprovalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var accessApprovalTable: UITableView!
    var presenter: AccessApprovalPresenterInterface!
    var requesters = [(accessAuthID: String, firstName: String?, lastName: String?)]()
    
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

    func approveAccessRequest(tag:Int) {

        let accessAuthID = requesters[tag].accessAuthID
        presenter.approveAccessRequest(accessAuthID: accessAuthID)
    }
    
    func rejectAcessRequest(tag:Int) {
        let accessAuthID = requesters[tag].accessAuthID
        presenter.rejectAccessRequest(accessAuthID: accessAuthID)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requesters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccessApprovalViewCell") as! AccessApprovalViewCell
        cell.tag = indexPath.row
        let requester = requesters[indexPath.row]
        let lastName = requester.lastName ?? ""
        let firstName = requester.firstName ?? ""
        cell.nameLabel.text = lastName+" "+firstName
        cell.rejectButton.tag = indexPath.row
        cell.approveButton.tag = indexPath.row
        cell.delegate = self
        return cell
    }
}

extension AccessApprovalViewController: AccessApprovalViewInterface {
    func addRequesters(accessAuthID: String, firstName: String?, lastName: String?) {
        if !accessAuthID.isEmpty{
            requesters += [(accessAuthID, firstName, lastName)]
            self.accessApprovalTable.reloadData()
        }
    }
    
    func accessAuthIsCompleted(accessAuthID: String){
        self.requesters = self.requesters.filter( {$0.accessAuthID != accessAuthID} )
        self.accessApprovalTable.reloadData()
    }
    
    func showAlert(message: String){
        let alert = UIAlertController( title: " エラー", message: message, preferredStyle: UIAlertControllerStyle.alert )
        let OKAction:UIAlertAction = UIAlertAction( title: "OK", style: UIAlertActionStyle.cancel, handler:nil )
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
    }
}
