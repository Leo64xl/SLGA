package com.example.demo.controller;

import com.example.demo.dto.HorarioRequest;
import com.example.demo.model.Aula;
import com.example.demo.model.Horario;
import com.example.demo.model.Profesor;
import com.example.demo.repository.AulaRepository;
import com.example.demo.repository.HorarioRepository;
import com.example.demo.repository.ProfesorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/horarios")
@CrossOrigin(origins = "*")
public class HorarioController {

    @Autowired private HorarioRepository horarioRepository;
    @Autowired private ProfesorRepository profesorRepository;
    @Autowired private AulaRepository aulaRepository;

    @PostMapping("/asignar")
    public Horario asignarNuevoHorario(@RequestBody HorarioRequest request) {
        // 1. Buscamos al profesor y al aula en la base de datos
        Profesor profesor = profesorRepository.findById(request.getProfesorId())
                .orElseThrow(() -> new RuntimeException("Profesor no encontrado"));
        Aula aula = aulaRepository.findById(request.getAulaId())
                .orElseThrow(() -> new RuntimeException("Aula no encontrada"));

        // 2. Creamos el nuevo bloque de horario
        Horario nuevoHorario = new Horario();
        nuevoHorario.setProfesor(profesor);
        nuevoHorario.setAula(aula);
        nuevoHorario.setDiaSemana(request.getDiaSemana());
        nuevoHorario.setHoraInicio(request.getHoraInicio());
        nuevoHorario.setHoraFin(request.getHoraFin());
        nuevoHorario.setMateria(request.getMateria());
        nuevoHorario.setTipoActividad(request.getTipoActividad());

        // 3. Guardamos en MySQL y devolvemos el resultado
        return horarioRepository.save(nuevoHorario);
    }
}