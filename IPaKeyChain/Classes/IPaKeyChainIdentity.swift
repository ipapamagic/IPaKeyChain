//
//  IPaKeyChainIdentity.swift
//  IPaKeyChain
//
//  Created by IPa Chen on 2015/10/12.
//  Copyright © 2015年 A Magic Studio. All rights reserved.
//

import Foundation


class IPaKeyChainIdentity:IPaKeyChainKeyIdentity {
    override init () {
        super.init()
        self.keychainItemData[String(kSecClass)] = kSecClassIdentity as NSString
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
