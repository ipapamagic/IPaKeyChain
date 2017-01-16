//
//  IPaKeyChain.swift
//  IPaKeyChain
//
//  Created by IPa Chen on 2015/10/11.
//  Copyright © 2015年 A Magic Studio. All rights reserved.
//

import UIKit
import Security

public enum IPaSecMatchLimit:RawRepresentable {
    case one,all
    case number(Int)
    public init?(rawValue: String) {
        switch rawValue {
        case String(kSecMatchLimitOne):
            self = .one
        case String(kSecMatchLimitAll):
            self = .all
        default:
            self = .one
        }
    }
    public init?(rawValue: Int) {
        self = .number(rawValue)
    }
    public var rawValue: String {
        switch (self) {
        case .one:
            return String(kSecMatchLimitOne)
        case .all:
            return String(kSecMatchLimitAll)
        case .number(let value):
            return "\(value)"
        }
    }
}

public enum IPaSecAttrAccessible: RawRepresentable {
    case whenUnlocked, afterFirstUnlock, always, whenUnlockedThisDeviceOnly, afterFirstUnlockThisDeviceOnly, alwaysThisDeviceOnly, whenPasscodeSetThisDeviceOnly
    
    public init?(rawValue: String) {
        switch rawValue {
        case String(kSecAttrAccessibleWhenUnlocked):
            self = .whenUnlocked
        case String(kSecAttrAccessibleAfterFirstUnlock):
            self = .afterFirstUnlock
        case String(kSecAttrAccessibleAlways):
            self = .always
        case String(kSecAttrAccessibleWhenUnlockedThisDeviceOnly):
            self = .whenUnlockedThisDeviceOnly
        case String(kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly):
            self = .afterFirstUnlockThisDeviceOnly
        case String(kSecAttrAccessibleAlwaysThisDeviceOnly):
            self = .alwaysThisDeviceOnly
        case String(kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly):
            self = .whenPasscodeSetThisDeviceOnly
        default:
            self = .whenUnlocked
        }
    }
    
    public var rawValue: String {
        switch self {
        case .whenUnlocked:
            return String(kSecAttrAccessibleWhenUnlocked)
        case .afterFirstUnlock:
            return String(kSecAttrAccessibleAfterFirstUnlock)
        case .always:
            return String(kSecAttrAccessibleAlways)
        case .whenPasscodeSetThisDeviceOnly:
            return String(kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly)
        case .whenUnlockedThisDeviceOnly:
            return String(kSecAttrAccessibleWhenUnlockedThisDeviceOnly)
        case .afterFirstUnlockThisDeviceOnly:
            return String(kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly)
        case .alwaysThisDeviceOnly:
            return String(kSecAttrAccessibleAlwaysThisDeviceOnly)
        }
    }
}
public enum IPaSecAttrSynchronizable {
    case boolean(Bool)
    case any

    public init?(rawValue: Bool) {
        self = .boolean(rawValue)
    }
    public init?() {
        self = .any
    }
}
public enum IPaSecAttrKeyClass : RawRepresentable {
    case `public`,`private`,symmetric
    
    public init?(rawValue: String) {
        switch rawValue {
        case String(kSecAttrKeyClassPublic):
            self = .`public`
        case String(kSecAttrKeyClassPrivate):
            self = .`private`
        case String(kSecAttrKeyClassSymmetric):
            self = .symmetric
        default:
            self = .`public`
        }
    }
    public var rawValue: String {
        switch self {
        case .public:
            return String(kSecAttrKeyClassPublic)
        case .private:
            return String(kSecAttrKeyClassPrivate)
        case .symmetric:
            return String(kSecAttrKeyClassSymmetric)
        }
        
    }
}
public enum IPaSecAttrKeyType : RawRepresentable {
    case rsa,ec
    public init?(rawValue: String) {
        switch rawValue {
        case String(kSecAttrKeyTypeRSA):
            self = .rsa
        case String(kSecAttrKeyTypeEC):
            self = .ec
        default:
            self = .rsa
        }
    }
    public var rawValue: String {
        switch self {
        case .rsa:
            return String(kSecAttrKeyTypeRSA)
        case .ec:
            return String(kSecAttrKeyTypeEC)
            
        }
        
    }
    
}

