import UIKit
import FontAwesome_swift

class DateTimePickerBarView: UIView {
    
    var delegate: DailyLocationViewController?
    
    @IBOutlet weak var datePickerButton: UIButton!
    @IBOutlet weak var timeSlider: UISlider!

    @IBAction func datePickerTapped(_ sender: Any) {
        delegate?.datePickerTapped()
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        delegate?.sliderValueChanged(value: timeSlider.value)
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
    
}
