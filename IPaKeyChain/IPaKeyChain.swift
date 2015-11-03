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
    case One,All
    case Number(Int)
    public init?(rawValue: String) {
        switch rawValue {
        case String(kSecMatchLimitOne):
            self = One
        case String(kSecMatchLimitAll):
            self = All
        default:
            self = One
        }
    }
    public init?(rawValue: Int) {
        self = Number(rawValue)
    }
    public var rawValue: String {
        switch (self) {
        case .One:
            return String(kSecMatchLimitOne)
        case .All:
            return String(kSecMatchLimitAll)
        case .Number(let value):
            return "\(value)"
        }
    }
}

public enum IPaSecAttrAccessible: RawRepresentable {
    case WhenUnlocked, AfterFirstUnlock, Always, WhenUnlockedThisDeviceOnly, AfterFirstUnlockThisDeviceOnly, AlwaysThisDeviceOnly, WhenPasscodeSetThisDeviceOnly
    
    public init?(rawValue: String) {
        switch rawValue {
        case String(kSecAttrAccessibleWhenUnlocked):
            self = WhenUnlocked
        case String(kSecAttrAccessibleAfterFirstUnlock):
            self = AfterFirstUnlock
        case String(kSecAttrAccessibleAlways):
            self = Always
        case String(kSecAttrAccessibleWhenUnlockedThisDeviceOnly):
            self = WhenUnlockedThisDeviceOnly
        case String(kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly):
            self = AfterFirstUnlockThisDeviceOnly
        case String(kSecAttrAccessibleAlwaysThisDeviceOnly):
            self = AlwaysThisDeviceOnly
        case String(kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly):
            self = WhenPasscodeSetThisDeviceOnly
        default:
            self = WhenUnlocked
        }
    }
    
    public var rawValue: String {
        switch self {
        case .WhenUnlocked:
            return String(kSecAttrAccessibleWhenUnlocked)
        case .AfterFirstUnlock:
            return String(kSecAttrAccessibleAfterFirstUnlock)
        case .Always:
            return String(kSecAttrAccessibleAlways)
        case .WhenPasscodeSetThisDeviceOnly:
            return String(kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly)
        case .WhenUnlockedThisDeviceOnly:
            return String(kSecAttrAccessibleWhenUnlockedThisDeviceOnly)
        case .AfterFirstUnlockThisDeviceOnly:
            return String(kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly)
        case .AlwaysThisDeviceOnly:
            return String(kSecAttrAccessibleAlwaysThisDeviceOnly)
        }
    }
}
public enum IPaSecAttrSynchronizable {
    case Boolean(Bool)
    case Any

    public init?(rawValue: Bool) {
        self = Boolean(rawValue)
    }
    public init?() {
        self = Any
    }
}
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

class IPaKeyChain :SequenceType{
    var keychainItemData = [String:AnyObject]()

