package com.example.android.firebasedemo;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.database.FirebaseDatabase;

import java.util.HashMap;

public class MainActivity extends AppCompatActivity {

    private Button logout;
    private EditText name;
    private Button add;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        logout = findViewById(R.id.logout);
        name = findViewById(R.id.name_input);
        add = findViewById(R.id.add_button);

        logout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                FirebaseAuth.getInstance().signOut();
                Toast.makeText(MainActivity.this, "Logged out", Toast.LENGTH_SHORT).show();
                startActivity(new Intent(MainActivity.this, StartActivity.class));
            }
        });

        add.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String text_name = name.getText().toString();
                if(text_name.isEmpty()) {
                    Toast.makeText(MainActivity.this, "No Name entered", Toast.LENGTH_SHORT).show();
                } else {
                    FirebaseDatabase.getInstance().getReference().child("Deep Testing").push().child("Name").setValue(text_name);
                    Toast.makeText(MainActivity.this, "Name added!", Toast.LENGTH_SHORT).show();
                }
            }
        });

//        //added database
//        FirebaseDatabase.getInstance().getReference().child("Deep Testing").child("Android").setValue("abcd");

//        //for adding multiple branch to our database
//        HashMap<String, Object> map = new HashMap<>();
//        map.put("Name", "Deep");
//        map.put("Email", "testing@deep.com");
//
//        FirebaseDatabase.getInstance().getReference().child("Deep Testing").updateChildren(map);
    }
}