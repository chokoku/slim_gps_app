import UIKit

class PopupViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var dateSelector: UIPickerView!
    var dateTuple = [(date: Date, title: String)]()
    var selectedDate: Date = Date()
    var delegate: DailyLocationViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDateTuple()
        dateSelector.delegate = self
        dateSelector.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setDateTuple(){
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ja_JP")
        dateFormater.dateFormat = "MM月dd日(EEE)"
        let today = Date()
        
        var dateArray = [Date]()
        for i in 0..<7 {
            dateArray.append(Date(timeInterval: TimeInterval(-60*60*24*i), since: today as Date))
        }
        
        dateTuple += [(dateArray[0], "今日 "+dateFormater.string(from: dateArray[0]))]
        dateTuple += [(dateArray[1], "昨日 "+dateFormater.string(from: dateArray[1]))]
        for i in 2..<7 {
            dateTuple += [(dateArray[i], dateFormater.string(from: dateArray[i]))]
        }
    }
    
    @IBAction func OKButtonTapped(_ sender: Any) {
                self.delegate!.date = selectedDate
                self.dismiss(animated: false, completion: nil)
                self.delegate!.reloadLocationData()
                self.delegate!.showAlert()
    }
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、要素の全数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dateTuple.count
    }
    
    // UIPickerViewに表示する配列
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dateTuple[row].title
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDate = dateTuple[row].date
    }
    
    // ポップアップの外側をタップした時にポップアップを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var tapLocation: CGPoint = CGPoint()
        // タッチイベントを取得する
        let touch = touches.first
        // タップした座標を取得する
        tapLocation = touch!.location(in: self.view)
        
        let popUpView: UIView = self.view.viewWithTag(100)! as UIView
        
        if !popUpView.frame.contains(tapLocation) {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
}
