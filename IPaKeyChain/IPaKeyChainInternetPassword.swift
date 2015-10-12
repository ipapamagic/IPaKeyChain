//
//  IPaKeyChainInternetPassword.swift
//  IPaKeyChain
//
//  Created by IPa Chen on 2015/10/12.
//  Copyright © 2015年 A Magic Studio. All rights reserved.
//

import Foundation
public enum IPaSecAttrProtocol: RawRepresentable {
    case FTP, FTPAccount, HTTP, IRC, NNTP, POP3, SMTP, SOCKS, IMAP, LDAP, AppleTalk, AFP, Telnet, SSH, FTPS, HTTPS, HTTPProxy, HTTPSProxy, FTPProxy, SMB, RTSP, RTSPProxy, DAAP, EPPC, IPP, NNTPS, LDAPS, TelnetS, IMAPS, IRCS, POP3S
    
    public init?(rawValue: String) {
        switch rawValue {
        case String(kSecAttrProtocolFTP):
            self = FTP
        case String(kSecAttrProtocolFTPAccount):
            self = FTPAccount
        case String(kSecAttrProtocolHTTP):
            self = HTTP
        case String(kSecAttrProtocolIRC):
            self = IRC
        case String(kSecAttrProtocolNNTP):
            self = NNTP
        case String(kSecAttrProtocolPOP3):
            self = POP3
        case String(kSecAttrProtocolSMTP):
            self = SMTP
        case String(kSecAttrProtocolSOCKS):
            self = SOCKS
        case String(kSecAttrProtocolIMAP):
            self = IMAP
        case String(kSecAttrProtocolLDAP):
            self = LDAP
        case String(kSecAttrProtocolAppleTalk):
            self = AppleTalk
        case String(kSecAttrProtocolAFP):
            self = AFP
        case String(kSecAttrProtocolTelnet):
            self = Telnet
        case String(kSecAttrProtocolSSH):
            self = SSH
        case String(kSecAttrProtocolFTPS):
            self = FTPS
        case String(kSecAttrProtocolHTTPS):
            self = HTTPS
        case String(kSecAttrProtocolHTTPProxy):
            self = HTTPProxy
        case String(kSecAttrProtocolHTTPSProxy):
            self = HTTPSProxy
        case String(kSecAttrProtocolFTPProxy):
            self = FTPProxy
        case String(kSecAttrProtocolSMB):
            self = SMB
        case String(kSecAttrProtocolRTSP):
            self = RTSP
        case String(kSecAttrProtocolRTSPProxy):
            self = RTSPProxy
        case String(kSecAttrProtocolDAAP):
            self = DAAP
        case String(kSecAttrProtocolEPPC):
            self = EPPC
        case String(kSecAttrProtocolIPP):
            self = IPP
        case String(kSecAttrProtocolNNTPS):
            self = NNTPS
        case String(kSecAttrProtocolLDAPS):
            self = LDAPS
        case String(kSecAttrProtocolTelnetS):
            self = TelnetS
        case String(kSecAttrProtocolIMAPS):
            self = IMAPS
        case String(kSecAttrProtocolIRCS):
            self = IRCS
        case String(kSecAttrProtocolPOP3S):
            self = POP3S
        default:
            self = HTTP
        }
    }
    
    public var rawValue: String {
        switch self {
        case .FTP:
            return String(kSecAttrProtocolFTP)
        case .FTPAccount:
            return String(kSecAttrProtocolFTPAccount)
        case .HTTP:
            return String(kSecAttrProtocolHTTP)
        case .IRC:
            return String(kSecAttrProtocolIRC)
        case .NNTP:
            return String(kSecAttrProtocolNNTP)
        case .POP3:
            return String(kSecAttrProtocolPOP3)
        case .SMTP:
            return String(kSecAttrProtocolSMTP)
        case .SOCKS:
            return String(kSecAttrProtocolSOCKS)
        case .IMAP:
            return String(kSecAttrProtocolIMAP)
        case .LDAP:
            return String(kSecAttrProtocolLDAP)
        case .AppleTalk:
            return String(kSecAttrProtocolAppleTalk)
        case .AFP:
            return String(kSecAttrProtocolAFP)
        case .Telnet:
            return String(kSecAttrProtocolTelnet)
        case .SSH:
            return String(kSecAttrProtocolSSH)
        case .FTPS:
            return String(kSecAttrProtocolFTPS)
        case .HTTPS:
            return String(kSecAttrProtocolHTTPS)
        case .HTTPProxy:
            return String(kSecAttrProtocolHTTPProxy)
        case .HTTPSProxy:
            return String(kSecAttrProtocolHTTPSProxy)
        case .FTPProxy:
            return String(kSecAttrProtocolFTPProxy)
        case .SMB:
            return String(kSecAttrProtocolSMB)
        case .RTSP:
            return String(kSecAttrProtocolRTSP)
        case .RTSPProxy:
            return String(kSecAttrProtocolRTSPProxy)
        case .DAAP:
            return String(kSecAttrProtocolDAAP)
        case .EPPC:
            return String(kSecAttrProtocolEPPC)
        case .IPP:
            return String(kSecAttrProtocolIPP)
        case .NNTPS:
            return String(kSecAttrProtocolNNTPS)
        case .LDAPS:
            return String(kSecAttrProtocolLDAPS)
        case .TelnetS:
            return String(kSecAttrProtocolTelnetS)
        case .IMAPS:
            return String(kSecAttrProtocolIMAPS)
        case .IRCS:
            return String(kSecAttrProtocolIRCS)
        case .POP3S:
            return String(kSecAttrProtocolPOP3S)
        }
    }
}
public enum IPaSecAuthenticationType: RawRepresentable {
    case NTLM, MSN, DPA, RPA, HTTPBasic, HTTPDigest, HTMLForm, Default
    
