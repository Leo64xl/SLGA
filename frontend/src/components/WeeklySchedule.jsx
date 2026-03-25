import React from 'react';
import { FiBook, FiAlertCircle, FiCheckCircle, FiMapPin, FiClock, FiGrid } from 'react-icons/fi';
import '../styles/WeeklySchedule.css';

const WeeklySchedule = ({ horarios }) => {
  const DIAS_SEMANA = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];
  const HORAS = Array.from({ length: 11 }, (_, i) => `${String(8 + i).padStart(2, '0')}:00`);

  // Procesar horarios y organizarlos por día y hora
  const organizarHorarios = () => {
    const grid = {};
    DIAS_SEMANA.forEach(dia => {
      grid[dia] = [];
    });

    horarios.forEach(horario => {
      if (grid[horario.diaSemana]) {
        grid[horario.diaSemana].push(horario);
      }
    });

    return grid;
  };

  const horariosOrganizados = organizarHorarios();

  // Obtener icono por tipo de actividad
  const getActivityIcon = (tipo) => {
    switch (tipo.toLowerCase()) {
      case 'disponible':
        return <FiCheckCircle className="activity-icon" />;
      case 'clase':
        return <FiBook className="activity-icon" />;
      case 'laboratorio':
        return <FiCheckCircle className="activity-icon" />;
      case 'reunión':
      case 'junta':
        return <FiAlertCircle className="activity-icon" />;
      case 'fuera del campus':
        return <FiMapPin className="activity-icon" />;
      default:
        return <FiMapPin className="activity-icon" />;
    }
  };

  // Obtener clase CSS por tipo de actividad
  const getActivityClass = (tipo) => {
    return `activity-${tipo.toLowerCase().replace(/\s/g, '-')}`;
  };

  // Calcular posición vertical basada en la hora
  const calcularPosicion = (horaInicio) => {
    const [hora] = horaInicio.split(':');
    const horaNum = parseInt(hora);
    const offset = horaNum - 8;
    return offset >= 0 ? offset : 0;
  };

  return (
    <div className="weekly-schedule-container">
      <div className="schedule-header-top">
        <div className="header-title">
          <FiGrid className="header-icon" />
          <div>
            <h3>Horario Semanal</h3>
            <p>Visualiza tu carga de actividades académicas</p>
          </div>
        </div>
      </div>
      
      <div className="schedule-wrapper">
        <div className="schedule-grid">
          {/* Encabezado con días */}
          <div className="schedule-header">
            <div className="time-column"></div>
            {DIAS_SEMANA.map(dia => (
              <div key={dia} className="day-header">
                <span className="day-name">{dia}</span>
              </div>
            ))}
          </div>

          {/* Cuerpo del calendario */}
          <div className="schedule-body">
            {/* Columna de horas */}
            <div className="time-column">
              {HORAS.map(hora => (
                <div key={hora} className="time-slot">
                  <FiClock className="time-icon" />
                  <span>{hora}</span>
                </div>
              ))}
            </div>

            {/* Columnas de días */}
            {DIAS_SEMANA.map(dia => (
              <div key={dia} className="day-column">
                {HORAS.map((hora, idx) => (
                  <div key={`${dia}-${hora}`} className="time-cell">
                    {horariosOrganizados[dia] &&
                      horariosOrganizados[dia].map(horario => {
                        const posicion = calcularPosicion(horario.horaInicio);
                        const esEstaHora = posicion === idx;

                        return esEstaHora ? (
                          <div
                            key={horario.id}
                            className={`activity-block ${getActivityClass(
                              horario.tipoActividad
                            )}`}
                          >
                            <div className="activity-icon-wrapper">
                              {getActivityIcon(horario.tipoActividad)}
                            </div>
                            <div className="activity-content">
                              <div className="activity-header">
                                <span className="activity-type">
                                  {horario.tipoActividad}
                                </span>
                              </div>
                              <p className="activity-subject">{horario.materia}</p>
                              <div className="activity-meta">
                                <span className="activity-time">
                                  {horario.horaInicio} - {horario.horaFin}
                                </span>
                                <span className="activity-location">
                                  {horario.aula.nombre}
                                </span>
                              </div>
                            </div>
                          </div>
                        ) : null;
                      })}
                  </div>
                ))}
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Leyenda mejorada */}
      <div className="schedule-legend">
        <div className="legend-title">
          <span>Tipos de Actividad</span>
        </div>
        <div className="legend-items">
          <div className="legend-item">
            <div className="legend-color-box disponible">
              <FiCheckCircle />
            </div>
            <span>Disponible</span>
          </div>
          <div className="legend-item">
            <div className="legend-color-box clase">
              <FiBook />
            </div>
            <span>Clase</span>
          </div>
          <div className="legend-item">
            <div className="legend-color-box laboratorio">
              <FiCheckCircle />
            </div>
            <span>Laboratorio</span>
          </div>
          <div className="legend-item">
            <div className="legend-color-box reunión">
              <FiAlertCircle />
            </div>
            <span>Reunión</span>
          </div>
          <div className="legend-item">
            <div className="legend-color-box fuera-del-campus">
              <FiMapPin />
            </div>
            <span>Fuera del Campus</span>
          </div>
        </div>
      </div>
    </div>
  );
};

export default WeeklySchedule;
