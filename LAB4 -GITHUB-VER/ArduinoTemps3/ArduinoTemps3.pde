import processing.serial.*;
import de.bezier.data.sql.*;

String user="YourRootName";
String pass="YourPassword";
String database="arduino";
Serial puerto;
MySQL msql;
float Uhumedad;
float Ucenti;
int a=1;
void setup() {
  size (400, 400);
  puerto=new Serial(this, "COM5", 9600);
  msql = new MySQL( this, "localhost", database, user, pass );
  if (msql.connect()) {
    msql.execute("TRUNCATE TABLE infoarduino;");
  } else {
    println( "Coneccion fallida");
  }
}

void draw() {
  
  if (puerto.available()>0) {
    String data=puerto.readStringUntil('\n');
    if (data != null) {
      background(255);
      String[] parts=data.split(",");
      for (String part : parts) {
        //Inicio Mostrar-----------------------------------
        float humedad = Float.parseFloat(parts[0]);
        float centigrados = Float.parseFloat(parts[1]);
        fill(0);
        textSize(24);
        text("Valor de Humedad: " + humedad, 50, 25);
        Uhumedad=humedad;
        
        textSize(24);
        text("Valor de Temperatura(C): " + centigrados, 50, 50);
        Ucenti=centigrados;
        fill(0);
        text("Humedad", 70, 375);
        if (humedad>=20 && humedad<40) {
          //44,66,121
          fill(44, 66, 121);
          rect(100,300, 25, 50);
        } else if (humedad>=40 && humedad<55) {
          fill(17, 237, 40);
          rect(100, 250, 25, 100);
        } else if (humedad>=55) {
          fill(237, 35, 17);
          rect(100, 200, 25, 150);
        }
        
        fill(0);
        text("Temperatura", 225, 375);
        if (centigrados>=0 && centigrados<15) {
          //44,66,121
          fill(44, 66, 121);
          rect(280,300, 25, 50);
        } else if (centigrados>=15 && centigrados<28) {
          fill(17, 237, 40);
          rect(280, 250, 25, 100);
        } else if (centigrados>=28) {
          fill(237, 35, 17);
          rect(280, 200, 25, 150);
        }
        //Fin Mostrar-----------------------------------
        int y=year();
        int m=month();
        int d=day();
        int s = second();
        int min = minute();
        int h = hour();
        String  fecha=(y+"/"+m+"/"+d+"/ |"+h + ":" + min + ":" + s);
        a++;
        if (msql.connect()) {
          msql.execute( "INSERT INTO infoarduino (idtemp,humedad,centigrados,fecha) VALUES ("+a+","+humedad+","+centigrados+",'"+fecha+"')");
        } else {
          println( "Coneccion fallida");
        }
      }
    } else {
      fill(0);
      textSize(24);
      text("Valor de Humedad: " + Uhumedad, 50, 25);
      fill(0);
      textSize(24);
      text("Valor de Temperatura(C): " +Ucenti, 50, 50);
    }
  }
  delay(2000);
}
