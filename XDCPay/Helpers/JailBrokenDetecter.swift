 
import Foundation
import UIKit

extension UIDevice {
    @objc  var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
    
   @objc var isJailBroken: Bool {
        get {
            if UIDevice.current.isSimulator { return false }
            if JailBrokenHelper.hasCydiaInstalled() { return true }
            if JailBrokenHelper.isContainsSuspiciousApps() { return true }
            if JailBrokenHelper.isSuspiciousSystemPathsExists() { return true }
            return JailBrokenHelper.canEditSystemFiles()
        }
    }
}

private struct JailBrokenHelper {
    static func hasCydiaInstalled() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: "cydia://")!)
    }
    
    static func isContainsSuspiciousApps() -> Bool {
        for path in suspiciousAppsPathToCheck {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        return false
    }
    
    static func isSuspiciousSystemPathsExists() -> Bool {
        for path in suspiciousSystemPathsToCheck {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        return false
    }
    
    static func canEditSystemFiles() -> Bool {
        let jailBreakText = "Developer Insider"
        do {
            try jailBreakText.write(toFile: jailBreakText, atomically: true, encoding: .utf8)
            return true
        } catch {
            return false
        }
    }
    
    /**
     Add more paths here to check for jail break
     */
    static var suspiciousAppsPathToCheck: [String] {
        return ["/Applications/Cydia.app",
                "/Applications/blackra1n.app",
                "/Applications/FakeCarrier.app",
                "/Applications/Icy.app",
                "/Applications/IntelliScreen.app",
                "/Applications/MxTube.app",
                "/Applications/RockApp.app",
                "/Applications/SBSettings.app",
                "/Applications/WinterBoard.app"
        ]
    }
    
    static var suspiciousSystemPathsToCheck: [String] {
        return[
            "/.bootstrapped_electra",
            "/.cydia_no_stash",
            "/.installed_unc0ver",
            "/Applications/Cydia.app",
            "/Applications/FakeCarrier.app",
            "/Applications/Icy.app",
            "/Applications/IntelliScreen.app",
            "/Applications/MxTube.app",
            "/Applications/RockApp.app",
            "/Applications/SBSettings.app",
            "/Applications/Sileo.app",
            "/Applications/Snoop-itConfig.app",
            "/Applications/WinterBoard.app",
            "/Applications/blackra1n.app",
            "/Library/MobileSubstrate/CydiaSubstrate.dylib",
            "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
            "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/Library/PreferenceBundles/ABypassPrefs.bundle",
            "/Library/PreferenceBundles/FlyJBPrefs.bundle",
            "/Library/PreferenceBundles/LibertyPref.bundle",
            "/Library/PreferenceBundles/ShadowPreferences.bundle",
            "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
            "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
            "/bin/bash",
            "/bin/sh",
            "/etc/apt",
            "/etc/apt/sources.list.d/electra.list",
            "/etc/apt/sources.list.d/sileo.sources",
            "/etc/apt/undecimus/undecimus.list",
            "/etc/ssh/sshd_config",
            "/jb/amfid_payload.dylib",
            "/jb/jailbreakd.plist",
            "/jb/libjailbreak.dylib",
            "/jb/lzma",
            "/jb/offsets.plist",
            "/private/etc/apt",
            "/private/etc/dpkg/origins/debian",
            "/private/etc/ssh/sshd_config",
            "/private/var/Users/",
            "/private/var/cache/apt/",
            "/private/var/lib/apt",
            "/private/var/lib/cydia",
            "/private/var/log/syslog",
            "/private/var/mobile/Library/SBSettings/Themes",
            "/private/var/stash",
            "/private/var/tmp/cydia.log",
            "/usr/bin/cycript",
            "/usr/bin/sshd",
            "/usr/lib/libcycript.dylib",
            "/usr/lib/libhooker.dylib",
            "/usr/lib/libjailbreak.dylib",
            "/usr/lib/libsubstitute.dylib",
            "/usr/lib/substrate",
            "/usr/lib/TweakInject",
            "/usr/libexec/cydia",
            "/usr/libexec/cydia/firmware.sh",
            "/usr/libexec/sftp-server",
            "/usr/libexec/ssh-keysign",
            "/usr/local/bin/cycript",
            "/usr/sbin/frida-server",
            "/usr/sbin/sshd",
            "/usr/share/jailbreak/injectme.plist",
            "/var/binpack",
            "/var/cache/apt",
            "/var/checkra1n.dmg",
            "/var/lib/apt",
            "/var/lib/cydia",
            "/var/lib/dpkg/info/mobilesubstrate.md5sums",
            "/var/log/apt",
           "/private/var/lib/apt",
        "/Applications/Cydia.app",
        "/Applications/RockApp.app",
        "/Applications/Icy.app",
        "/bin/sh",
        "/usr/libexec/sftp-server",
        "/usr/libexec/ssh-keysign",
        "/Library/MobileSubstrate/MobileSubstrate.dylib",
        "/bin/bash",
        "/usr/sbin/sshd",
        "/etc/apt",
        "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
        "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
        "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
        "/Library/MobileSubstrate/DynamicLibraries/Veency.plist"]
    }
}
