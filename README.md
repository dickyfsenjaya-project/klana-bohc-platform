# KlanA BOHC Platform

Fondasi aplikasi Next.js untuk Business & Organization Health Check KlanA.

## Menjalankan lokal

1. `npm install`
2. `cp .env.example .env.local` lalu isi URL dan publishable key Supabase ketika project tersedia.
3. `npm run dev`

## Status

- Halaman dashboard preview: tersedia.
- Integrasi Supabase: menunggu project yang bisa diakses.
- Autentikasi, RLS, data klien, scoring, evidence dan report: belum diimplementasikan.
- **Jangan gunakan untuk data klien sungguhan sebelum autentikasi dan RLS teruji.**

## Aturan BOHC

8 dimensi, 24 subdimensi, 72 item. Skor kematangan 1–5 dipetakan ke 20–100. Hasil persepsi responden dan skor assessor berbasis bukti disimpan terpisah.
