import UIKit

class NotifSpotViewCell: UITableViewCell {
    var delegate: NotifSpotViewController?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func editTapped(_ sender: UIButton) {
        let tag = Int(sender.tag)
        delegate?.editNotifSpot(tag:tag)
    }
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        let tag = Int(sender.tag)
        delegate?.deleteNotifSpot(tag:tag)
    }
    
}
