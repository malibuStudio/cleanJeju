Package.describe({
  name: 'teammalibu:malibu-style',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: '',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.2.1');
  api.use('less');
  // api.use('flemay:less-autoprefixer@1.2.0');
  api.addFiles([
    'dist/malibu.less',
    'dist/global/normalize.import.less',
    'dist/global/fonts.import.less',
    'dist/global/body.import.less',
    'dist/global/reset.import.less',
    'dist/global/variables.import.less',
    'dist/global/mixins.import.less',
    'dist/global/malibu.import.less',

    'dist/site/typography.import.less',

    'dist/structure/structure.import.less',

    'dist/components/buttons/buttons.import.less',
    'dist/components/buttons/buttons-mixin.import.less',
    'dist/components/tags/tags.import.less',
    'dist/components/modals/modals.import.less',
    'dist/components/feedback/feedback.import.less',
    'dist/components/loader/fullpage-loader.import.less'
  ], 'client');
});

// Package.onTest(function(api) {
//   api.use('ecmascript');
//   api.use('tinytest');
//   api.use('teammalibu:malibu');
//   api.addFiles('malibu-tests.js');
// });

