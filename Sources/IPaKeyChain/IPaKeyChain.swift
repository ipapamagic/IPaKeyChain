//
//  IPaKeyChain.swift
//  IPaKeyChain
//
//  Created by IPa Chen on 2020/10/5.
//

import UIKit

open class IPaKeyChain: NSObject {
    public static func queryGenericPassword(_ serviceName:String,account:String,encoding:String.Encoding = .utf8) -> String? {
        let checkQuery = IPaKeyChainGenericPassword()
        checkQuery.secAttrService = serviceName
        checkQuery.secAttrAccount = account
        checkQuery.secReturnAttributes = true
        checkQuery.matchLimit = .one
        checkQuery.secReturnData = true
        var data:AnyObject?
        let checkStatus = checkQuery.secItemCopyMatching(&data)
        if checkStatus == errSecSuccess {
            let result = IPaKeyChainGenericPassword(data:data as! [String:Any])
            
            if let _ = result.secAttrAccount,let value = result.secValueData  {
                if let valueString = String(data: value as Data, encoding: encoding) {
                    return valueString
                }
            }
            
        }
        return nil
    }
    public static func queryGenericPasswords(_ serviceName:String,matchLimit:IPaSecMatchLimit, account:String,encoding:String.Encoding = .utf8) -> [String] {
        let checkQuery = IPaKeyChainGenericPassword()
        checkQuery.secAttrService = serviceName
        checkQuery.secAttrAccount = account
        checkQuery.secReturnAttributes = true
        checkQuery.matchLimit = matchLimit
        checkQuery.secReturnData = true
        var data:AnyObject?
        let checkStatus = checkQuery.secItemCopyMatching(&data)
        if checkStatus == errSecSuccess ,let dataArray = data as? [[String:Any]]{
            let valueStrings:[String] = dataArray.compactMap({
                data in
                let result = IPaKeyChainGenericPassword(data:data)
                
                if let _ = result.secAttrAccount,let value = result.secValueData  {
                    if let valueString = String(data: value as Data, encoding: encoding) {
                        return valueString
                    }
                }
                return nil
            })
            
            
            return valueStrings
        }
        return [String]()
    }
    public static func insertGenericPassword(_ serviceName:String,account:String,value:String,encoding:String.Encoding = .utf8,synchronizable:Bool = false) -> Bool {
        
        let addQuery = IPaKeyChainGenericPassword()
        addQuery.secAttrService = serviceName
        addQuery.secAttrAccount = account
        addQuery.secValueData = value.data(using: encoding)
        addQuery.secAttrSynchronizable = synchronizable
        var data:AnyObject?
        if addQuery.secItemAdd(&data) == errSecSuccess {
            return true
        }
        return false
        
    }
    public static func updateGenericPassword(_ serviceName:String,account:String,value:String,encoding:String.Encoding = .utf8,synchronizable:Bool = false) -> Bool {
        _ = self.removeGenericPassword(serviceName, account: account)
        
        //        let identifier = UIDevice.currentDevice().identifierForVendor!.UUIDString
        return self.insertGenericPassword(serviceName, account: account, value: value, encoding: encoding,synchronizable: synchronizable)
    }
    public static func removeAllGenericPassword(_ serviceName:String) -> Bool {
        let delChainQuery = IPaKeyChainGenericPassword()
        delChainQuery.secAttrService = serviceName
        return delChainQuery.secItemDelete() == errSecSuccess
    }
    public static func removeGenericPassword(_ serviceName:String,account:String) -> Bool {
        let delChainQuery = IPaKeyChainGenericPassword()
        delChainQuery.secAttrService = serviceName
        delChainQuery.secAttrAccount = account
        return delChainQuery.secItemDelete() == errSecSuccess
    }
}

public class IPaKeyChainToken:NSObject {
    @objc dynamic public var token:String? {
        get {
            IPaKeyChain.queryGenericPassword(self.serviceName, account: self.name)
        }
        set {
            _ = IPaKeyChain.removeGenericPassword(self.serviceName, account: self.name)
            if let newValue = newValue {
                _ = IPaKeyChain.insertGenericPassword(self.serviceName, account: self.name, value: newValue)
            }            
        }
    }
    public var serviceName:String
    public var name:String
    public var synchronizable:Bool = false // indicate that token can be synchronizable to icloud
    public init(_ serviceName:String,name:String,synchronizable:Bool = false) {
        self.serviceName = serviceName
        self.name = name
        self.synchronizable = synchronizable
    }
}
