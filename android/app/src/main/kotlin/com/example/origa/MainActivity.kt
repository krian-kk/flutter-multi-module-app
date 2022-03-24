package com.example.origa

import android.annotation.SuppressLint
import android.media.AudioRecord
import android.media.MediaPlayer
import android.media.MediaRecorder
import android.media.MediaRecorder.OutputFormat
import android.os.Bundle
import android.util.Log
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
class MainActivity : FlutterActivity() {
    private val recordChannel = "recordAudioChannel"
    //recordAudioChannel
    private var mediaRecorder: MediaRecorder? = MediaRecorder()
    private var mediaPlayer: MediaPlayer? = null
    private var output: String? = null
    private var length: Int = 0
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        this.window.setFlags(
//            WindowManager.LayoutParams.FLAG_SECURE,
//            WindowManager.LayoutParams.FLAG_SECURE
//        )
    }
    @SuppressLint("NewApi")
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            recordChannel
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "startRecordAudio" -> {
                    try{
                        print("Start")
                        mediaRecorder = MediaRecorder( )
                        output = call.argument<String>("filePath")
                        mediaRecorder?.setAudioSource(MediaRecorder.AudioSource.MIC)
                        mediaRecorder?.setOutputFormat(OutputFormat.THREE_GPP)
                        mediaRecorder?.setAudioEncoder(MediaRecorder.AudioEncoder.HE_AAC)
                        mediaRecorder?.setAudioEncodingBitRate(128000)
                        mediaRecorder?.setAudioSamplingRate(48000)
                        mediaRecorder?.setOutputFile(output)
                        mediaRecorder?.prepare();
                        mediaRecorder?.start()
                        result.success(true)
                    }catch (e : Exception){
                        e.printStackTrace()
                    }
                }
                "stopRecordAudio" -> {
                    print("Stop")
                    Log.d("1","success")
                    mediaRecorder.let {
                        Log.d("2","success")
                        mediaRecorder?.stop()
                        length = 0
                        result.success(true)
                    }
                    Log.d("3","success")
                }
                "playRecordAudio" -> {
                    print("Recording")
                    mediaPlayer = MediaPlayer()
                    output = call.argument<String>("filePath")
                    mediaPlayer?.setDataSource(output)
                    mediaPlayer?.prepare()
                    mediaPlayer?.start()
                    result.success(true)
                }
                "pausePlayingAudio" -> {
                    try {
                        print("Pause")
                        mediaPlayer?.pause()
                        length = mediaPlayer!!.currentPosition
                        result.success(true)
                    } catch (e : Exception){
                        e.printStackTrace()
                        result.success(false)
                    }
                }
                "resumePlayingAudio" -> {
                    try {
                        print("Resume")
                        mediaPlayer?.seekTo(length);
                        mediaPlayer?.start()
                        result.success(true)
                    } catch (e : Exception){
                        result.success(false)
                        e.printStackTrace()
                    }
                }
                "stopPlayingAudio" -> {
                    print("Stop");
                    mediaPlayer?.stop()
                    result.success(true)
                }
                "completeRecordAudio" -> {
                    mediaPlayer?.setOnCompletionListener {
                        print("completed")
                        result.success("Co")
                    }
                }
                "disposeRecordAudio" -> {
                    mediaPlayer?.stop()
                    mediaPlayer?.release()
                    mediaPlayer = null
                }
                "disposeRecordAudio" -> {
                    result.success(true)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
