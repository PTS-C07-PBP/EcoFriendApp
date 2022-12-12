package com.arkitek.flutter.medisys;
import io.flutter.embedding.android.FlutterActivity;
import com.microsoft.appcenter.AppCenter;
import com.microsoft.appcenter.analytics.Analytics;
import com.microsoft.appcenter.crashes.Crashes;
import android.os.Bundle;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        AppCenter.start(getApplication(), "ece9a988-ba13-41af-9429-8977e213335d", Analytics.class, Crashes.class);
        AppCenter.setEnabled(true);
        Analytics.trackEvent("Application started");
        super.onCreate(savedInstanceState);
    }
}