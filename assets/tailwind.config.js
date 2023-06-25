module.exports = {
  mode: "jit",
  content: [
    './js/**/*.js',
    './css/**/*.css',
    '../lib/*_web.ex',
    '../lib/*_web/**/*.*ex',
    '../lib/*_web/**/*.sface',
    '../priv/catalogue/**/*.{ex,sface}',
  ],
  theme: {
    extend:     {
      fontFamily: {
        'indie': ['Indie Flower', 'cursive'],
        'amatic': ['Amatic SC', 'cursive']
      },
    },
  },
  plugins: [
    // require('tw-elements/dist/plugin'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms')
  ]
}