    //MARK: SequenceType
    subscript(key : String?) -> AnyObject? {
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
    
    func generate() -> DictionaryGenerator<String, AnyObject> {
        return keychainItemData.generate()
    }
    init() {
        
    }
    convenience init(data:[String:AnyObject]) {
        self.init()
        keychainItemData = data
    }
    //MARK: KeyChain access
    var secValueData:NSData? {
        get {
            return keychainItemData[String(kSecValueData)] as? NSData
        }
        set {
            keychainItemData[String(kSecValueData)] = newValue
        }
    }
    var secReturnData:Bool {
        get {
            if let returnData = keychainItemData[String(kSecReturnData)] as? Bool {
                return returnData
            }
            return false
        }
        set {
            keychainItemData[String(kSecReturnData)] = newValue
        }
    }
    var secReturnAttributes:Bool {
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
                keychainItemData.removeValueForKey(String(kSecReturnAttributes))
            }

        }
    }
    var secReturnRef:Bool {
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
                keychainItemData.removeValueForKey(String(kSecReturnRef))
            }
        }
    }
    var secReturnPersistentRef:Bool {
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
                keychainItemData.removeValueForKey(String(kSecReturnPersistentRef))
            }
        }
    }
    var matchLimit:IPaSecMatchLimit {
        get {
            if let limit = keychainItemData[String(kSecMatchLimit)] as? String {
                return IPaSecMatchLimit(rawValue: limit)!
            }
            else if let limit = keychainItemData[String(kSecMatchLimit)] as? Int {
                return IPaSecMatchLimit(rawValue: limit)!
            }
            return .One
        }
        set {
            switch (newValue)
            {
            case .One,.All:
                keychainItemData[String(kSecMatchLimit)] = newValue.rawValue
            case .Number(let value):
                keychainItemData[String(kSecMatchLimit)] = value
            }
        }
    }
    //MARK: KeyChain Function
    func secItemCopyMatching(inout result:AnyObject?) -> OSStatus {

        return withUnsafeMutablePointer(&result) { SecItemCopyMatching(keychainItemData as CFDictionaryRef, UnsafeMutablePointer($0)) }
    }
    func secItemAdd(inout result:AnyObject?) -> OSStatus {
        
        return withUnsafeMutablePointer(&result) { SecItemAdd(keychainItemData as CFDictionaryRef, UnsafeMutablePointer($0)) }
    }
    func secItemUpdate(attributesToUpdate:CFDictionary) -> OSStatus {
        
        return SecItemUpdate(keychainItemData as CFDictionaryRef, attributesToUpdate)
    }
    func secItemUpdate(attributesToUpdate:IPaKeyChain) -> OSStatus {
        
        return SecItemUpdate(keychainItemData as CFDictionaryRef, attributesToUpdate.keychainItemData)
    }
    
    func secItemDelete() -> OSStatus {
        
        return SecItemDelete(keychainItemData as CFDictionaryRef)
    }
    //MARK: Common Attribute
    var secAttrAccessControl:SecAccessControlRef? {
        get {
            if let value = keychainItemData[String(kSecAttrAccessControl)] {
                return (value as! SecAccessControlRef)
            }
            return nil
        }
        set {
            keychainItemData[String(kSecAttrAccessControl)] = newValue
        }
    }
    func createAccessControl(accessible:IPaSecAttrAccessible,createFlags:SecAccessControlCreateFlags) throws{
        let accessControlError:UnsafeMutablePointer<Unmanaged<CFError>?> = nil
        self.secAttrAccessControl = SecAccessControlCreateWithFlags(kCFAllocatorDefault, accessible.rawValue, createFlags,accessControlError)
        
        if let memory = accessControlError.memory {
            throw memory.takeRetainedValue() as NSError

        }
        
    }
    var secAttrAccessGroup:String? {
        get {
            return keychainItemData[String(kSecAttrAccessGroup)] as? String
        }
        set {
            keychainItemData[String(kSecAttrAccessGroup)] = newValue
        }
    }
    
    var secAttrLabel:String? {
        get {
            return keychainItemData[String(kSecAttrLabel)] as? String
        }
        set {
            keychainItemData[String(kSecAttrLabel)] = newValue
        }
    }
    var secAttrSynchronizable:IPaSecAttrSynchronizable? {
        get {
            if let value = keychainItemData[String(kSecAttrSynchronizable)] as? Bool {
                return IPaSecAttrSynchronizable(rawValue: value)
            }
            else if let string = keychainItemData[String(kSecMatchLimit)] as? String where string == String(kSecAttrSynchronizableAny) {
                return IPaSecAttrSynchronizable.Any
            }
            return .Boolean(false)
        }
        set {
            guard let newValue = newValue else {
                keychainItemData.removeValueForKey(String(kSecAttrSynchronizable))
                return
            }
            switch (newValue)
            {
            case .Any:
                keychainItemData[String(kSecAttrSynchronizable)] = String(kSecAttrSynchronizableAny)
            case .Boolean(let value):
                keychainItemData[String(kSecAttrSynchronizable)] = value
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

class IPaKeyChainPassword:IPaKeyChain {
    var secAttrCreationDate:NSDate? {
        get {
            return keychainItemData[String(kSecAttrCreationDate)] as? NSDate
        }
        set {
            
            keychainItemData[String(kSecAttrCreationDate)] = newValue
        }
    }
    var secAttrModificationDate:NSDate? {
        get {
            return keychainItemData[String(kSecAttrModificationDate)] as? NSDate
        }
        set {
            
            keychainItemData[String(kSecAttrModificationDate)] = newValue
        }
    }
    var secAttrDescription:String? {
        get {
            return keychainItemData[String(kSecAttrDescription)] as? String
        }
        set {
            
            keychainItemData[String(kSecAttrDescription)] = newValue
        }
    }
    var secAttrComment:String? {
        get {
            return keychainItemData[String(kSecAttrComment)] as? String
        }
        set {
            
            keychainItemData[String(kSecAttrComment)] = newValue
        }
    }
    var secAttrCreator:String? {
        get {
            return keychainItemData[String(kSecAttrCreator)] as? String
        }
        set {
            
            keychainItemData[String(kSecAttrCreator)] = newValue
        }
    }
    var secAttrType:NSNumber? {
        get {
            return keychainItemData[String(kSecAttrType)] as? NSNumber
        }
        set {
            keychainItemData[String(kSecAttrType)] = newValue
        }
    }
    var secAttrIsInvisible:Bool? {
        get {
            return keychainItemData[String(kSecAttrIsInvisible)] as? Bool
        }
        set {
            
            keychainItemData[String(kSecAttrIsInvisible)] = newValue
        }
    }
    var secAttrIsNegative:Bool? {
        get {
            return keychainItemData[String(kSecAttrIsNegative)] as? Bool
        }
        set {
            
            keychainItemData[String(kSecAttrIsNegative)] = newValue
        }
    }
    var secAttrAccount:String? {
        get {
            return keychainItemData[String(kSecAttrAccount)] as? String
        }
        set {
            
            keychainItemData[String(kSecAttrAccount)] = newValue
        }
    }
    
}


class IPaKeyChainKeyIdentity:IPaKeyChain {
    var secAttrKeyClass:IPaSecAttrKeyClass? {
        get {
            if let value = keychainItemData[String(kSecAttrKeyClass)] as? String {
                return IPaSecAttrKeyClass(rawValue: value)
            }
            return nil
        }
        set {
            keychainItemData[String(kSecAttrKeyClass)] = newValue?.rawValue
        }
    }
    var secAttrApplicationLabel:String? {
        get {
            return keychainItemData[String(kSecAttrApplicationLabel)] as? String
        }
        set {
            keychainItemData[String(kSecAttrApplicationLabel)] = newValue
        }
    }
    
    var secAttrIsPermanent:Bool? {
        get {
            return keychainItemData[String(kSecAttrIsPermanent)] as? Bool
        }
        set {
            keychainItemData[String(kSecAttrIsPermanent)] = newValue
        }
    }
    var secAttrApplicationTag:NSData? {
        get {
            return keychainItemData[String(kSecAttrApplicationTag)] as? NSData
        }
        set {
            keychainItemData[String(kSecAttrApplicationTag)] = newValue
        }
        
    }
    var secAttrKeyType:IPaSecAttrKeyType? {
        get {
            if let value = keychainItemData[String(kSecAttrKeyType)] as? String {
                return IPaSecAttrKeyType(rawValue: value)
            }
            return nil
        }
        set {
            keychainItemData[String(kSecAttrKeyType)] = newValue?.rawValue
        }
    }
    var secAttrKeySizeInBits:Int? {
        get {
            return keychainItemData[String(kSecAttrKeySizeInBits)] as? Int
        }
        set {
            keychainItemData[String(kSecAttrKeySizeInBits)] = newValue
        }
    }
    var secAttrEffectiveKeySize:Int? {
        get {
            return keychainItemData[String(kSecAttrEffectiveKeySize)] as? Int
        }
        set {
            keychainItemData[String(kSecAttrEffectiveKeySize)] = newValue
        }
    }
    var secAttrCanEncrypt:Bool? {
        get {
            return keychainItemData[String(kSecAttrCanEncrypt)] as? Bool
        }
        set {
            keychainItemData[String(kSecAttrCanEncrypt)] = newValue
        }
    }
    var secAttrCanDecrypt:Bool? {
        get {
            return keychainItemData[String(kSecAttrCanDecrypt)] as? Bool
        }
        set {
            keychainItemData[String(kSecAttrCanDecrypt)] = newValue
        }
    }
    var secAttrCanDerive:Bool? {
        get {
            return keychainItemData[String(kSecAttrCanDerive)] as? Bool
        }
        set {
            keychainItemData[String(kSecAttrCanDerive)] = newValue
        }
    }
    var secAttrCanSign:Bool? {
        get {
            return keychainItemData[String(kSecAttrCanSign)] as? Bool
        }
        set {
            keychainItemData[String(kSecAttrCanSign)] = newValue
        }
    }
    var secAttrCanVerify:Bool? {
        get {
            return keychainItemData[String(kSecAttrCanVerify)] as? Bool
        }
        set {
            keychainItemData[String(kSecAttrCanVerify)] = newValue
        }
    }
    var secAttrCanWrap:Bool? {
        get {
            return keychainItemData[String(kSecAttrCanWrap)] as? Bool
        }
        set {
            keychainItemData[String(kSecAttrCanWrap)] = newValue
        }
    }
    var secAttrCanUnwrap:Bool? {
        get {
            return keychainItemData[String(kSecAttrCanUnwrap)] as? Bool
        }
        set {
            keychainItemData[String(kSecAttrCanUnwrap)] = newValue
        }
    }

}