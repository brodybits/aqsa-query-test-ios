var aqcbmap = {};

var aqbasecbprefix = '!!!';

var aqcbhandlername = null;

aqcbmap['!!!sethandlername'] = function(s) {
  aqcbhandlername = s;
};

self.addEventListener('message', function(ev) {
  if ((typeof ev.data === 'string' || ev.data instanceof String) &&
      ev.data.indexOf(aqbasecbprefix) != -1) {
    var components = ev.data.split('?');
    if (components.length < 2) return;

    if (!!aqcbmap[components[0]]) aqcbmap[components[0]](components[1]);
  }
});

function aqsend(handler, method, cbid, code, req) {
  var r = new XMLHttpRequest();
  // XXX TBD: should req be JSON & URL encoded here instead of by caller?
  r.open("POST", 'file:///aqaq#'+handler+':'+method+'$'+aqcbhandlername+'-'+cbid+'@'+code+'?'+req, true);
  r.send();
}
