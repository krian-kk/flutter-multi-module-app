import UIKit
import Flutter
//import GoogleMaps
// import Firebase
// import FirebaseMessaging
import AVFoundation

@UIApplicationMain


@objc class AppDelegate: FlutterAppDelegate,AVAudioRecorderDelegate, AVAudioPlayerDelegate {

     var result: FlutterResult?


    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        let audioSession : AVAudioSession = AVAudioSession.sharedInstance()
        var audioPlayer : AVAudioPlayer = AVAudioPlayer()
        var audioRecord: AVAudioRecorder!

//        let settings = [  AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//                                  AVSampleRateKey: 12000,
//                            AVNumberOfChannelsKey: 1,
//                         AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue ]

        let settings =   [  AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                            AVSampleRateKey: 48000,
                            AVNumberOfChannelsKey: 2,
                            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
                            ]
        var mPath: String = ""
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let recordChannel = FlutterMethodChannel(name: "recordAudioChannel",
                                                 binaryMessenger: controller.binaryMessenger)


        //    Messaging.messaging().delegate = self;
//         FirebaseApp.configure()
//         application.registerForRemoteNotifications()
        // GMSServices.provideAPIKey("AIzaSyCZI9K_T5crucTDPuNMvolMqRBL_srEMOU")
//        GMSServices.provideAPIKey("AIzaSyCd2C9YZHP8pHM36PANa8eOCfGU9oCyKTE")
        GeneratedPluginRegistrant.register(with: self)
//         Messaging.messaging().isAutoInitEnabled = true;

        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
//         application.registerForRemoteNotifications()
//         Messaging.messaging().delegate = self
//         UNUserNotificationCenter.current().delegate = self

        recordChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            // guard call.method == "initAudioRecord" else {
            //     result(FlutterMethodNotImplemented)
            //   return
            // }

            self?.result = result


            guard let args = call.arguments as? [String : Any] else {return}
//            let filePath = args["filePath"] as! String
            if call.method == "startRecordAudio" {
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                mPath = documentsPath + "/" + String(10) + ".m4a"

                do {
                    try audioSession.setCategory(AVAudioSession.Category.playAndRecord, options: .defaultToSpeaker)
                    audioRecord = try AVAudioRecorder (url:  URL(fileURLWithPath: mPath) , settings: settings )
                    audioRecord.delegate = self
                    audioRecord.isMeteringEnabled = true
                    audioRecord.prepareToRecord()
                    if(!(audioRecord.isRecording)) {
                        print("Record Start")
                        audioRecord.record()
                        result(true)
                    }
                } catch let error {
                    result(false)
                    print(error)
                }
            } else if(call.method == "stopRecordAudio") {
                if(audioRecord == nil ) {
                    result(false)
                } else {
                    print("Record Stop")
//                    audioRecord.stop()
//                    self!.convertAudio( URL(fileURLWithPath: mPath), outputURL: URL(fileURLWithPath: filePath))
                    result(true)
                }
            } else if(call.method == "playRecordAudio") {
//                do {
//                    audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePath))
//                    audioPlayer.prepareToPlay()
//                    audioPlayer.delegate = self
//                    audioPlayer.play()
                    print("Play Audio")
                    result(true)
//                } catch let error {
//                    result(false)
//                    print(error)
//                }
            } else if(call.method == "stopPlayingAudio") {
                print("Stop Audio")
                if(audioRecord == nil ) {
                    result(false)
                } else {
                    audioPlayer.stop()
                    result(true)
                }
            } else if(call.method == "pausePlayingAudio") {
                print("Pause Audio")
                if(audioRecord == nil ) {
                    result(false)
                } else {
                    audioPlayer.pause()
                    result(true)
                }
            } else if(call.method == "resumePlayingAudio") {
                print("Resume Audio")
                if(audioRecord == nil ) {
                    result(false)
                } else {
                    audioPlayer.play()
                    result(true)
                }
            } else if(call.method == "completeRecordAudio") {
                print("completed")
            }
            else {
                print("UnReadable Method")

            }
        })

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func convertAudio(_ url: URL, outputURL: URL) {
        var error : OSStatus = noErr
        var destinationFile : ExtAudioFileRef? = nil
        var sourceFile : ExtAudioFileRef? = nil

        var srcFormat : AudioStreamBasicDescription = AudioStreamBasicDescription()
        var dstFormat : AudioStreamBasicDescription = AudioStreamBasicDescription()

        ExtAudioFileOpenURL(url as CFURL, &sourceFile)

        var thePropertySize: UInt32 = UInt32(MemoryLayout.stride(ofValue: srcFormat))

        ExtAudioFileGetProperty(sourceFile!,
            kExtAudioFileProperty_FileDataFormat,
            &thePropertySize, &srcFormat)

        dstFormat.mSampleRate = 44100  //Set sample rate
        dstFormat.mFormatID = kAudioFormatLinearPCM
        dstFormat.mChannelsPerFrame = 1
        dstFormat.mBitsPerChannel = 16
        dstFormat.mBytesPerPacket = 2 * dstFormat.mChannelsPerFrame
        dstFormat.mBytesPerFrame = 2 * dstFormat.mChannelsPerFrame
        dstFormat.mFramesPerPacket = 1
        dstFormat.mFormatFlags = kLinearPCMFormatFlagIsPacked |
        kAudioFormatFlagIsSignedInteger


        // Create destination file
        error = ExtAudioFileCreateWithURL(
            outputURL as CFURL,
            kAudioFileWAVEType,
            &dstFormat,
            nil,
            AudioFileFlags.eraseFile.rawValue,
            &destinationFile)
        reportError(error: error)

        error = ExtAudioFileSetProperty(sourceFile!,
                kExtAudioFileProperty_ClientDataFormat,
                thePropertySize,
                &dstFormat)
        reportError(error: error)

        error = ExtAudioFileSetProperty(destinationFile!,
                                         kExtAudioFileProperty_ClientDataFormat,
                                        thePropertySize,
                                        &dstFormat)
        reportError(error: error)

        let bufferByteSize : UInt32 = 32768
        var srcBuffer = [UInt8](repeating: 0, count: 32768)
        var sourceFrameOffset : ULONG = 0

        while(true){
            var fillBufList = AudioBufferList(
                mNumberBuffers: 1,
                mBuffers: AudioBuffer(
                    mNumberChannels: 2,
                    mDataByteSize: UInt32(srcBuffer.count),
                    mData: &srcBuffer
                )
            )
            var numFrames : UInt32 = 0

            if(dstFormat.mBytesPerFrame > 0){
                numFrames = bufferByteSize / dstFormat.mBytesPerFrame
            }

            error = ExtAudioFileRead(sourceFile!, &numFrames, &fillBufList)
            reportError(error: error)

            if(numFrames == 0){
                error = noErr;
                break;
            }

            sourceFrameOffset += numFrames
            error = ExtAudioFileWrite(destinationFile!, numFrames, &fillBufList)
            reportError(error: error)
        }

        error = ExtAudioFileDispose(destinationFile!)
        reportError(error: error)
        error = ExtAudioFileDispose(sourceFile!)
        reportError(error: error)
    }

    func reportError(error: OSStatus) {
        // Handle error
        print(error)
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.result!("On completed result is true")
    }
}
