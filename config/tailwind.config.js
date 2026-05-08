const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['"Space Grotesk"', ...defaultTheme.fontFamily.sans],
        mono: ['"JetBrains Mono"', ...defaultTheme.fontFamily.mono],
      },
      colors: {
        ck: {
          bg:        '#FFFDF5',
          card:      '#FFFFFF',
          raised:    '#FFD93D',
          ink:       '#000000',
          accent:    '#FF6B6B',
          secondary: '#FFD93D',
          muted:     '#C4B5FD',
        }
      },
      boxShadow: {
        'neo-sm': '4px 4px 0 0 #000',
        'neo': '8px 8px 0 0 #000',
        'neo-lg': '12px 12px 0 0 #000',
        'neo-xl': '16px 16px 0 0 #000',
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
