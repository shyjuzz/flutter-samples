package com.example.imageshare;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

//    new MethodChannel(this.getFlutterView(), SHARE_CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
//      public final void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
//        if (methodCall.method.equals("shareFile")) {
//          shareFile((String) methodCall.arguments);
//        }
//      }
//    });
  }

//  private void shareFile(String path) {
//    File imageFile = new File(this.getApplicationContext().getCacheDir(), path);
//    Uri contentUri = FileProvider.getUriForFile(this, "me.albie.share", imageFile);
//    Intent shareIntent = new Intent(Intent.ACTION_SEND);
//    shareIntent.setType("image/jpg");
//    shareIntent.putExtra(Intent.EXTRA_STREAM, contentUri);
//    this.startActivity(Intent.createChooser(shareIntent, "Share image using"));
//  }
}
