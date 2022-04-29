//
//  ByteExtensions.swift
//  XDC
//
// Created by Developer on 15/06/21.
//

import Foundation
import BigInt

public extension XDC3Extensions where Base == BigUInt {
    var bytes: [UInt8] {
        let data = base.magnitude.serialize()
        let bytes = data.xdc3.bytes
        let lastIndex = bytes.count - 1
        let firstIndex = bytes.firstIndex(where: {$0 != 0x00}) ?? lastIndex
        
        if lastIndex < 0 {
            return Array([0])
        }
        
        return Array(bytes[firstIndex...lastIndex])
    }
}

extension BigInt {
    init(twosComplement data: Data) {
        let unsigned = BigUInt(data)
        self.init(BigInt(unsigned))
        if data[0] == 0xff {
            self.negate()
        }
    }
}

public extension XDC3Extensions where Base == BigInt {
    var bytes: [UInt8] {
        let data: Data
        if base.sign == .plus {
            data = base.magnitude.serialize()
        } else {
            // Twos Complement
            let len = base.magnitude.serialize().count
            let maximum = BigUInt(1) << (len * 8)
            let twosComplement = maximum - base.magnitude
            data = twosComplement.serialize()
        }
        
        
        let bytes = data.xdc3.bytes
        let lastIndex = bytes.count - 1
        let firstIndex = bytes.firstIndex(where: {$0 != 0x00}) ?? lastIndex
        
        if lastIndex < 0 {
            return Array([0])
        }
        
        return Array(bytes[firstIndex...lastIndex])
    }
}

public extension Data {
    static func ^ (lhs: Data, rhs: Data) -> Data {
        let bytes = zip(lhs.xdc3.bytes, rhs.xdc3.bytes).map { lhsByte, rhsByte in
            return lhsByte ^ rhsByte
        }
        
        return Data(bytes)
    }
}

public extension XDC3Extensions where Base == Data {
    var bytes: [UInt8] {
        return Array(base)
    }
    
    var strippingZeroesFromBytes: Data {
        var bytes = self.bytes
        while bytes.first == 0 {
            bytes.removeFirst()
        }
        return Data.init(bytes)
    }
    
    var bytes4: Data {
        return base.prefix(4)
    }
}

public extension String {
    init(hexFromBytes bytes: [UInt8]) {
        self.init("0x" + bytes.map() { String(format: "%02x", $0) }.reduce("", +))
    }
}

public extension XDC3Extensions where Base == String {
    var bytes: [UInt8] {
        return [UInt8](base.utf8)
    }
    
    var bytesFromHex: [UInt8]? {
        let hex = self.noHexPrefix
        do {
            let byteArray = try HexUtil.byteArray(fromHex: hex)
            return byteArray
        } catch {
            return nil
        }
    }
    
    var bytesFromXDC: [UInt8]? {
        let hex = self.noxdcPrefix
        do {
            let byteArray = try HexUtil.byteArray(fromHex: hex)
            return byteArray
        } catch {
            return nil
        }
    }
}
