package com.example.emailpicker;

import android.accounts.AccountManager;
import android.accounts.Account;
import android.os.Bundle;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.io/email";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, Result result) {
                        if (call.method.equals("getEmailList")) {
                            final List<String> list = new ArrayList<>();
                            AccountManager manager = AccountManager.get(getApplicationContext());
                            Account[] accounts = manager.getAccountsByType("com.google");
                            List<String> possibleEmails = new ArrayList<String>();

                            for (Account account : accounts) {
                                possibleEmails.add(account.name);
                                System.out.print(account.name);
                            }
                            /*Pattern emailPattern = Patterns.EMAIL_ADDRESS; // API level 8+
                            Account[] accounts = AccountManager.get(getApplicationContext()).getAccounts();
                            for (Account account : accounts) {
                                if (emailPattern.matcher(account.name).matches()) {
                                    primaryEmail = account.name;
                                }
                            }*/
                            result.success(possibleEmails);
                        }
                    }
                }
        );

    }

}
