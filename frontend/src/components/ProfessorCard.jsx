// frontend/src/components/ProfessorCard.jsx
import React from 'react';
import { Link } from 'react-router-dom';
import { FiMapPin, FiBook, FiCheckCircle, FiAlertCircle } from 'react-icons/fi';
import '../styles/ProfessorCard.css';

function ProfessorCard({ profesor }) {
  const statusClass = profesor.estadoActual.toLowerCase().replace(/\s/g, '-');
  const location = profesor.horarios && profesor.horarios.length > 0 
    ? profesor.horarios[0].aula.nombre 
    : 'Cubículo';
  
  const getStatusIcon = () => {
    const status = profesor.estadoActual.toLowerCase();
    if (status.includes('disponible')) return FiCheckCircle;
    if (status.includes('clase')) return FiBook;
    if (status.includes('reunión')) return FiAlertCircle;
    return FiMapPin;
  };

  const StatusIcon = getStatusIcon();
  
  return (
    <Link to={`/profesor/${profesor.id}`} className="card-link">
      <div className="professor-card">
        <div className="card-header">
          <div className="professor-info">
            <h3>{profesor.nombre} {profesor.apellidos}</h3>
            <p className="department-text">{profesor.departamento}</p>
          </div>
          <div className={`status-badge status-${statusClass}`}>
            <StatusIcon size={14} />
            <span>{profesor.estadoActual}</span>
          </div>
        </div>

        <div className="card-body">
          <div className="info-item">
            <FiMapPin className="info-icon" size={18} />
            <div className="info-content">
              <div className="info-label">Ubicación Actual</div>
              <div className="info-value">{location}</div>
            </div>
          </div>
          
          {profesor.horarios && profesor.horarios.length > 0 && (
            <div className="info-item">
              <FiBook className="info-icon" size={18} />
              <div className="info-content">
                <div className="info-label">Próxima Actividad</div>
                <div className="info-value">{profesor.horarios[0].tipoActividad}</div>
              </div>
            </div>
          )}
        </div>
      </div>
    </Link>
  );
}

export default ProfessorCard;