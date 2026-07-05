// ============================================================
// Configuration Supabase — PRISM
// ============================================================
// 1. Va sur https://supabase.com/dashboard/project/_/settings/api
// 2. Copie ton "Project URL" et colle-le ci-dessous à la place de
//    'https://TON-PROJET.supabase.co'
// 3. La clé publique (publishable) est déjà en place — c'est la seule
//    clé qui doit apparaître dans du code envoyé au navigateur.
//    NE JAMAIS mettre la clé "secret" ici ou dans un fichier du site.
// ============================================================

const SUPABASE_URL = 'https://TON-PROJET.supabase.co';
const SUPABASE_PUBLISHABLE_KEY = 'sb_publishable_s1sP439rJdMHwIza1yoPFA_wykQqfS4';

const supabaseClient = window.supabase.createClient(SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY);
