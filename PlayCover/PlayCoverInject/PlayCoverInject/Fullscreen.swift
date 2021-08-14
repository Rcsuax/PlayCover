//
//  Fullscreen.swift
//  PlayCoverInject
//

import Foundation

extension UserDefaults {

    public func optionalArray(forKey defaultName: String) -> Array<Any>? {
        let defaults = self
        if let value = defaults.value(forKey: defaultName) {
            return value as? Array
        }
        return nil
    }
}

extension UIViewController {
    
    func setScreenValues(shiftX : Int, shiftY : Int, width : Int, height : Int){
        UserDefaults.standard.setValue([shiftX, shiftY, width, height], forKey: "playcover.screen")
    }
    
    func getScreenValues() -> Array<Int> {
        return (UserDefaults.standard.optionalArray(forKey: "playcover.screen") ?? [Int(0), Int(0), Int(InputController.screenWidth), Int(InputController.screenHeight)]) as! Array<Int>
    }
    
    func showGameControllerAlert(_ name : String){
        let alert = UIAlertController(title: "Detected new controller \(name)", message: "Do you want to connect?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    func alertWithTF() {
        
        let alert = UIAlertController(title: "Screen size", message: "Input values", preferredStyle: UIAlertController.Style.alert )
        
        let save = UIAlertAction(title: "Save", style: .default) { [self] (alertAction) in
            let textField = alert.textFields![0] as UITextField
            let textField2 = alert.textFields![1] as UITextField
            let textField3 = alert.textFields![2] as UITextField
            let textField4 = alert.textFields![3] as UITextField
            
            var width = Int(textField3.text!) ?? Int(Values.screenWidth)
            if width < 100 || width > 4000 {
                width = Int(Values.screenWidth)
            }
            
            var height = Int(textField4.text!) ?? Int(Values.screenHeight)
            if width < 100 || width > 4000 {
                width = Int(Values.screenHeight)
            }
            
            setScreenValues(shiftX: Int(textField.text!) ?? 0, shiftY: Int(textField2.text!) ?? 0, width: width, height: height)
            
            InputController.initUI()
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Horizontal shift (X)"
            textField.textColor = .red
            textField.text = "\(self.getScreenValues()[0])"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Vertical shift (Y)"
            textField.textColor = .blue
            textField.text = "\(self.getScreenValues()[1])"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Width multiplier (1.3 default)"
            textField.textColor = .red
            textField.text = "\(self.getScreenValues()[2])"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Height multiplier (1.3 default)"
            textField.textColor = .red
            textField.text = "\(self.getScreenValues()[3])"
        }
        
        alert.addAction(save)
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
        alert.addAction(cancel)
        
        self.present(alert, animated:true, completion: nil)
        
    }
}
