//
//  IPaKeyChainKey.swift
//  IPaKeyChain
//
//  Created by IPa Chen on 2015/10/12.
//  Copyright © 2015年 A Magic Studio. All rights reserved.
//

import Foundation

public enum IPaSecAttrKeyClass : RawRepresentable {
    case Public,Private,Symmetric
    
    public init?(rawValue: String) {
        switch rawValue {
        case String(kSecAttrKeyClassPublic):
            self = Public
        case String(kSecAttrKeyClassPrivate):
            self = Private
        case String(kSecAttrKeyClassSymmetric):
            self = Symmetric
        default:
            self = Public
        }
    }
    public var rawValue: String {
        switch self {
        case .Public:
            return String(kSecAttrKeyClassPublic)
        case .Private:
            return String(kSecAttrKeyClassPrivate)
        case .Symmetric:
            return String(kSecAttrKeyClassSymmetric)
        }
        
    }
}
public enum IPaSecAttrKeyType : RawRepresentable {
    case RSA,EC
    public init?(rawValue: String) {
        switch rawValue {
        case String(kSecAttrKeyTypeRSA):
            self = RSA
        case String(kSecAttrKeyTypeEC):
            self = EC
        default:
            self = RSA
        }
    }
    public var rawValue: String {
        switch self {
        case .RSA:
            return String(kSecAttrKeyTypeRSA)
        case .EC:
            return String(kSecAttrKeyTypeEC)

        }
        
    }

}


class IPaKeyChainKey :IPaKeyChainKeyIdentity {
    override init () {
        super.init()
        self.keychainItemData[String(kSecClass)] = String(kSecClassKey)
    }
    /*
    kSecClassKey item attributes:
    kSecAttrAccessible
    kSecAttrAccessControl
    kSecAttrAccessGroup
    kSecAttrKeyClass
    kSecAttrLabel
    kSecAttrApplicationLabel
    kSecAttrIsPermanent
    kSecAttrApplicationTag
    kSecAttrKeyType
    kSecAttrKeySizeInBits
    kSecAttrEffectiveKeySize
    kSecAttrCanEncrypt
    kSecAttrCanDecrypt
    kSecAttrCanDerive
    kSecAttrCanSign
    kSecAttrCanVerify
    kSecAttrCanWrap
    kSecAttrCanUnwrap
    kSecAttrSynchronizable
    */
   
}