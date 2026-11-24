/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        charcoal: '#1F2937',
        gold: '#D4A017',
        ink: '#111827',
        cream: '#F8F5ED',
      },
      boxShadow: {
        soft: '0 18px 50px rgba(17, 24, 39, 0.16)',
      },
    },
  },
  plugins: [],
}
