package com.example.demo.controller;

import com.example.demo.model.Horario;
import com.example.demo.model.Profesor;
import com.example.demo.repository.ProfesorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.List;

@RestController
@RequestMapping("/api/profesores")
@CrossOrigin(origins = "*") // Permite que React consuma esta API
public class ProfesorController {

    @Autowired
    private ProfesorRepository profesorRepository;

    @GetMapping
    public List<Profesor> obtenerProfesores() {
        List<Profesor> profesores = profesorRepository.findAll();
        // A cada profesor le calculamos su estado actual antes de enviarlo al Frontend
        profesores.forEach(this::calcularEstadoEnTiempoReal);
        return profesores;
    }

    @GetMapping("/{id}")
    public Profesor obtenerProfesorPorId(@PathVariable Long id) {
        Profesor profesor = profesorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Profesor no encontrado"));
        // También calculamos su estado si piden su detalle individual
        calcularEstadoEnTiempoReal(profesor);
        return profesor;
    }

    /**
     * Lógica dinámica que calcula qué está haciendo el profesor en este preciso minuto.
     */
    private void calcularEstadoEnTiempoReal(Profesor profesor) {
        ZoneId zonaMexico = ZoneId.of("America/Mexico_City");
        LocalTime horaActual = LocalTime.now(zonaMexico);
        DayOfWeek diaActual = LocalDate.now(zonaMexico).getDayOfWeek();

        String diaEspanol = traducirDia(diaActual);
        String nuevoEstado = "Fuera del campus";
        String nuevaUbicacion = "Fuera de la institución"; 

        LocalTime inicioJornada = LocalTime.of(8, 0);
        LocalTime finJornada = LocalTime.of(18, 0);

        if (!horaActual.isBefore(inicioJornada) && !horaActual.isAfter(finJornada) && !diaEspanol.equals("Fin de semana")) {
            nuevoEstado = "Disponible";
            nuevaUbicacion = "Sala de Maestros / Áreas comunes"; 
        }

        if (profesor.getHorarios() != null) {
            for (Horario h : profesor.getHorarios()) {
                if (h.getDiaSemana().equalsIgnoreCase(diaEspanol)) {
                    LocalTime horaInicioClase = parsearHora(h.getHoraInicio());
                    LocalTime horaFinClase = parsearHora(h.getHoraFin());

                    if (horaInicioClase != null && horaFinClase != null) {
                        if (!horaActual.isBefore(horaInicioClase) && horaActual.isBefore(horaFinClase)) {
                            
                            String actividad = h.getTipoActividad().toLowerCase();
                            if (actividad.contains("clase") || actividad.contains("laboratorio")) {
                                nuevoEstado = "En clase";
                            } else if (actividad.contains("reunión") || actividad.contains("junta")) {
                                nuevoEstado = "En junta";
                            } else {
                                nuevoEstado = "Ocupado"; 
                            }
                            
                            nuevaUbicacion = h.getAula().getNombre();

                            profesor.setAulaActual(h.getAula());
                            
                            break; 
                        }
                    }
                }
            }
        }

        profesor.setEstadoActual(nuevoEstado);
        profesor.setUbicacionActual(nuevaUbicacion); // Guardamos la ubicación virtual
    }
    // --- Métodos Auxiliares ---

    private String traducirDia(DayOfWeek day) {
        return switch (day) {
            case MONDAY -> "Lunes";
            case TUESDAY -> "Martes";
            case WEDNESDAY -> "Miércoles"; // Ojo: Acento incluido igual que en tus INSERTS
            case THURSDAY -> "Jueves";
            case FRIDAY -> "Viernes";
            default -> "Fin de semana";
        };
    }

    private LocalTime parsearHora(String horaString) {
        try {
            // A veces la BD manda "09:00" y a veces "09:00:00", esto maneja ambos
            if (horaString.length() == 5) {
                return LocalTime.parse(horaString + ":00");
            }
            return LocalTime.parse(horaString);
        } catch (Exception e) {
            return null;
        }
    }
}