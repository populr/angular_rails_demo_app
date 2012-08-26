angular_rails_demo_app
======================




To incorporate AngularJS into your own Rails app
================================================


Include the Jasmine gems in your gemfile

    group :test, :development do
      gem 'jasmine'
      gem 'jasminerice'
      gem 'guard-jasmine'
    end

And

    $ bundle
    $ rails g jasmine:install

This creates a couple files, including spec/javascripts/spec.js.coffee. Change that file to look like this:

    #= require jquery
    #= require angular-main
    #= require angular-resource
    #= require_tree ./


Include the AngularJS files:

Visit [http://code.angularjs.org/](http://code.angularjs.org/) and choose a release. From the release page, copy the urls to the files you need and curl them into the appropriate directories. For example, for release 1.0.1:

    $ curl http://code.angularjs.org/1.0.1/angular-1.0.1.js > vendor/assets/javascripts/angular-main.js
    $ curl http://code.angularjs.org/1.0.1/angular-resource-1.0.1.js > vendor/assets/javascripts/angular-resource.js
    $ curl http://code.angularjs.org/1.0.1/angular-mocks-1.0.1.js > spec/javascripts/helpers/angular-mocks.js

Then add angular.js and angular-resource.js to the asset pipeline. For example, in config/environments/production.rb:

    config.assets.precompile += %w( angular.js )

And in app/assets/javascripts/, create a file angular.js:

    //= require angular-main
    //= require angular-resource

One could include angualr-main and angular-resource in application.js instead, but in an app with multiple, distinct Angular apps, I like to keep them completely distinct, and including a separate angular.js file in the asset pipeline means that AngularJS need only be downloaded once.
