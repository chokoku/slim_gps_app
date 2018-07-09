import UIKit

class AccessApprovalViewCell: UITableViewCell {
    var delegate: AccessApprovalViewController?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var approveButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func approveTapped(_ sender: UIButton) {
        let tag = Int(sender.tag)
        delegate?.approveAccessRequest(tag:tag)
    }
    
    @IBAction func rejectTapped(_ sender: UIButton) {
        let tag = Int(sender.tag)
        delegate?.rejectAcessRequest(tag:tag)
    }

}
