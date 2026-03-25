package com.example.demo.dto;

public class HorarioRequest {
    private Long profesorId;
    private Long aulaId;
    private String diaSemana;
    private String horaInicio;
    private String horaFin;
    private String materia;
    private String tipoActividad;

    // Getters
    public Long getProfesorId() { return profesorId; }
    public Long getAulaId() { return aulaId; }
    public String getDiaSemana() { return diaSemana; }
    public String getHoraInicio() { return horaInicio; }
    public String getHoraFin() { return horaFin; }
    public String getMateria() { return materia; }
    public String getTipoActividad() { return tipoActividad; }
}