public class IPaKeyChain :Sequence{
    var keychainItemData = [String:Any]()

    //MARK: SequenceType
    subscript(key : String?) -> Any? {
        get {
            if key != nil {
                return self.keychainItemData[key!];
            }
            return nil;
        }
        set(newValue) {
            if key != nil {
                self.keychainItemData[key!] = newValue;
            }
        }
    }
    
    public func makeIterator() ->  DictionaryIterator<String, Any> {
        return keychainItemData.makeIterator()
    }
    public init() {
        
    }
    convenience public init(data:[String:Any]) {
        self.init()
        keychainItemData = data
    }
    //MARK: KeyChain access
    public var secValueData:Data? {
        get {
            return keychainItemData[String(kSecValueData)] as? Data
        }
        set {
            keychainItemData[String(kSecValueData)] = newValue as Any?
        }
    }
    public var secReturnData:Bool {
        get {
            if let returnData = keychainItemData[String(kSecReturnData)] as? Bool {
                return returnData
            }
            return false
        }
        set {
            keychainItemData[String(kSecReturnData)] = newValue as Any?
        }
    }
    public var secReturnAttributes:Bool {
        get {
            if let _ = keychainItemData[String(kSecReturnAttributes)] {
                return true
            }
            return false
        }
        set {
            if newValue {
                keychainItemData[String(kSecReturnAttributes)] = kCFBooleanTrue
            }
            else {
                keychainItemData.removeValue(forKey: String(kSecReturnAttributes))
            }

        }
    }
    public var secReturnRef:Bool {
        get {
            if let returnData = keychainItemData[String(kSecReturnRef)] as? Bool {
                return returnData
            }
            return false
        }
        set {
            if newValue {
                keychainItemData[String(kSecReturnRef)] = kCFBooleanTrue
            }
            else {
                keychainItemData.removeValue(forKey: String(kSecReturnRef))
            }
        }
    }
    public var secReturnPersistentRef:Bool {
        get {
            if let returnData = keychainItemData[String(kSecReturnPersistentRef)] as? Bool {
                return returnData
            }
            return false
        }
        set {
            if newValue {
                keychainItemData[String(kSecReturnPersistentRef)] = kCFBooleanTrue
            }
            else {
                keychainItemData.removeValue(forKey: String(kSecReturnPersistentRef))
            }
        }
    }
    public var matchLimit:IPaSecMatchLimit {
        get {
            if let limit = keychainItemData[String(kSecMatchLimit)] as? String {
                return IPaSecMatchLimit(rawValue: limit)!
            }
            else if let limit = keychainItemData[String(kSecMatchLimit)] as? Int {
                return IPaSecMatchLimit(rawValue: limit)!
            }
            return .one
        }
        set {
            switch (newValue)
            {
            case .one,.all:
                keychainItemData[String(kSecMatchLimit)] = newValue.rawValue as Any?
            case .number(let value):
                keychainItemData[String(kSecMatchLimit)] = value as Any?
            }
        }
    }
    //MARK: KeyChain Function
    public func secItemCopyMatching(_ result:inout AnyObject?) -> OSStatus {
        return SecItemCopyMatching(keychainItemData as CFDictionary, &result)
//        return withUnsafeMutablePointer(to: &result) { SecItemCopyMatching(keychainItemData as CFDictionary, $0 as? UnsafeMutablePointer<CFTypeRef?>) }
    }
    public func secItemAdd(_ result:inout AnyObject?) -> OSStatus {
        return SecItemAdd(keychainItemData as CFDictionary, &result)
//        return withUnsafeMutablePointer(to: &result) { SecItemAdd(keychainItemData as CFDictionary, $0 as? UnsafeMutablePointer<CFTypeRef?>) }
    }
    public func secItemUpdate(_ attributesToUpdate:CFDictionary) -> OSStatus {
        
        return SecItemUpdate(keychainItemData as CFDictionary, attributesToUpdate)
    }
    public func secItemUpdate(_ attributesToUpdate:IPaKeyChain) -> OSStatus {
        var dictionary = attributesToUpdate.keychainItemData
        dictionary.removeValue(forKey: String(kSecClass))
        return SecItemUpdate(keychainItemData as CFDictionary, dictionary as CFDictionary)
    }
    
