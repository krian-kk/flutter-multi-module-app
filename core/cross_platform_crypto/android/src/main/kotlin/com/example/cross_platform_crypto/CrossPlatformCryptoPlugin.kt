package com.example.cross_platform_crypto

import androidx.annotation.NonNull
import CryptLib

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import android.content.pm.PackageManager

/** CrossPlatformCryptoPlugin */
class CrossPlatformCryptoPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "cross_platform_crypto")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getDecryptedData") {
            val data = call.argument<String>("data")
            print(data)
            try {
                val cryptLib = CryptLib()
                val key = "No9jZYSWanhTRoaUkiAYfosn4jukH0wJ"
                val decryptedString = data?.let {
                    cryptLib.decryptCipherTextWithRandomIV(
                        it,
                        key
                    )
                }
                result.success(decryptedString)
            } catch (e: PackageManager.NameNotFoundException) {
                e.printStackTrace()
            }
        } else if (call.method == "sendEncryptedData") {
            val data = call.argument<String>("data")
            print(data)
            try {
                val key = "No9jZYSWanhTRoaUkiAYfosn4jukH0wJ"
                val cryptLib = CryptLib()
                val decryptedString = data?.let {
                    cryptLib.encryptPlainTextWithRandomIV(
                        it,
                        key
                    )
                }
                result.success(decryptedString)
            } catch (e: PackageManager.NameNotFoundException) {
                e.printStackTrace()
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
