node-511
========

Lightweight node.js wrapper for the 511.org real time driving times and transit departure APIs. The module provides the data in a form that is easily manipulated.

To get started, simply install the module using npm:

    npm install node-511

and then require it:

    var Client = require('node-511');

#Classes

There is a single useful class called `Client` that provides access to this module's capabilities.

##Client

This class is the main interface for making requests of the 511.org APIs and asynchronously receiving the response.

###new Client(options)

* options `Object` An object containing options for the API client

Creates a new API `Client` object with the specified options.

Options:

* token `String` API token as provided by 511.org

For example:

    var Client = require('node-511');
    var client = new Client({token: '11111111-2222-3333-4444-5555555555555555'});

This client is the object upon which to invoke the API methods.
