import Flutter
import UIKit

public class CrossPlatformCryptoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "cross_platform_crypto", binaryMessenger: registrar.messenger())
    let instance = CrossPlatformCryptoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String : Any] else {return}
                  let data = args["data"] as! String

                  switch call.method{
                  case "getDecryptedData":
                      do {
                             let cryptLib = CryptLib()
                             let key = "No9jZYSWanhTRoaUkiAYfosn4jukH0wJ"
                          let decryptedString = try cryptLib.decryptCipherTextRandomIV(withCipherText: data, key: key) as String?
                          result(decryptedString)

                      } catch {
                          result(FlutterError(code: "DECRYPTION_ERROR", message: "Encryption failed", details: nil))

                      }
                  case "sendEncryptedData":
                      do {

                           let cryptLib = CryptLib()
                           let key = "No9jZYSWanhTRoaUkiAYfosn4jukH0wJ"

                           let cipherText = try cryptLib.encryptPlainTextRandomIV(withPlainText: data, key: key)
                          result(cipherText)

                      } catch {
                          result(FlutterError(code: "ENCRYPTION_ERROR", message: "Encryption failed", details: nil))

                      }
                  default:
                      result(FlutterMethodNotImplemented)

                  }
  }
}
