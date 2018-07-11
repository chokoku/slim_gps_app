import UIKit
import FontAwesome_swift

class DateTimePickerBarView: UIView {
    
    @IBOutlet weak var datePickerButton: UIButton!
    @IBOutlet weak var timeSlider: UISlider!

    @IBAction func datePickerTapped(_ sender: Any) {
        print(1)
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
    }
    

    //コードから生成したときに通る初期化処理
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    //InterfaceBulderで配置した場合に通る初期化処理
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    fileprivate func commonInit() {
        //MyCustomView.xibファイルからViewを生成する。
        //File's OwnerはMyCustomViewなのでselfとする。
        let view = UINib(nibName: "DateTimePickerBarView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        
        //ここでちゃんとあわせておかないと、配置したUIButtonがタッチイベントを拾えなかったりする。
        view.frame = self.bounds
        
        //伸縮するように
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // Set datePickerButton icon
        datePickerButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 25)
        datePickerButton.setTitle(String.fontAwesomeIcon(name: .calendar), for: .normal)
        datePickerButton.setTitleColor(UIColor.black, for: .normal) // タイトルの色
        
        //addする。viewオブジェクトの2枚重ねになる。
        self.addSubview(view)
    }
    
    
    
//    func configure() {
//        datePicker.addTarget(self, action: #selector(onTapShowPopup),for: .touchUpInside)
//        datePickerButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 25)
//        datePickerButton.setTitle(String.fontAwesomeIcon(name: .calendar), for: .normal)
//        datePickerButton.setTitleColor(UIColor.black, for: .normal) // タイトルの色
//        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
//        let nib = UINib(nibName: nibName, bundle: bundle)
//        return nib.instantiate(withOwner: self, options: nil).first as! UIView
//        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: "DateTimePickerBarXib", bundle: bundle)
//        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
//        return view
//    }

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        Initialization code
//        let view = Bundle.mainBundle().loadNibNamed("DateTimePickerBarView:", owner: self, options: nil).first as UIView
//        addSubview(view)
//    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        // Configure the view for the selected state
//    }
    
}
