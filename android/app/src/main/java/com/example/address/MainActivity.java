package com.example.address;


import android.location.Geocoder;

import androidx.annotation.NonNull;

import java.io.IOException;
import java.util.List;
import java.util.Locale;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "flutter.native/helper";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        new MethodChannel(this.getFlutterEngine().getDartExecutor(), CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                        if (call.method.equals("getAddressFromLatLong")) {
                            String greetings = getAddressFromLatLong(call.argument("lat"),call.argument("long"));
                            result.success(greetings);
                        }
                    }});
    }

    public  String getAddressFromLatLong(String lat, String longi){

        String Address = "Address Not Available";
        double latitude = Double.parseDouble(lat);
        double longitude = Double.parseDouble(longi);
        Geocoder geocoder;
        List<android.location.Address> addresses;
        geocoder = new Geocoder(getActivity(), Locale.getDefault());
        try {
            addresses = geocoder.getFromLocation(latitude,longitude,1);
            Address = addresses.get(0).getAddressLine(0);
        }catch (Exception e){
            e.printStackTrace();
            return "Error";
        }

        return Address;

    }

}
