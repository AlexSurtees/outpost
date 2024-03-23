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
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
        header: ['trocchi', 'serif'],
        paragraph: ['Helvetica Neue', 'serif']
      },
      colors: {
        'paragraph': '#3F3F46',
        'sub-heading': '#52525B',
        'header': '#ebf0f6',
        'navigation': '#F1F7E7',
        'background-main': '#FAF9F6', //'#F8FAE5',
        'background-secondary': '#43766C',
        'background-secondary-dark': '#325851',
        'highlight': '#9DBC98'
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
