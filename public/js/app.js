function Streamer(id, name, created_at, updated_at) {
  var self = this;
  self.id = id;
  self.name = ko.observable(name);
  self.created_at = created_at;
  self.updated_at = ko.observable(updated_at);
}

function StreamerViewModel() {
  var self = this;

  self.streamers = ko.observableArray([]);

  self.createOrUpdateStreamer = function(json) {
    var streamer = ko.utils.arrayFirst(self.streamers(), function(current) {
      return current.id == json.id;
    });
    if (streamer) {
      streamer.name(json.name);
      streamer.updated_at(json.updated_at);
    } else {
      self.streamers.push(new Streamer(json.id, json.name, json.created_at, json.updated_at));
    }
  }
}

ko.bindingHandlers.flashUpdate = {
  update: function(element) {
    $(element).animate({"color":"#FF6170"}, 200, "swing", function() {
      $(element).animate({"color":"#CCC"}, 300);
    });
  }
}

var SVM = new StreamerViewModel();
ko.applyBindings(SVM);

var socket = new WebSocket("ws://127.0.0.1:8181")

socket.onmessage = function (event) {
  SVM.createOrUpdateStreamer(ko.utils.parseJson(event.data));
};
