-- ============================================================
-- Schéma PRISM — à exécuter dans Supabase → SQL Editor → New query
-- ============================================================

-- Table des profils clients (liée aux comptes auth Supabase)
create table if not exists public.profiles (
  id uuid references auth.users on delete cascade primary key,
  full_name text,
  phone text,
  address text,
  created_at timestamptz default now()
);

alter table public.profiles enable row level security;

create policy "Un utilisateur voit son propre profil"
  on public.profiles for select
  using (auth.uid() = id);

create policy "Un utilisateur modifie son propre profil"
  on public.profiles for update
  using (auth.uid() = id);

create policy "Un utilisateur crée son propre profil"
  on public.profiles for insert
  with check (auth.uid() = id);

-- Création automatique du profil à l'inscription
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, full_name)
  values (new.id, new.raw_user_meta_data->>'full_name');
  return new;
end;
$$ language plpgsql security definer;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- Table des commandes
create table if not exists public.orders (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users on delete cascade,
  model text,
  color text,
  storage text,
  os text,
  message text,
  status text default 'Reçue',
  created_at timestamptz default now()
);

alter table public.orders enable row level security;

create policy "Un utilisateur voit ses propres commandes"
  on public.orders for select
  using (auth.uid() = user_id);

create policy "Un utilisateur crée ses propres commandes"
  on public.orders for insert
  with check (auth.uid() = user_id);

-- Note : la mise à jour du statut ("Reçue" → "En fabrication" → "Expédiée")
-- se fait manuellement par vous, depuis Supabase → Table Editor → orders,
-- en changeant la colonne "status" de la commande concernée.
