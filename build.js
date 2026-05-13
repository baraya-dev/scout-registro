const fs = require('fs');
const path = require('path');

const SUPABASE_URL  = process.env.SUPABASE_URL  || '';
const SUPABASE_ANON = process.env.SUPABASE_ANON_KEY || '';

if (!SUPABASE_URL || !SUPABASE_ANON) {
  console.error('❌ Faltan variables SUPABASE_URL o SUPABASE_ANON_KEY');
  process.exit(1);
}

const dist = path.join(__dirname, 'dist');
if (!fs.existsSync(dist)) fs.mkdirSync(dist);

['index.html', 'admin.html'].forEach(file => {
  let content = fs.readFileSync(path.join(__dirname, file), 'utf8');
  content = content
    .replace(/__SUPABASE_URL__/g,      SUPABASE_URL)
    .replace(/__SUPABASE_ANON_KEY__/g, SUPABASE_ANON);
  fs.writeFileSync(path.join(dist, file), content);
  console.log(`✅ ${file} → dist/${file}`);
});

console.log('🚀 Build completo');
