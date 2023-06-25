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
    extend: {},
  },
  plugins: [
    // require('tw-elements/dist/plugin'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms')
  ]
}
