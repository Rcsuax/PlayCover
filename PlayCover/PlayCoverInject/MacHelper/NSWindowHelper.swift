//
//  NSWindowHelper.swift
//  MacHelper
//

import Foundation
import AppKit

@objc public class NSWindowHelper : NSObject {
    
    @objc static public func initUI(){
        let window = NSApplication.shared.windows.first
        
//        var frame = window?.frame
//        if let screen = NSScreen.main {
//            let rect = screen.frame
//            let height = rect.size.height
//            let width = rect.size.width
//            frame?.size = NSSize(width: (2560 * 1.3)  , height: (1440 * 1.3) )
//        }
        
        let centre = NotificationCenter.default
        let main = OperationQueue.main
        
        centre.addObserver(forName: NSWindow.willEnterFullScreenNotification, object: nil, queue: main) { (note) in
            NSApplication.shared.presentationOptions = [NSApplication.PresentationOptions.hideMenuBar, NSApplication.PresentationOptions.hideDock]
            NSCursor.hide()
        }
        
        centre.addObserver(forName: NSWindow.willExitFullScreenNotification, object: nil, queue: main) { (note) in
           NSApplication.shared.presentationOptions = []
            NSCursor.unhide()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            window?.toggleFullScreen(true)
        }
        
        //window?.setFrame(frame!, display: true)
        //window?.center()
    }
}
