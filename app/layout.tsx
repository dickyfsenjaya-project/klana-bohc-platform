import type { ReactNode } from 'react';
import './globals.css';
export const metadata = { title: 'KlanA BOHC', description: 'Business & Organization Health Check' };
export default function RootLayout({children}:{children:ReactNode}) { return <html lang="id"><body>{children}</body></html> }
