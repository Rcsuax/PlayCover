//
//  Extensions.swift
//  PlayCoverInject
//

import Foundation

extension ProcessInfo {
    open var isMacCatalystApp: Bool { false }
    open var isiOSAppOnMac: Bool { false }
}

extension UIDevice {
    open var model: String { "iPad Pro" }
    open var localizedModel: String { "iPad Pro" }
    open var systemName: String { "iOS" }
}
