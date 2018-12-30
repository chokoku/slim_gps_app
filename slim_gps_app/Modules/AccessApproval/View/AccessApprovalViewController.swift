import UIKit

class AccessApprovalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var accessApprovalTable: UITableView!
    var presenter: AccessApprovalPresenterInterface!
    var requesters = [(accessAuthReqID: String, firstName: String?, lastName: String?, clientID: String, deviceID: String)]()
    let indicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.accessApprovalTable.rowHeight = 80

        // Configure an indicator
        indicator.style = .whiteLarge
        indicator.center = self.view.center
        indicator.color = UIColor.black
        
        accessApprovalTable.delegate = self
        accessApprovalTable.dataSource = self
        self.navigationItem.title = "アクセスの承認"
        presenter.getRequesters()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func approveAccessRequest(tag:Int) {

        // Start the indicator
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        indicator.startAnimating()
        
        let accessAuthReqID = requesters[tag].accessAuthReqID
        let clientID = requesters[tag].clientID
        let deviceID = requesters[tag].deviceID
        presenter.approveAccessRequest(accessAuthReqID: accessAuthReqID, clientID: clientID, deviceID: deviceID )
    }
    
    func rejectAcessRequest(tag:Int) {
        
        // Start the indicator
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        indicator.startAnimating()
        
        let accessAuthReqID = requesters[tag].accessAuthReqID
        presenter.rejectAccessRequest(accessAuthReqID: accessAuthReqID)
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
    func addRequesters(accessAuthReqID: String, firstName: String?, lastName: String?, clientID: String, deviceID: String) {
        
        // Stop the indicator
        indicator.stopAnimating()
        
        if !accessAuthReqID.isEmpty{
            requesters += [(accessAuthReqID, firstName, lastName, clientID, deviceID)]
            self.accessApprovalTable.reloadData()
        }
    }
    
    func accessAuthIsCompleted(accessAuthReqID: String){
        
        // Stop the indicator
        indicator.stopAnimating()
        
        self.requesters = self.requesters.filter( {$0.accessAuthReqID != accessAuthReqID} )
        self.accessApprovalTable.reloadData()
    }
    
    func showAlert(message: String){
        
        // Stop the indicator
        indicator.stopAnimating()
        
        let alert = UIAlertController( title: " エラー", message: message, preferredStyle: UIAlertController.Style.alert )
        let OKAction:UIAlertAction = UIAlertAction( title: "OK", style: UIAlertAction.Style.cancel, handler:nil )
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
    }
}
