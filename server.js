const express = require('express');
const cors = require('cors');
const app = express();
app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
  res.json({ mensaje: '🚀 ClipFlow FUNCIONANDO!', estado: 'activo' });
});

app.get('/api/feed', (req, res) => {
  res.json({
    videos: [
      { id: 1, usuario: 'clipflow', descripcion: '¡Bienvenido a ClipFlow! 🎉', likes: 1250 },
      { id: 2, usuario: 'tucanal', descripcion: 'Tu primer video 🔥', likes: 890 }
    ]
  });
});

const PUERTO = process.env.PORT || 3000;
app.listen(PUERTO, () => console.log(`✅ Servidor en puerto ${PUERTO}`));
