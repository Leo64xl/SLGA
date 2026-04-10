import React, { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import { FiMail, FiPhone, FiMapPin, FiUsers, FiCpu } from 'react-icons/fi';
import WeeklySchedule from '../components/WeeklySchedule';
import '../styles/ProfesorDetail.css';

const ProfesorDetail = () => {
  const { id } = useParams();
  const [profesor, setProfesor] = useState(null);
  const [cargando, setCargando] = useState(true);

  useEffect(() => {
    const fetchDetalleProfesor = async () => {
      try {
        const respuesta = await fetch(`http://localhost:8081/api/profesores/${id}`);
        const datos = await respuesta.json();
        setProfesor(datos);
        setCargando(false);
      } catch (error) {
        console.error("Error al obtener los detalles:", error);
        setCargando(false);
      }
    };

    fetchDetalleProfesor();
  }, [id]);

  if (cargando) return <div className="loading">Cargando información del profesor...</div>;
  if (!profesor) return <div className="error">No se encontró al profesor.</div>;

  return (
    <div className="detalle-container">
      <Link to="/" className="btn-volver">← Volver al inicio</Link>
      
      <div className="detalle-header">
        <h2>{profesor.nombre} {profesor.apellidos}</h2>
        <p className="department">{profesor.departamento}</p>
        <span className={`estado-badge ${profesor.estadoActual.toLowerCase().replace(/\s/g, '-')}`}>
          {profesor.estadoActual}
        </span>
      </div>

      {/* Cards Principales - Figma Style */}
      <div className="cards-grid">
        {/* Card 1: Información de Contacto */}
        <div className="detail-card">
          <div className="card-icon">
            <FiPhone />
          </div>
          <h3>Información de Contacto</h3>
          <div className="card-content">
            <div className="card-item">
              <FiMail className="item-icon" />
              <div>
                <label>Email</label>
                <p>{profesor.email || 'No disponible'}</p>
              </div>
            </div>
            <div className="card-item">
              <FiPhone className="item-icon" />
              <div>
                <label>Teléfono</label>
                <p>{profesor.telefono || 'No disponible'}</p>
              </div>
            </div>
          </div>
        </div>

        {/* Card 2: Ubicación Actual */}
        <div className="detail-card">
          <div className="card-icon">
            <FiMapPin />
          </div>
          <h3>Ubicación Actual</h3>
          <div className="card-content">
            <div className="card-item">
              <div>
                <label>Lugar</label>
                {/* Usamos la nueva variable del backend */}
                <p className="location-name">{profesor.ubicacionActual}</p>
                <p className="location-building">
                  {profesor.estadoActual === 'Fuera del campus' ? '-' : 'Edificio Principal'}
                </p>
              </div>
            </div>
            <div className="card-item">
              <div>
                <label>Última Actualización</label>
                <p>En tiempo real</p>
              </div>
            </div>
          </div>
        </div>

        
        {/* Card 3: Detalles Técnicos */}
        {profesor.estadoActual === 'En clase' && profesor.aulaActual && (
          <div className="detail-card">
            <div className="card-icon">
              <FiCpu />
            </div>
            <h3>Información del Laboratorio</h3>
            <div className="card-content">
              {/* Nota: Edificio y Piso siguen estáticos porque no existen en tu BD actual, 
                  pero si los agregas a la tabla Aulas en el futuro, podrías ponerlos dinámicos también */}
              <div className="card-item">
                <div>
                  <label>Edificio</label>
                  <p>Edificio Principal</p> 
                </div>
              </div>
              <div className="card-item">
                <div>
                  <label>Piso</label>
                  <p>Planta Baja</p>
                </div>
              </div>
              
              <div className="card-item">
                <div>
                  <label>Capacidad</label>
                  <p>{profesor.aulaActual.capacidad ? `${profesor.aulaActual.capacidad} personas` : 'No especificada'}</p>
                </div>
              </div>
              <div className="card-item">
                <div>
                  <label>Equipamiento</label>
                  <div className="equipamiento-tags">
                    {profesor.aulaActual.equipamiento ? (
                      profesor.aulaActual.equipamiento.split(',').map((equipo, idx) => (
                        <span key={idx} className="tag">{equipo.trim()}</span>
                      ))
                    ) : (
                      <p>No especificado</p>
                    )}
                  </div>
                </div>
              </div>
            </div>
          </div>
        )}
      </div>

      {/* Weekly Schedule Calendar */}
      {profesor.horarios && profesor.horarios.length > 0 && (
        <WeeklySchedule horarios={profesor.horarios} />
      )}

      {/* Resumen de Horarios */}
      <div className="horario-section">
        <h3>Resumen de Horarios</h3>
        
        {profesor.horarios && profesor.horarios.length > 0 ? (
          <table className="horario-tabla">
            <thead>
              <tr>
                <th>Día</th>
                <th>Horario</th>
                <th>Actividad</th>
                <th>Materia</th>
                <th>Aula / Laboratorio</th>
              </tr>
            </thead>
            <tbody>
              {profesor.horarios.map((horario) => (
                <tr key={horario.id}>
                  <td><strong>{horario.diaSemana}</strong></td>
                  <td>{horario.horaInicio} - {horario.horaFin}</td>
                  <td>
                    <span className={`actividad-badge ${horario.tipoActividad.toLowerCase()}`}>
                      {horario.tipoActividad}
                    </span>
                  </td>
                  <td>{horario.materia}</td>
                  <td>{horario.aula.nombre}</td>
                </tr>
              ))}
            </tbody>
          </table>
        ) : (
          <div className="sin-horario">
            <p>Este profesor no tiene horarios asignados actualmente.</p>
          </div>
        )}
      </div>
    </div>
  );
};

export default ProfesorDetail;