import Flutter
import UIKit

public class NetworkPlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "encryptionChannel", binaryMessenger: registrar.messenger())
    let instance = NetworkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult){

if call.method == "getDecryptedData" {
    var data = ""
    data = call.arguments as! String
//             do {
                print(data)
                var plainText = ""
                 let key = "No9jZYSWanhTRoaUkiAYfosn4jukH0wJ"
                 let cryptLib = CryptLib()
                 let cipherText = cryptLib.encryptPlainTextRandomIV(withPlainText: plainText, key: key) as String?
                 let decryptedString = cryptLib.decryptCipherTextRandomIV(withCipherText: plainText, key: key) as String?
                result(cipherText)
//             } catch {
//                 result(FlutterError(code: "DECRYPTION_ERROR", message: "Decryption failed", details: nil))
//             }

    } else if call.method == "sendEncryptedData" {
//         if let data = call.arguments as? String {
//             do {
//                 let cryptLib = CryptLib()
//                 let plainText = "/17F2M8sw09KAsMOu+LWBDusr75mGoeWEZnvU0rNs+ny2GinDTVs+vX6L3ZnkOtRig783rnVfJOvIAKNf5iAOF26DsbqQLy8eGnkjUUlEhk="
//                 let key = "No9jZYSWanhTRoaUkiAYfosn4jukH0wJ"
//                 if cipherText = cryptLib.encryptPlainTextRandomIV(withPlainText: plainText, key: key) as String? {
//                     result(cipherText)
//                 } else {
//                     result(FlutterError(code: "ENCRYPTION_ERROR", message: "Encryption failed", details: nil))
//                 }
//             } catch {
//                 result(FlutterError(code: "ENCRYPTION_ERROR", message: "Encryption failed", details: nil))
//             }
//         } else {
//             result(FlutterError(code: "ARGUMENT_ERROR", message: "Invalid 'data' argument", details: nil))
//         }
    } else {
        result(FlutterMethodNotImplemented)
    }


}}
