//
//  ViewModel.swift
//  PlayCover
//

import Foundation

let vm = InstallAppViewModel.shared

class InstallAppViewModel: ObservableObject {
    
    static let shared = InstallAppViewModel()
    
    @Published var makeFullscreen : Bool = false
    @Published var fixLogin : Bool = false
    @Published var useAlternativePatch : Bool = false
    @Published var useAlternativeDecrypt : Bool = false
    @Published var exportForSideloadly : Bool = false
    @Published var clearAppCaches : Bool = false
    
    required init() {}

}
