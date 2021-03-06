// Generated by CoffeeScript 1.7.1
(function() {
  var AbstractService, GetAgencies,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  AbstractService = require('./AbstractService');

  GetAgencies = (function(_super) {
    __extends(GetAgencies, _super);

    function GetAgencies() {
      return GetAgencies.__super__.constructor.apply(this, arguments);
    }

    GetAgencies.prototype._parse = function(obj) {
      var agencies, _A, _i, _len, _ref, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7, _ref8, _ref9;
      agencies = {};
      _ref4 = (_ref = obj != null ? (_ref1 = obj.RTT) != null ? (_ref2 = _ref1.AgencyList) != null ? (_ref3 = _ref2[0]) != null ? _ref3.Agency : void 0 : void 0 : void 0 : void 0) != null ? _ref : [];
      for (_i = 0, _len = _ref4.length; _i < _len; _i++) {
        _A = _ref4[_i];
        if ((_A != null ? (_ref5 = _A['$']) != null ? _ref5.Name : void 0 : void 0)) {
          agencies[_A != null ? (_ref6 = _A['$']) != null ? _ref6.Name : void 0 : void 0] = {
            HasDirection: 'True' === (_A != null ? (_ref7 = _A['$']) != null ? _ref7.HasDirection : void 0 : void 0),
            Mode: (_ref8 = _A != null ? (_ref9 = _A['$']) != null ? _ref9.Mode : void 0 : void 0) != null ? _ref8 : null
          };
        }
      }
      return agencies;
    };

    return GetAgencies;

  })(AbstractService);

  module.exports = GetAgencies;

}).call(this);
