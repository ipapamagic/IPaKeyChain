//
//  IPaKeyChainCertificate.swift
//  IPaKeyChain
//
//  Created by IPa Chen on 2015/10/12.
//  Copyright © 2015年 A Magic Studio. All rights reserved.
//

import Foundation

class IPaKeyChainCertificate:IPaKeyChain {
    override init () {
        super.init()
        self.keychainItemData[String(kSecClass)] = kSecClassCertificate as NSString
    }
    /*
    kSecClassCertificate item attributes:
    kSecAttrAccessible
    kSecAttrAccessControl
    kSecAttrAccessGroup
    kSecAttrCertificateType
    kSecAttrCertificateEncoding
    kSecAttrLabel
    kSecAttrSubject
    kSecAttrIssuer
    kSecAttrSerialNumber
    kSecAttrSubjectKeyID
    kSecAttrPublicKeyHash
    kSecAttrSynchronizable
    */
    
    var secAttrCerificateType:Int? {
        get {
            return keychainItemData[String(kSecAttrCertificateType)] as? Int
        }
        set {
            
            keychainItemData[String(kSecAttrCertificateType)] = newValue as AnyObject?
        }
        
    }
    var secAttrCertificateEncoding:Int? {
        get {
            return keychainItemData[String(kSecAttrCertificateEncoding)] as? Int
        }
        set {
            
            keychainItemData[String(kSecAttrCertificateEncoding)] = newValue as AnyObject?
        }
    }
    var secAttrSubject:Data? {
        get {
            return keychainItemData[String(kSecAttrSubject)] as? Data
        }
        set {
            
            keychainItemData[String(kSecAttrSubject)] = newValue as AnyObject?
        }
        
    }
    var secAttrIssuer:Data? {
        get {
            return keychainItemData[String(kSecAttrIssuer)] as? Data
        }
        set {
            
            keychainItemData[String(kSecAttrIssuer)] = newValue as AnyObject?
        }
        
    }
    var secAttrSerialNumber:Data? {
        get {
            return keychainItemData[String(kSecAttrSerialNumber)] as? Data
        }
        set {
            
            keychainItemData[String(kSecAttrSerialNumber)] = newValue as AnyObject?
        }
        
    }
    var secAttrSubjectKeyID:Data? {
        get {
            return keychainItemData[String(kSecAttrSubjectKeyID)] as? Data
        }
        set {
            
            keychainItemData[String(kSecAttrSubjectKeyID)] = newValue as AnyObject?
        }
        
    }
    var secAttrPublicKeyHash:Data? {
        get {
            return keychainItemData[String(kSecAttrPublicKeyHash)] as? Data
        }
        set {
            
            keychainItemData[String(kSecAttrPublicKeyHash)] = newValue as AnyObject?
        }
        
    }

}
