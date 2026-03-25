package com.example.demo.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*") // Esto permite que React (en el puerto 3000) pueda pedirle datos a Spring (en el puerto 8081)
public class HelloController {

    @GetMapping("/saludo")
    public String obtenerSaludo() {
        return "Localizacíon de aulas y horarios de profesores";
    }
}