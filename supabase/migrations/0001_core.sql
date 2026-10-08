-- Initial BOHC schema. Apply only after Supabase project is provisioned.
create extension if not exists pgcrypto;
create table public.organizations(id uuid primary key default gen_random_uuid(),name text not null,industry text,employee_count integer,created_at timestamptz not null default now());
create table public.profiles(id uuid primary key references auth.users(id) on delete cascade,full_name text,role text not null default 'assessor' check(role in ('super_admin','assessor','client_admin')),organization_id uuid references public.organizations(id));
create table public.assessment_projects(id uuid primary key default gen_random_uuid(),organization_id uuid not null references public.organizations(id),title text not null,status text not null default 'draft',lead_assessor_id uuid references public.profiles(id),created_at timestamptz not null default now());
create table public.assessment_dimensions(id uuid primary key default gen_random_uuid(),code text unique not null,name text not null,sort_order integer not null);
create table public.assessment_subdimensions(id uuid primary key default gen_random_uuid(),dimension_id uuid not null references public.assessment_dimensions(id),code text unique not null,name text not null,sort_order integer not null);
create table public.assessment_items(id uuid primary key default gen_random_uuid(),subdimension_id uuid not null references public.assessment_subdimensions(id),code text unique not null,statement text not null,active boolean not null default true);
create table public.assessment_scores(id uuid primary key default gen_random_uuid(),project_id uuid not null references public.assessment_projects(id),item_id uuid not null references public.assessment_items(id),maturity integer check(maturity between 1 and 5),evidence_note text,assessor_note text,confidence text check(confidence in ('high','medium','low')),importance integer check(importance between 1 and 3),urgency integer check(urgency between 1 and 3),updated_by uuid references public.profiles(id),unique(project_id,item_id));
create table public.evidence_requests(id uuid primary key default gen_random_uuid(),project_id uuid not null references public.assessment_projects(id),title text not null,status text not null default 'requested',notes text,file_path text);
create table public.action_plans(id uuid primary key default gen_random_uuid(),project_id uuid not null references public.assessment_projects(id),issue text not null,root_cause text,recommended_action text,owner_name text,status text not null default 'planned');
-- Fail closed: no browser roles may read or write until scoped policies are implemented and tested.
alter table public.organizations enable row level security;
alter table public.profiles enable row level security;
alter table public.assessment_projects enable row level security;
alter table public.assessment_dimensions enable row level security;
alter table public.assessment_subdimensions enable row level security;
alter table public.assessment_items enable row level security;
alter table public.assessment_scores enable row level security;
alter table public.evidence_requests enable row level security;
alter table public.action_plans enable row level security;
