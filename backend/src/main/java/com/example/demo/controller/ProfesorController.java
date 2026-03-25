package com.example.demo.controller;

import com.example.demo.model.Profesor;
import com.example.demo.repository.ProfesorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/profesores")
@CrossOrigin(origins = "*") // Permite que React consuma esta API
public class ProfesorController {

    @Autowired
    private ProfesorRepository profesorRepository;

    // React llamará a este endpoint cada X segundos para tener los datos frescos
    @GetMapping
    public List<Profesor> obtenerProfesores() {
        return profesorRepository.findAll();
    }

    // Este endpoint es para cuando el usuario haga click en un profesor específico y quiera ver su detalle
    @GetMapping("/{id}")
    public Profesor obtenerProfesorPorId(@PathVariable Long id) {
        return profesorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Profesor no encontrado"));
    }
}

