importScripts('aqworker.js');

var mycbprefix = '!!!mycb.';

self.addEventListener('message', function(ev) {
  if (ev.data === 'go') {
    mycbid = mycbprefix + 1;
    aqcbmap[mycbid] = function(s) {
      self.postMessage('got data: ' + s);
      // no longer needed, prevent a possible leak:
      delete aqcbmap[mycbid];
    }

    aqsend('as', 'df', mycbid, 'a1', 'fs,d=wl%23&fw=%4238s@fda');
  }
});
