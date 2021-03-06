//
//  KeyUtil.swift
//  XDC
//
// Created by Developer on 15/06/21.
//

import Foundation
import secp256k1

enum KeyUtilError: Error {
    case invalidContext
    case privateKeyInvalid
    case unknownError
    case signatureFailure
}

class KeyUtil {
    
    static func generatePrivateKeyData() -> Data? {
        return Data.randomOfLength(32)
    }
    
    static func generatePublicKey(from privateKey: Data) throws -> Data {
        guard let ctx = secp256k1_context_create(UInt32(SECP256K1_CONTEXT_SIGN | SECP256K1_CONTEXT_VERIFY)) else {
            print("Failed to generate a public key: invalid context.")
            throw KeyUtilError.invalidContext
        }
        
        defer {
            secp256k1_context_destroy(ctx)
        }
        
        
        let privateKeyPtr = (privateKey as NSData).bytes.assumingMemoryBound(to: UInt8.self)
        guard secp256k1_ec_seckey_verify(ctx, privateKeyPtr) == 1 else {
            print("Failed to generate a public key: private key is not valid.")
            throw KeyUtilError.privateKeyInvalid
        }
        
        let publicKeyPtr = UnsafeMutablePointer<secp256k1_pubkey>.allocate(capacity: 1)
        defer {
            publicKeyPtr.deallocate()
        }
        guard secp256k1_ec_pubkey_create(ctx, publicKeyPtr, privateKeyPtr) == 1 else {
            print("Failed to generate a public key: public key could not be created.")
            throw KeyUtilError.unknownError
        }
        
        var publicKeyLength = 65
        let outputPtr = UnsafeMutablePointer<UInt8>.allocate(capacity: publicKeyLength)
        defer {
            outputPtr.deallocate()
        }
        secp256k1_ec_pubkey_serialize(ctx, outputPtr, &publicKeyLength, publicKeyPtr, UInt32(SECP256K1_EC_UNCOMPRESSED))
        
        let publicKey = Data(bytes: outputPtr, count: publicKeyLength).subdata(in: 1..<publicKeyLength)
        
        return publicKey
    }
    
    static func generateAddress(from publicKey: Data) -> XDCAddress {
        let hash = publicKey.xdc3.keccak256
        let address = hash.subdata(in: 12..<hash.count)
        return XDCAddress(address.xdc3.hexString)
    }
    
    static func sign(message: Data, with privateKey: Data, hashing: Bool) throws -> Data {
        guard let ctx = secp256k1_context_create(UInt32(SECP256K1_CONTEXT_SIGN | SECP256K1_CONTEXT_VERIFY)) else {
            print("Failed to sign message: invalid context.")
            throw KeyUtilError.invalidContext
        }
        
        defer {
            secp256k1_context_destroy(ctx)
        }

        let msg = ((hashing ? message.xdc3.keccak256 : message) as NSData).bytes.assumingMemoryBound(to: UInt8.self)
        let privateKeyPtr = (privateKey as NSData).bytes.assumingMemoryBound(to: UInt8.self)
        let signaturePtr = UnsafeMutablePointer<secp256k1_ecdsa_recoverable_signature>.allocate(capacity: 1)
        defer {
            signaturePtr.deallocate()
        }
        guard secp256k1_ecdsa_sign_recoverable(ctx, signaturePtr, msg, privateKeyPtr, nil, nil) == 1 else {
            print("Failed to sign message: recoverable ECDSA signature creation failed.")
            throw KeyUtilError.signatureFailure
        }
        
        let outputPtr = UnsafeMutablePointer<UInt8>.allocate(capacity: 64)
        defer {
            outputPtr.deallocate()
        }
        var recid: Int32 = 0
        secp256k1_ecdsa_recoverable_signature_serialize_compact(ctx, outputPtr, &recid, signaturePtr)
        
        let outputWithRecidPtr = UnsafeMutablePointer<UInt8>.allocate(capacity: 65)
        defer {
            outputWithRecidPtr.deallocate()
        }
        outputWithRecidPtr.assign(from: outputPtr, count: 64)
        outputWithRecidPtr.advanced(by: 64).pointee = UInt8(recid)
        
        let signature = Data(bytes: outputWithRecidPtr, count: 65)
        
        return signature
    }
}