    public func secItemDelete() -> OSStatus {
        
        return SecItemDelete(keychainItemData as CFDictionary)
    }
    //MARK: Common Attribute
    public var secAttrAccessControl:SecAccessControl? {
        get {
            if let value = keychainItemData[String(kSecAttrAccessControl)] {
                return (value as! SecAccessControl)
            }
            return nil
        }
        set {
            keychainItemData[String(kSecAttrAccessControl)] = newValue
        }
    }
    public func createAccessControl(_ accessible:IPaSecAttrAccessible,createFlags:SecAccessControlCreateFlags) throws{
        let accessControlError:UnsafeMutablePointer<Unmanaged<CFError>?>? = nil
        self.secAttrAccessControl = SecAccessControlCreateWithFlags(kCFAllocatorDefault, accessible.rawValue as CFTypeRef, createFlags,accessControlError)
        
        if let memory = accessControlError?.pointee {
            
            throw memory.takeRetainedValue() as Error

        }
        
    }
    public var secAttrAccessGroup:String? {
        get {
            return keychainItemData[String(kSecAttrAccessGroup)] as? String
        }
        set {
            keychainItemData[String(kSecAttrAccessGroup)] = newValue as Any?
        }
    }
    
    public var secAttrLabel:String? {
        get {
            return keychainItemData[String(kSecAttrLabel)] as? String
        }
        set {
            keychainItemData[String(kSecAttrLabel)] = newValue as Any?
        }
    }
    public var secAttrSynchronizable:IPaSecAttrSynchronizable? {
        get {
            if let value = keychainItemData[String(kSecAttrSynchronizable)] as? Bool {
                return IPaSecAttrSynchronizable(rawValue: value)
            }
            else if let string = keychainItemData[String(kSecMatchLimit)] as? String , string == String(kSecAttrSynchronizableAny) {
                return IPaSecAttrSynchronizable.any
            }
            return .boolean(false)
        }
        set {
            guard let newValue = newValue else {
                keychainItemData.removeValue(forKey: String(kSecAttrSynchronizable))
                return
            }
            switch (newValue)
            {
            case .any:
                keychainItemData[(kSecAttrSynchronizable as String)] = kSecAttrSynchronizableAny as NSString
            case .boolean(let value):
                keychainItemData[String(kSecAttrSynchronizable)] = value as Any?
            }
        }
    }
    
        
    
    
    
    
    /*
    
    
    kSecClassIdentity item attributes:
    Since an identity is the combination of a private key and a
    certificate, this class shares attributes of both kSecClassKey and
    kSecClassCertificate.
*/
}

public class IPaKeyChainPassword:IPaKeyChain {
    public var secAttrCreationDate:Date? {
        get {
            return keychainItemData[String(kSecAttrCreationDate)] as? Date
        }
        set {
            
            keychainItemData[String(kSecAttrCreationDate)] = newValue as Any?
        }
    }
    public var secAttrModificationDate:Date? {
        get {
            return keychainItemData[String(kSecAttrModificationDate)] as? Date
        }
        set {
            
            keychainItemData[String(kSecAttrModificationDate)] = newValue as Any?
        }
    }
    public var secAttrDescription:String? {
        get {
            return keychainItemData[String(kSecAttrDescription)] as? String
        }
        set {
            
            keychainItemData[String(kSecAttrDescription)] = newValue as Any?
        }
    }
    public var secAttrComment:String? {
        get {
            return keychainItemData[String(kSecAttrComment)] as? String
        }
        set {
            
            keychainItemData[String(kSecAttrComment)] = newValue as Any?
        }
    }
    public var secAttrCreator:String? {
        get {
            return keychainItemData[String(kSecAttrCreator)] as? String
        }
        set {
            
            keychainItemData[String(kSecAttrCreator)] = newValue as Any?
        }
    }
    public var secAttrType:NSNumber? {
        get {
            return keychainItemData[String(kSecAttrType)] as? NSNumber
        }
        set {
            keychainItemData[String(kSecAttrType)] = newValue
        }
    }
    public var secAttrIsInvisible:Bool? {
        get {
            return keychainItemData[String(kSecAttrIsInvisible)] as? Bool
        }
        set {
            
            keychainItemData[String(kSecAttrIsInvisible)] = newValue as Any?
        }
    }
    public var secAttrIsNegative:Bool? {
        get {
            return keychainItemData[String(kSecAttrIsNegative)] as? Bool
        }
        set {
            
            keychainItemData[String(kSecAttrIsNegative)] = newValue as Any?
        }
    }
    public var secAttrAccount:String? {
        get {
            return keychainItemData[String(kSecAttrAccount)] as? String
        }
        set {
            
            keychainItemData[String(kSecAttrAccount)] = newValue as Any?
        }
    }
    
}


