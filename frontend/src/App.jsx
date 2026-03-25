import React from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import { FiUsers } from 'react-icons/fi';
import Home from './pages/Home';
import ProfesorDetail from './pages/ProfesorDetail';
import './styles/App.css';

function App() {
  return (
    <BrowserRouter>
      <div className="app-container">
        <nav className="app-navbar">
          <div className="navbar-content">
            <div className="navbar-logo">
              <FiUsers size={28} />
              <div className="navbar-text">
                <h1>Localización de Profesores</h1>
                <p>Consulta la ubicación actual y horarios de los profesores</p>
              </div>
            </div>
          </div>
        </nav>
        
        <main className="app-content">
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/profesor/:id" element={<ProfesorDetail />} />
          </Routes>
        </main>
      </div>
    </BrowserRouter>
  );
}

export default App;