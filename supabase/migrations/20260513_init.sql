-- ══ TABLA SCOUTS ═════════════════════════════════════
CREATE TABLE IF NOT EXISTS scouts (
  id             UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  folio          TEXT UNIQUE NOT NULL,
  fecha_registro TIMESTAMPTZ DEFAULT NOW(),
  -- Datos scout
  rut            TEXT,
  nombres        TEXT,
  ap_paterno     TEXT,
  ap_materno     TEXT,
  fecha_nac      TEXT,
  edad           TEXT,
  telefono       TEXT,
  correo         TEXT,
  colegio        TEXT,
  unidad         TEXT,
  direccion      TEXT,
  religion       TEXT,
  -- Datos apoderado
  ap_nombre      TEXT,
  ap_rut         TEXT,
  ap_parentesco  TEXT,
  ap_correo      TEXT,
  ap_telefono    TEXT,
  -- Datos emergencia
  em_nombre      TEXT,
  em_parentesco  TEXT,
  em_telefono    TEXT
);

-- ══ TABLA PAGOS ══════════════════════════════════════
CREATE TABLE IF NOT EXISTS pagos (
  id         UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  folio      TEXT UNIQUE NOT NULL REFERENCES scouts(folio) ON DELETE CASCADE,
  monto      NUMERIC DEFAULT 15000,
  pagado     NUMERIC DEFAULT 0,
  fecha      TEXT DEFAULT '',
  metodo     TEXT DEFAULT '',
  ref        TEXT DEFAULT '',
  estado     TEXT DEFAULT 'pendiente',
  obs        TEXT DEFAULT '',
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ══ ROW LEVEL SECURITY ═══════════════════════════════
ALTER TABLE scouts ENABLE ROW LEVEL SECURITY;
ALTER TABLE pagos  ENABLE ROW LEVEL SECURITY;

CREATE POLICY "public_scouts" ON scouts FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "public_pagos"  ON pagos  FOR ALL USING (true) WITH CHECK (true);

-- ══ CONFIG TABLE ══════════════════════════════════════
CREATE TABLE IF NOT EXISTS config (
  key   TEXT PRIMARY KEY,
  value TEXT
);
INSERT INTO config (key, value) VALUES ('monto_base', '15000') ON CONFLICT (key) DO NOTHING;
ALTER TABLE config ENABLE ROW LEVEL SECURITY;
CREATE POLICY "public_config" ON config FOR ALL USING (true) WITH CHECK (true);
