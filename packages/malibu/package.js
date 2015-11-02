Package.describe({
  name: 'teammalibu:malibu',
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
  api.addFiles('malibu.js');
  api.addFiles([
      'malibu/malibu.less'
    ], 'client');
});

// Package.onTest(function(api) {
//   api.use('ecmascript');
//   api.use('tinytest');
//   api.use('teammalibu:malibu');
//   api.addFiles('malibu-tests.js');
// });

