package com.omkar.chend1kar.upi_plugin 

import android.net.Uri
import android.app.Activity
import android.content.Intent
import androidx.annotation.NonNull

import android.util.Log
import android.content.pm.PackageManager
import android.content.pm.ResolveInfo
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** UpiPlugin */
class UpiPlugin: FlutterPlugin, MethodCallHandler, ActivityAware ,PluginRegistry.ActivityResultListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private var activity : Activity? = null

  private lateinit var finalresult : Result

  final var requestCodeNum : Int = 1999

  var isResultReceived : Boolean = false

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "upi_plugin")
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

    finalresult=result

    if (call.method.equals("initiateTransaction")) {

      startTransaction(call)
    }else{
      result.notImplemented()
    }
  }
  private fun startTransaction(call: MethodCall){

    isResultReceived=false

      val app: String? = call.argument("app")
      val pa: String? = call.argument("pa")
      val pn: String? = call.argument("pn")
      val mc: String? = call.argument("mc")
      val tr: String? = call.argument("tr")
      val tn: String? = call.argument("tn")
      val am: String? = call.argument("am")
      val cu: String? = call.argument("cu")
      val url: String? = call.argument("url")
      val mode: String? = call.argument("mode")
      val orgid: String? = call.argument("orgid")

      try{
        var uriStr: String? = "upi://pay?pa=" + pa +
              "&pn=" + Uri.encode(pn) +
              "&tr=" + Uri.encode(tr) +
              "&am=" + Uri.encode(am) +
              "&cu=" + Uri.encode(cu)
      if(url != null) {
        uriStr += ("&url=" + Uri.encode(url))
      }
      if(mc != null) {
        uriStr += ("&mc=" + Uri.encode(mc))
      }
      if(tn != null) {
        uriStr += ("&tn=" + Uri.encode(tn))
      }
      uriStr += "&mode=00" // &orgid=000000"

      val uri = Uri.parse(uriStr)

      var intent : Intent? = Intent(Intent.ACTION_VIEW).apply{
        flags=Intent.FLAG_GRANT_READ_URI_PERMISSION
        data = uri 
      }

      // intent = this.activity!!.getPackageManager().getLaunchIntentForPackage(app!!)
      // intent!!.setAction(Intent.ACTION_VIEW)
      // intent!!.setData(uri)
      intent!!.setPackage(app)
      // this.activity!!.startActivity(intent)
      // if(intent.resolveActivity(this.activity!!.getPackageManager())!=null){
      // if(isAppInstalled(app)){
      this.activity!!.startActivityForResult(intent,requestCodeNum)
      //     finalresult.success("App_exist")
      // }else{
      //     finalresult.error("app_is_not_installed","Requested app not installed",null)
      //     isResultReceived = true
      //     Log.d("upi_plugin",app+" is not installed")
      // }
      // }else {
      //   finalresult.success("app_is_not_installedapp_cannot_resolve_activity")
      // }

    } catch (ex: Exception) {
      finalresult.error(ex.toString(),"Transaction parameters are invalid",null)
      isResultReceived=true
    }
  } 

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) : Boolean {
    if(requestCodeNum == requestCode && finalresult != null){
      if(data != null){
        try{
          var response : String? = data.getStringExtra("response")
          var responseText = response
          if(! isResultReceived ) finalresult.success(responseText)
        }catch (e:Exception){
          if(! isResultReceived) finalresult.error("null_response",e.toString(),null)
        }
      } else {
          if(! isResultReceived) finalresult.error("user_canceled","User canceled the transaction",null)
      }
    }
    return true
  }
  

  private fun isAppInstalled(uri: String?): Boolean {
    var pm : PackageManager = this.activity!!.getPackageManager()
    try{
      pm.getPackageInfo(uri!!,PackageManager.GET_ACTIVITIES)
      return true
    }catch (e: PackageManager.NameNotFoundException){

    }
    return false
  }

  override fun onAttachedToActivity(@NonNull binding : ActivityPluginBinding) {

    activity = binding.getActivity()

    channel.setMethodCallHandler(this)

    binding.addActivityResultListener(this)

  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(@NonNull binding :ActivityPluginBinding ) {
    activity = binding.getActivity()
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
