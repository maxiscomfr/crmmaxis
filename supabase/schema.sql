-- Demandes issues du site MAXIS.com, lues par le CRM.
-- À exécuter une fois dans le SQL Editor du projet hmsiombfrtwnexrixwnd.

create table if not exists public.demandes (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  nom text not null,
  email text not null,
  telephone text,
  entreprise text,
  message text,
  source text not null default 'Site web',
  statut text not null default 'Nouvelle',
  entreprise_crm_id text,
  traitee_le timestamptz
);

alter table public.demandes enable row level security;

-- Aucune policy pour anon : un visiteur ne peut ni lire ni écrire.
-- Le site écrit avec la clé secrète (côté serveur uniquement), qui contourne RLS.

-- Seul Martin, connecté avec son email, lit et met à jour les demandes.
create policy "Martin lit les demandes"
  on public.demandes for select
  to authenticated
  using (auth.email() = 'maxiscomfr@gmail.com');

create policy "Martin met à jour les demandes"
  on public.demandes for update
  to authenticated
  using (auth.email() = 'maxiscomfr@gmail.com')
  with check (auth.email() = 'maxiscomfr@gmail.com');

create index if not exists demandes_created_at_idx on public.demandes (created_at desc);
