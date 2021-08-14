//
//  TroubleshootView.swift
//  PlayCover
//

import Foundation
import SwiftUI

struct TroubleshootView : View {
    @State var isSipEnabled = sh.isSIPEnabled()
    
    var body: some View {
                VStack(alignment: .leading){
                   Text("Have problems launching with (Fix login captcha) ?")
                    if sh.isSIPEnabled() {
                        Text("You have enabled SIP. You must disable it to run the game!")
                    }
                    if !sh.isPRAMValid() {
                        Text("Your nvram params are not valid. Execute command from Discord or video in Terminal and restart Mac")
                    }
                    if sh.isSIPEnabled() || !sh.isPRAMValid() {
                        Text("Your system is not ready to run game with captcha-fix! Watch video for easy setup.")
                    } else{
                        Text("Your system setup is correct. Try to use .ipa from official links on Discord.")
                    }
                    
                }.padding(.init(top: 0, leading: 20, bottom: 0, trailing: 0))
    }
}
