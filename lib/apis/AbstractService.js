// Generated by CoffeeScript 1.7.1
(function() {
  var AbstractService, request, xml2js,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  request = require('request');

  xml2js = require('xml2js');

  AbstractService = (function() {
    AbstractService.userAgent = "node-511 API wrapper for node.js - https://github.com/abstractvector/node-511";

    function AbstractService(url) {
      this.invoke = __bind(this.invoke, this);
      this.url = (function() {
        if (url != null) {
          return url;
        } else {
          throw new Error('No URL provided for endpoint');
        }
      })();
    }

    AbstractService.prototype.invoke = function(parameters, callback) {
      var self;
      if (parameters == null) {
        parameters = {};
      }
      if (callback == null) {
        callback = function() {};
      }
      self = this;
      return this._request(this.url, parameters, function(err, response, body) {
        if (err) {
          return callback(err);
        }
        return xml2js.parseString(body, function(err, result) {
          if (err) {
            return callback(err);
          }
          return callback(null, self._parse(result, body, response));
        });
      });
    };

    AbstractService.prototype._request = function(url, parameters, callback) {
      return request({
        url: url,
        qs: parameters,
        headers: {
          "User-Agent": this.userAgent
        }
      }, callback);
    };

    AbstractService.prototype._parse = function(obj) {
      return {};
    };

    return AbstractService;

  })();

  module.exports = AbstractService;

}).call(this);