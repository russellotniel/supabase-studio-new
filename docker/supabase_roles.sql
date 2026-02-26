--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE anon;
ALTER ROLE anon WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE authenticated;
ALTER ROLE authenticated WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE authenticator;
ALTER ROLE authenticator WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:QTDuCmWVyWp3pABLtCs64A==$nMuUI/ekU7HQIHjMeSKOFVDn903HjBAxJHIwhRLRn48=:rDh/9do4xWy2tFygqvGj4eHECIxOY6WwBGHEOZYEDaA=';
CREATE ROLE dashboard_user;
ALTER ROLE dashboard_user WITH NOSUPERUSER INHERIT CREATEROLE CREATEDB NOLOGIN REPLICATION NOBYPASSRLS;
CREATE ROLE pgbouncer;
ALTER ROLE pgbouncer WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:LzyWkw6ZcRy6vP6r4OJN4w==$Q0oW6mUirgVmzFGDy+L/9L5446nR7L+l4bO+K1S6zzk=:aylCy2DIYmX4g5IeHmIC6VeLztXf0EdAvCGRf1BWtzA=';
CREATE ROLE postgres;
ALTER ROLE postgres WITH NOSUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:JX2D8rILR9V3GLEqS7LSGA==$e3wL0EKIuU1RUSzKcrVNLH5pjEdwQg8243ZuzjSwAJs=:9BkFTAhG93OvtNlfaaH6bq9i0xowHab0IQvDwjdKR6E=';
CREATE ROLE service_role;
ALTER ROLE service_role WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION BYPASSRLS;
CREATE ROLE supabase_admin;
ALTER ROLE supabase_admin WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:fSVN+NH9xM21JKHUP8o9dg==$c7pbnUi3AgPtNtXL71lOjMZ4ovAY/x+Sp8nV4fvvTMM=:a2fnm/aPFOL3NniYlV0/nrSbzvyHikX6KshokZWbTao=';
CREATE ROLE supabase_auth_admin;
ALTER ROLE supabase_auth_admin WITH NOSUPERUSER NOINHERIT CREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:kvo4nccIS85Lqii2xRW5Jw==$0hS9sezxXISeSEmwDvsS7YIdvr8bc7dxUCk1YGjWNgw=:oA26/hqsYfxG9s0KZ7od2EWx4HWCkjEgNZpr9K4q7rQ=';
CREATE ROLE supabase_functions_admin;
ALTER ROLE supabase_functions_admin WITH NOSUPERUSER NOINHERIT CREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:Q29wSfMdvF5ZpRCQL0Yt3g==$esz7ImbASL3LCkRHYlx3STUw6rBunsmg4vhcNWOUyG8=:qZK8AYnNk7oxG/kKsTzl7NQ6pq3CIrzk73q+g/4usCE=';
CREATE ROLE supabase_read_only_user;
ALTER ROLE supabase_read_only_user WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION BYPASSRLS;
CREATE ROLE supabase_realtime_admin;
ALTER ROLE supabase_realtime_admin WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE supabase_replication_admin;
ALTER ROLE supabase_replication_admin WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN REPLICATION NOBYPASSRLS;
CREATE ROLE supabase_storage_admin;
ALTER ROLE supabase_storage_admin WITH NOSUPERUSER NOINHERIT CREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:Ve1wPgTI6IZNj+Yc13CSzw==$QpsuRG9Tze3/Pur5YNaa33ZdztQ9n8D9h4JK+QpCoOc=:NzI1e5gLu31IcuoABhd/PCLzsPSRN8ka2mO+zEkjtY0=';

--
-- User Configurations
--

--
-- User Config "anon"
--

ALTER ROLE anon SET statement_timeout TO '3s';

--
-- User Config "authenticated"
--

ALTER ROLE authenticated SET statement_timeout TO '8s';

--
-- User Config "authenticator"
--

ALTER ROLE authenticator SET session_preload_libraries TO 'safeupdate';
ALTER ROLE authenticator SET statement_timeout TO '8s';
ALTER ROLE authenticator SET lock_timeout TO '8s';

--
-- User Config "postgres"
--

ALTER ROLE postgres SET search_path TO E'\\$user', 'public', 'extensions';

--
-- User Config "supabase_admin"
--

ALTER ROLE supabase_admin SET search_path TO E'\\$user', 'public', 'auth', 'extensions';
ALTER ROLE supabase_admin SET log_statement TO 'none';

--
-- User Config "supabase_auth_admin"
--

ALTER ROLE supabase_auth_admin SET search_path TO 'auth';
ALTER ROLE supabase_auth_admin SET idle_in_transaction_session_timeout TO '60000';
ALTER ROLE supabase_auth_admin SET log_statement TO 'none';

--
-- User Config "supabase_functions_admin"
--

ALTER ROLE supabase_functions_admin SET search_path TO 'supabase_functions';

--
-- User Config "supabase_storage_admin"
--

ALTER ROLE supabase_storage_admin SET search_path TO 'storage';
ALTER ROLE supabase_storage_admin SET log_statement TO 'none';


--
-- Role memberships
--

GRANT anon TO authenticator GRANTED BY postgres;
GRANT anon TO postgres GRANTED BY supabase_admin;
GRANT authenticated TO authenticator GRANTED BY postgres;
GRANT authenticated TO postgres GRANTED BY supabase_admin;
GRANT authenticator TO supabase_storage_admin GRANTED BY supabase_admin;
GRANT pg_monitor TO postgres GRANTED BY supabase_admin;
GRANT pg_read_all_data TO postgres GRANTED BY supabase_admin;
GRANT pg_read_all_data TO supabase_read_only_user GRANTED BY postgres;
GRANT pg_signal_backend TO postgres GRANTED BY supabase_admin;
GRANT service_role TO authenticator GRANTED BY postgres;
GRANT service_role TO postgres GRANTED BY supabase_admin;
GRANT supabase_functions_admin TO postgres GRANTED BY postgres;
GRANT supabase_realtime_admin TO postgres GRANTED BY supabase_admin;




--
-- PostgreSQL database cluster dump complete
--

