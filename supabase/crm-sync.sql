-- Données partagées du CRM (synchronisées entre appareils).
-- À exécuter une fois dans le SQL Editor du projet hmsiombfrtwnexrixwnd.

create table if not exists public.crm_entreprises (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);
alter table public.crm_entreprises enable row level security;
drop policy if exists "Martin accède aux données CRM" on public.crm_entreprises;
create policy "Martin accède aux données CRM"
  on public.crm_entreprises for all
  to authenticated
  using (auth.email() = 'maxiscomfr@gmail.com')
  with check (auth.email() = 'maxiscomfr@gmail.com');

create table if not exists public.crm_contacts (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);
alter table public.crm_contacts enable row level security;
drop policy if exists "Martin accède aux données CRM" on public.crm_contacts;
create policy "Martin accède aux données CRM"
  on public.crm_contacts for all
  to authenticated
  using (auth.email() = 'maxiscomfr@gmail.com')
  with check (auth.email() = 'maxiscomfr@gmail.com');

create table if not exists public.crm_activites (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);
alter table public.crm_activites enable row level security;
drop policy if exists "Martin accède aux données CRM" on public.crm_activites;
create policy "Martin accède aux données CRM"
  on public.crm_activites for all
  to authenticated
  using (auth.email() = 'maxiscomfr@gmail.com')
  with check (auth.email() = 'maxiscomfr@gmail.com');

create table if not exists public.crm_affaires (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);
alter table public.crm_affaires enable row level security;
drop policy if exists "Martin accède aux données CRM" on public.crm_affaires;
create policy "Martin accède aux données CRM"
  on public.crm_affaires for all
  to authenticated
  using (auth.email() = 'maxiscomfr@gmail.com')
  with check (auth.email() = 'maxiscomfr@gmail.com');

create table if not exists public.crm_factures (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);
alter table public.crm_factures enable row level security;
drop policy if exists "Martin accède aux données CRM" on public.crm_factures;
create policy "Martin accède aux données CRM"
  on public.crm_factures for all
  to authenticated
  using (auth.email() = 'maxiscomfr@gmail.com')
  with check (auth.email() = 'maxiscomfr@gmail.com');

create table if not exists public.crm_documents (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);
alter table public.crm_documents enable row level security;
drop policy if exists "Martin accède aux données CRM" on public.crm_documents;
create policy "Martin accède aux données CRM"
  on public.crm_documents for all
  to authenticated
  using (auth.email() = 'maxiscomfr@gmail.com')
  with check (auth.email() = 'maxiscomfr@gmail.com');

create table if not exists public.crm_reglages (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);
alter table public.crm_reglages enable row level security;
drop policy if exists "Martin accède aux données CRM" on public.crm_reglages;
create policy "Martin accède aux données CRM"
  on public.crm_reglages for all
  to authenticated
  using (auth.email() = 'maxiscomfr@gmail.com')
  with check (auth.email() = 'maxiscomfr@gmail.com');

-- Fichiers joints (documents) : bucket privé, accès réservé à Martin.
insert into storage.buckets (id, name, public) values ('crm-files', 'crm-files', false)
  on conflict (id) do nothing;

drop policy if exists "Martin gère les fichiers CRM" on storage.objects;
create policy "Martin gère les fichiers CRM"
  on storage.objects for all
  to authenticated
  using (bucket_id = 'crm-files' and auth.email() = 'maxiscomfr@gmail.com')
  with check (bucket_id = 'crm-files' and auth.email() = 'maxiscomfr@gmail.com');