    public init?(rawValue: String) {
        switch rawValue {
        case String(kSecAttrAuthenticationTypeNTLM):
            self = NTLM
        case String(kSecAttrAuthenticationTypeMSN):
            self = MSN
        case String(kSecAttrAuthenticationTypeDPA):
            self = DPA
        case String(kSecAttrAuthenticationTypeRPA):
            self = RPA
        case String(kSecAttrAuthenticationTypeHTTPBasic):
            self = HTTPBasic
        case String(kSecAttrAuthenticationTypeHTTPDigest):
            self = HTTPDigest
        case String(kSecAttrAuthenticationTypeHTMLForm):
            self = HTMLForm
        case String(kSecAttrAuthenticationTypeDefault):
            self = Default
        default:
            self = Default
        }
    }
    
    public var rawValue: String {
        switch self {
        case .NTLM:
            return String(kSecAttrAuthenticationTypeNTLM)
        case .MSN:
            return String(kSecAttrAuthenticationTypeMSN)
        case .DPA:
            return String(kSecAttrAuthenticationTypeDPA)
        case .RPA:
            return String(kSecAttrAuthenticationTypeRPA)
        case .HTTPBasic:
            return String(kSecAttrAuthenticationTypeHTTPBasic)
        case .HTTPDigest:
            return String(kSecAttrAuthenticationTypeHTTPDigest)
        case .HTMLForm:
            return String(kSecAttrAuthenticationTypeHTMLForm)
        case .Default:
            return String(kSecAttrAuthenticationTypeDefault)
        }
    }
}
class IPaKeyChainInternetPassword :IPaKeyChainPassword {
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
        self.keychainItemData[String(kSecClass)] = String(kSecClassInternetPassword)
    }
    
    /*
    kSecClassInternetPassword item attributes:
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
    kSecAttrSecurityDomain
    kSecAttrServer
    kSecAttrProtocol
    kSecAttrAuthenticationType
    kSecAttrPort
    kSecAttrPath
    kSecAttrSynchronizable
    */
    var secAttrSecurityDomain:String? {
        get {
            return keychainItemData[String(kSecAttrSecurityDomain)] as? String
        }
        set {
            
            keychainItemData[String(kSecAttrSecurityDomain)] = newValue
        }
    }
    var secAttrServer:String? {
        get {
            return keychainItemData[String(kSecAttrServer)] as? String
        }
        set {
            
            keychainItemData[String(kSecAttrServer)] = newValue
        }
    }
    var secAttrProtocol:IPaSecAttrProtocol? {
        get {
            if let value = keychainItemData[String(kSecAttrProtocol)] as? String {
                return IPaSecAttrProtocol(rawValue: value)
            }
            return nil
        }
        set {
            
            keychainItemData[String(kSecAttrProtocol)] = newValue?.rawValue
        }
    }
    var secAttrAuthenticationType:IPaSecAuthenticationType? {
        get {
            if let value = keychainItemData[String(kSecAttrAuthenticationType)] as? String {
                return IPaSecAuthenticationType(rawValue: value)
            }
            return nil
        }
        set {
            
            keychainItemData[String(kSecAttrAuthenticationType)] = newValue?.rawValue
        }
    }
    var secAttrPort:Int? {
        get {
            return keychainItemData[String(kSecAttrPort)] as? Int
        }
        set {
            
            keychainItemData[String(kSecAttrPort)] = newValue
        }
    }
    var secAttrPath:String? {
        get {
            return keychainItemData[String(kSecAttrPath)] as? String
        }
        set {
            
            keychainItemData[String(kSecAttrPath)] = newValue
        }
    }

}