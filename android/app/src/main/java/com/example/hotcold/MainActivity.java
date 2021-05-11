package com.example.hot_cold;

import android.os.StrictMode;

import io.flutter.embedding.android.FlutterActivity;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import java.net.*;
import java.io.*;

public class MainActivity extends FlutterActivity {

    private static final String Exc = "COULD NOT CONNECT TO THE SERVER";

    private static final String CHANNEL = "com.example.hot_cold/getStrategy";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {


        // *1 To run Internet on main thread
        StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(policy);
        // END_OF_*1

        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            // Note: this method is invoked on the main thread.
                            if (call.method.equals("getStrategy")) {
                                String strategy = getStrategy(call.argument("url"));

                                if (strategy != null && strategy != Exc) {
                                    result.success(strategy);
                                } else {
                                    result.success("");
//                                    result.error("UNAVAILABLE", null, null);
                                }
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    private String getStrategy(String url) {
        String result = "";
        try {
            URL hotCold = new URL(url);
            URLConnection yc = hotCold.openConnection();
            BufferedReader in = new BufferedReader(
                    new InputStreamReader(
                            yc.getInputStream()));
            result = in.readLine();
            in.close();
        }catch (Exception e){
            result = Exc;
        }

        return result;
    }

}