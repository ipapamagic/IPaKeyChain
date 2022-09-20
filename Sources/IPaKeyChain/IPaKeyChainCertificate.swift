//
//  IPaKeyChainCertificate.swift
//  IPaKeyChain
//
//  Created by IPa Chen on 2015/10/12.
//  Copyright © 2015年 A Magic Studio. All rights reserved.
//

import Foundation

public class IPaKeyChainCertificate:IPaKeyChainObject {
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
    
    public var secAttrCerificateType:Int? {
        get {
            return keychainItemData[String(kSecAttrCertificateType)] as? Int
        }
        set {
            
            keychainItemData[String(kSecAttrCertificateType)] = newValue
        }
        
    }
    public var secAttrCertificateEncoding:Int? {
        get {
            return keychainItemData[String(kSecAttrCertificateEncoding)] as? Int
        }
        set {
            
            keychainItemData[String(kSecAttrCertificateEncoding)] = newValue
        }
    }
    public var secAttrSubject:Data? {
        get {
            return keychainItemData[String(kSecAttrSubject)] as? Data
        }
        set {
            
            keychainItemData[String(kSecAttrSubject)] = newValue
        }
        
    }
    public var secAttrIssuer:Data? {
        get {
            return keychainItemData[String(kSecAttrIssuer)] as? Data
        }
        set {
            
            keychainItemData[String(kSecAttrIssuer)] = newValue
        }
        
    }
    public var secAttrSerialNumber:Data? {
        get {
            return keychainItemData[String(kSecAttrSerialNumber)] as? Data
        }
        set {
            
            keychainItemData[String(kSecAttrSerialNumber)] = newValue
        }
        
    }
    public var secAttrSubjectKeyID:Data? {
        get {
            return keychainItemData[String(kSecAttrSubjectKeyID)] as? Data
        }
        set {
            
            keychainItemData[String(kSecAttrSubjectKeyID)] = newValue
        }
        
    }
    public var secAttrPublicKeyHash:Data? {
        get {
            return keychainItemData[String(kSecAttrPublicKeyHash)] as? Data
        }
        set {
            
            keychainItemData[String(kSecAttrPublicKeyHash)] = newValue
        }
        
    }
    
}
