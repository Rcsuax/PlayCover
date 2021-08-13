//
//  PasswordViewModel.swift
//  PlayCover
//

import Foundation
import AppKit

class PasswordViewModel : ObservableObject{
    
    static let shared = PasswordViewModel()
    
    var password : String = ""
    
    typealias promptResponseClosure = (_ strResponse:String, _ bResponse:Bool) -> Void

    func promptForReply(_ strMsg:String, _ strInformative:String, completion:promptResponseClosure) {

            let alert: NSAlert = NSAlert()

            alert.addButton(withTitle: "OK")      // 1st button
            alert.addButton(withTitle: "Cancel")  // 2nd button
            alert.messageText = strMsg
            alert.informativeText = strInformative

            let txt = NSSecureTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        
            txt.stringValue = ""

            alert.accessoryView = txt
            let response: NSApplication.ModalResponse = alert.runModal()

            var bResponse = false
            if (response == NSApplication.ModalResponse.alertFirstButtonReturn) {
                bResponse = true
            }
            
            completion(txt.stringValue, bResponse)

        }

}
