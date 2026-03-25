package com.example.demo.model;

import jakarta.persistence.*;
import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name = "horarios")
public class Horario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String diaSemana;
    private String horaInicio;
    private String horaFin;
    private String materia;
    private String tipoActividad;

    // JsonBackReference le dice a Spring: "No vuelvas a imprimir al profesor aquí adentro 
    // porque me vas a crear un ciclo infinito".
    @ManyToOne
    @JoinColumn(name = "profesor_id", nullable = false)
    @JsonBackReference 
    private Profesor profesor;

    // Queremos que el Horario siempre incluya los datos de su Aula asignada
    @ManyToOne
    @JoinColumn(name = "aula_id", nullable = false)
    private Aula aula;

    public Horario() {}

    // --- Getters y Setters ---
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getDiaSemana() { return diaSemana; }
    public void setDiaSemana(String diaSemana) { this.diaSemana = diaSemana; }
    
    public String getHoraInicio() { return horaInicio; }
    public void setHoraInicio(String horaInicio) { this.horaInicio = horaInicio; }
    
    public String getHoraFin() { return horaFin; }
    public void setHoraFin(String horaFin) { this.horaFin = horaFin; }
    
    public String getMateria() { return materia; }
    public void setMateria(String materia) { this.materia = materia; }
    
    public String getTipoActividad() { return tipoActividad; }
    public void setTipoActividad(String tipoActividad) { this.tipoActividad = tipoActividad; }
    
    public Profesor getProfesor() { return profesor; }
    public void setProfesor(Profesor profesor) { this.profesor = profesor; }
    
    public Aula getAula() { return aula; }
    public void setAula(Aula aula) { this.aula = aula; }
}