//
//  Values.swift
//  PlayCoverInject
//

import Foundation
import UIKit

class Values {
    static var screenWidth : CGFloat {
        windowWidth()
    }
    static var screenHeight : CGFloat {
        windowHeight()
    }
}

func windowHeight() -> CGFloat {
    return UIScreen.main.bounds.size.height
}

func windowWidth() -> CGFloat {
    return UIScreen.main.bounds.size.width
}
