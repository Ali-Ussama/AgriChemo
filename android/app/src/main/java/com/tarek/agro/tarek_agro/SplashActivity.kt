package com.tarek.agro.tarek_agro

import android.content.Intent
import android.os.Bundle
import android.os.Handler
import io.flutter.embedding.android.FlutterActivity

class SplashActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)

        Handler().postDelayed({
            startActivity(Intent(this, MainActivity::class.java).apply {
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
            })
            finish()
        }, 1000)
    }
}