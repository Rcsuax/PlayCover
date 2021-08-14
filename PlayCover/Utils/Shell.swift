//
//  Shell.swift
//  PlayCover
//

import Foundation

let sh = Shell.self

class Shell {
    
    static func isSIPEnabled() -> Bool{
        return shell("csrutil status").contains("enabled")
    }
    
    static func isPRAMValid() -> Bool {
        return shell("nvram -p").contains("cs_enforcement_disable=1")
    }
    
    static func fetchEntitlements(_ exec : URL) -> String {
        return shell("codesign -d --entitlements :- \(exec.esc)")
    }
    
    static func vtoolPatch(_ binary : URL) {
        shell("vtool -arch arm64 -set-build-version maccatalyst 10.0 14.5 -replace -output \(binary.esc) \(binary.esc)")
    }
    
    static func checkIfXcodeToolsInstalled(){
        shell("vtool -h")
    }
    
    static func codesign(_ binary : URL){
        shell("codesign -fs- \(binary.esc)")
    }
    
    static func removeQuarantine(_ app : URL){
        sudosh(["-S", "/usr/bin/xattr", "-d", "-r", "com.apple.quarantine", app.esc])
    }
    
    private static func sudosh(_ args : [String]){
        let password = PasswordViewModel.shared.password
        let passwordWithNewline = password + "\n"
        let sudo = Process()
        sudo.launchPath = "/usr/bin/sudo"
        sudo.arguments = args
        let sudoIn = Pipe()
        let sudoOut = Pipe()
        sudo.standardOutput = sudoOut
        sudo.standardError = sudoOut
        sudo.standardInput = sudoIn
        sudo.launch()

        // Show the output as it is produced
        sudoOut.fileHandleForReading.readabilityHandler = { fileHandle in
            let data = fileHandle.availableData
            if (data.count == 0) { return }
            print("read \(data.count)")
            print("\(String(bytes: data, encoding: .utf8) ?? "<UTF8 conversion failed>")")

        }
        // Write the password
        sudoIn.fileHandleForWriting.write(passwordWithNewline.data(using: .utf8)!)

        // Close the file handle after writing the password; avoids a
        // hang for incorrect password.
        try? sudoIn.fileHandleForWriting.close()

        // Make sure we don't disappear while output is still being produced.
        sudo.waitUntilExit()
        print("Process did exit")
    }
    
    static func isMachoEncrypted(exec: URL) -> Bool {
        return shell("otool -l \(exec.esc) | grep LC_ENCRYPTION_INFO -A5").contains("cryptid 1")
    }
    
    static func optoolInstall(library : String, exec : URL) {
        shell("\(utils.optool.esc) install -p \"@executable_path/\(library)\" -t \(exec.esc)")
    }
    
    static func signApp(_ app : URL, ents : URL){
        ulog("Signing app\n")
        ulog(shell("codesign -fs- \(app.esc) --deep --entitlements \(ents.esc)"))
    }
    
    static func appdecrypt(_ src : URL, target: URL) {
        ulog(shell("\(utils.crypt.esc) \(src.esc) \(target.esc)"))
    }
    
    static func removeAppFromApps(_ bundleName : String){
        sudosh(["-S", "/bin/rm", "-r", "-f", "/Applications/\(bundleName.esc).app/"])
    }
    
    static func copyAppToTemp(_ bundleName : String, name : String, temp: URL){
        ulog(shell("cp -R /Applications/\(bundleName.esc).app/Wrapper/\(name.esc).app \(temp.esc)/ipafile/Payload/"))
    }
    
    static func moveAppToApps(_ app : URL){
        ulog("Moving to /Applications \n")
        shell("mv \(app.esc) /Applications")
    }
    
    static func installIPA(_ ipa : URL){
        shell("open -a iOS\\ App\\ Installer.app \(ipa.esc)")
    }
    
    static func fetchAppsBy(_ request : String) -> String {
        return shell("\(utils.ipatool.esc) search \"\(request)\"" )
    }
    
    @discardableResult
    private static func shell(_ command: String) -> String {
        let task = Process()
        let pipe = Pipe()
        
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", command]
        task.launchPath = "/bin/zsh"
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!
        
        return output
    }
    
}


