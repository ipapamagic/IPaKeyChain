//
//  IPaKeyChainGenericPassword.swift
//  IPaKeyChain
//
//  Created by IPa Chen on 2015/10/12.
//  Copyright © 2015年 A Magic Studio. All rights reserved.
//

import Foundation

class IPaKeyChainGenericPassword :IPaKeyChainPassword {
    //MARK: GenericPassword class attribute
    /*
    kSecClassGenericPassword item attributes:
    kSecAttrAccessible
    kSecAttrAccessControl
    kSecAttrAccessGroup
    kSecAttrCreationDate
    kSecAttrModificationDate
    kSecAttrDescription
    kSecAttrComment
    kSecAttrCreator
    kSecAttrType
    kSecAttrLabel
    kSecAttrIsInvisible
    kSecAttrIsNegative
    kSecAttrAccount
    kSecAttrService
    kSecAttrGeneric
    kSecAttrSynchronizable
    */
    override init () {
        super.init()
        self.keychainItemData[String(kSecClass)] = String(kSecClassGenericPassword)
    }
    var secAttrAccessible:IPaSecAttrAccessible? {
        get {
            if let value = keychainItemData[String(kSecAttrAccessible)] as? String {
                return IPaSecAttrAccessible(rawValue: value)
            }
            return nil
        }
        set {
            
            keychainItemData[String(kSecAttrAccessible)] = newValue?.rawValue
        }
        
    }
    var secAttrService:String? {
        get {
            return keychainItemData[String(kSecAttrService)] as? String
        }
        set {
            
            keychainItemData[String(kSecAttrService)] = newValue
        }
    }
    var secAttrGeneric:NSData? {
        get {
            return keychainItemData[String(kSecAttrGeneric)] as? NSData
        }
        set {
            
            keychainItemData[String(kSecAttrGeneric)] = newValue
        }
    }
}