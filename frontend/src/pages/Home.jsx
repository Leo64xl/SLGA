// frontend/src/pages/Home.jsx
import { useState, useEffect } from 'react';
import { FiUsers, FiSearch, FiCheckCircle, FiBook, FiAlertCircle, FiMapPin } from 'react-icons/fi';
import ProfessorCard from '../components/ProfessorCard';
import '../styles/Home.css';

function Home() {
  const [profesores, setProfesores] = useState([]);
  const [search, setSearch] = useState('');
  const [department, setDepartment] = useState('');
  const [status, setStatus] = useState('');

  useEffect(() => {
    const fetchProfesores = () => {
      fetch('http://localhost:8081/api/profesores')
        .then(response => response.json())
        .then(data => setProfesores(data))
        .catch(error => console.error('Error fetching profesores:', error));
    };
    
    fetchProfesores();
    const interval = setInterval(fetchProfesores, 60000);
    return () => clearInterval(interval);
  }, []);

  // Lógica de filtrado en tiempo real
  const filteredProfesores = profesores.filter(p => {
    const fullName = `${p.nombre} ${p.apellidos} ${p.departamento}`.toLowerCase();
    const searchMatch = fullName.includes(search.toLowerCase());
    const departmentMatch = department === '' || p.departamento === department;
    const statusMatch = status === '' || p.estadoActual === status;
    return searchMatch && departmentMatch && statusMatch;
  });

  // Obtener departamentos únicos
  const uniqueDepartments = [...new Set(profesores.map(p => p.departamento))].sort();
  
  // Estados posibles - siempre mostrar estos 4
  const uniqueStatus = ['Disponible', 'En clase', 'En junta', 'Fuera del campus'];
  
  // Contadores de estado
  const countByStatus = (statusName) => {
    return profesores.filter(p => p.estadoActual === statusName).length;
  };

  // Mapping de iconos por estado (basado en Figma)
  const getStatusIcon = (statusName) => {
    const icons = {
      'Disponible': FiCheckCircle,
      'En clase': FiBook,
      'En junta': FiAlertCircle,
      'Fuera del campus': FiMapPin
    };
    return icons[statusName] || FiUsers;
  };

  return (
    <div className="home-page-container">
      <div className="home-wrapper">
        {/* Contadores de Estado */}
        <section className="status-counters">
          {uniqueStatus.map(st => {
            const IconComponent = getStatusIcon(st);
            return (
              <div key={st} className={`counter-card status-${st.toLowerCase().replace(/\s/g, '-')}`}>
                <div className="counter-left">
                  <div className="counter-value">{countByStatus(st)}</div>
                  <div className="counter-label">{st}</div>
                </div>
                <div className="counter-icon-wrapper">
                  <IconComponent className="counter-icon" size={24} />
                </div>
              </div>
            );
          })}
        </section>

        {/* Filtros */}
        <section className="filter-section">
          <div className="search-bar">
            <FiSearch className="search-icon" />
            <input 
              type="text" 
              placeholder="Buscar por nombre, departamento o laboratorio..." 
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="search-input"
            />
          </div>
          
          <div className="filter-controls">
            <select 
              value={department} 
              onChange={(e) => setDepartment(e.target.value)}
              className="filter-select"
            >
              <option value="">Todos los Departamentos</option>
              {uniqueDepartments.map(d => (
                <option key={d} value={d}>{d}</option>
              ))}
            </select>
            
            <select 
              value={status} 
              onChange={(e) => setStatus(e.target.value)}
              className="filter-select"
            >
              <option value="">Todos los Estados</option>
              {uniqueStatus.map(s => (
                <option key={s} value={s}>{s}</option>
              ))}
            </select>
          </div>
        </section>

        {/* Info de resultados */}
        <div className="results-info">
          <p>Mostrando <strong>{filteredProfesores.length}</strong> de <strong>{profesores.length}</strong> profesores</p>
        </div>

        {/* Grid de tarjetas */}
        <section className="professor-grid">
          {filteredProfesores.length > 0 ? (
            filteredProfesores.map(p => (
              <ProfessorCard key={p.id} profesor={p} />
            ))
          ) : (
            <div className="no-results">
              <p>No se encontraron profesores con los filtros seleccionados</p>
            </div>
          )}
        </section>
      </div>
    </div>
  );
}

export default Home;