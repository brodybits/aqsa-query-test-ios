function TestObjectCB(a1, a2) {
    document.getElementById('t1').innerHTML="got mycb<br/>arg1: " + a1 + "<br/>arg2: " + a2;
}

var r = TestObject.query("test-string-1", "test-string-2");
document.getElementById('r1').innerHTML="got res: " + r;

var w = new Worker('mytask.js');
AQ.aqworker('cbh1', w);
w.addEventListener('message', function(ev) {
  document.getElementById('res').innerHTML=ev.data;
});

w.postMessage('go');