public class IPaKeyChainKeyIdentity:IPaKeyChain {
    public var secAttrKeyClass:IPaSecAttrKeyClass? {
        get {
            if let value = keychainItemData[String(kSecAttrKeyClass)] as? String {
                return IPaSecAttrKeyClass(rawValue: value)
            }
            return nil
        }
        set {
            keychainItemData[String(kSecAttrKeyClass)] = newValue?.rawValue as Any?
        }
    }
    public var secAttrApplicationLabel:String? {
        get {
            return keychainItemData[String(kSecAttrApplicationLabel)] as? String
        }
        set {
            keychainItemData[String(kSecAttrApplicationLabel)] = newValue as Any?
        }
    }
    
    public var secAttrIsPermanent:Bool? {
        get {
            return keychainItemData[String(kSecAttrIsPermanent)] as? Bool
        }
        set {
            keychainItemData[String(kSecAttrIsPermanent)] = newValue as Any?
        }
    }
    public var secAttrApplicationTag:Data? {
        get {
            return keychainItemData[String(kSecAttrApplicationTag)] as? Data
        }
        set {
            keychainItemData[String(kSecAttrApplicationTag)] = newValue as Any?
        }
        
    }
    public var secAttrKeyType:IPaSecAttrKeyType? {
        get {
            if let value = keychainItemData[String(kSecAttrKeyType)] as? String {
                return IPaSecAttrKeyType(rawValue: value)
            }
            return nil
        }
        set {
            keychainItemData[String(kSecAttrKeyType)] = newValue?.rawValue as Any?
        }
    }
    public var secAttrKeySizeInBits:Int? {
        get {
            return keychainItemData[String(kSecAttrKeySizeInBits)] as? Int
        }
        set {
            keychainItemData[String(kSecAttrKeySizeInBits)] = newValue as Any?
        }
    }
    public var secAttrEffectiveKeySize:Int? {
        get {
            return keychainItemData[String(kSecAttrEffectiveKeySize)] as? Int
        }
        set {
            keychainItemData[String(kSecAttrEffectiveKeySize)] = newValue as Any?
        }
    }
    public var secAttrCanEncrypt:Bool? {
        get {
            return keychainItemData[String(kSecAttrCanEncrypt)] as? Bool
        }
        set {
            keychainItemData[String(kSecAttrCanEncrypt)] = newValue as Any?
        }
    }
    public var secAttrCanDecrypt:Bool? {
        get {
            return keychainItemData[String(kSecAttrCanDecrypt)] as? Bool
        }
        set {
            keychainItemData[String(kSecAttrCanDecrypt)] = newValue as Any?
        }
    }
    public var secAttrCanDerive:Bool? {
        get {
            return keychainItemData[String(kSecAttrCanDerive)] as? Bool
        }
        set {
            keychainItemData[String(kSecAttrCanDerive)] = newValue as Any?
        }
    }
    public var secAttrCanSign:Bool? {
        get {
            return keychainItemData[String(kSecAttrCanSign)] as? Bool
        }
        set {
            keychainItemData[String(kSecAttrCanSign)] = newValue as Any?
        }
    }
    public var secAttrCanVerify:Bool? {
        get {
            return keychainItemData[String(kSecAttrCanVerify)] as? Bool
        }
        set {
            keychainItemData[String(kSecAttrCanVerify)] = newValue as Any?
        }
    }
    public var secAttrCanWrap:Bool? {
        get {
            return keychainItemData[String(kSecAttrCanWrap)] as? Bool
        }
        set {
            keychainItemData[String(kSecAttrCanWrap)] = newValue as Any?
        }
    }
    public var secAttrCanUnwrap:Bool? {
        get {
            return keychainItemData[String(kSecAttrCanUnwrap)] as? Bool
        }
        set {
            keychainItemData[String(kSecAttrCanUnwrap)] = newValue as Any?
        }
    }

}
