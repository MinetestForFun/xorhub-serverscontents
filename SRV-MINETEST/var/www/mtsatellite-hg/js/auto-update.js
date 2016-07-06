L.Control.AutoUpdate = L.Control.extend({
    options: {
        position: 'topleft',
        label: 'Automatic update',
        layer: undefined
    },
    pressed: true,

    onAdd: function() {
        var container = L.DomUtil.create('div', 'leaflet-bar leaflet-control');
        this.link = L.DomUtil.create('a', 'leaflet-bar-part', container);
        this.iconStart = L.DomUtil.create('i', 'fa fa-play', this.link);
        this.link.href = '#';
        L.DomEvent.on(this.link, 'click', this.cbClick, this);
        return container;
    },

    switchButtons: function() {
        if (this.pressed) {
            this.pressed = false;
            this.iconStart.setAttribute('class', 'fa fa-pause');
            this.autoUpdate();
        } else {
            this.pressed = true;
            this.iconStart.setAttribute('class', 'fa fa-play');
            this.stopUpdate();
        }
    },

    cbClick: function (e) {
        L.DomEvent.stopPropagation(e);
        this.intendedFunction(this.pressed);
        this.switchButtons();
    },

    intendedFunction: function() {
        alert('no function selected');
    },

    stopUpdate: function() {
        if (this.socket) {
            var s = this.socket;
            this.socket = null;
            s.close();
        }
    },

    autoUpdate: function() {
        var me = this;
        this.socket = new WebSocket('ws://' + window.location.host + '/ws');

        this.socket.onerror = function(evt) {
            me.stopUpdate();
            me.switchButtons();
        };

        this.socket.onclose = function(evt) {
            this.socket = null;
        }

        this.socket.onopen = function(evt) {
            // Sending pings every 5 secs to keep connection alive.
            var heartbeat = function() {
                if (heartbeat && me.socket) {
                    me.socket.send("PING");
                    setTimeout(heartbeat, 8000);
                } else {
                    // Prevent sending pings to re-opened sockets.
                    heartbeat = null;
                }
            };
            setTimeout(heartbeat, 8000);
        };

        this.socket.onmessage = function(evt) {

            var json = evt.data;
            if (!(typeof json === "string")) {
                return;
            }

            var msg;
            try {
                msg = JSON.parse(json);
            }
            catch (err) {
                return;
            }

            if (msg.players) {
                me.options.layer.clearLayers();
                me.options.layer.addData(msg.players);
            }

            var tilesData = msg.tiles;
            if (!tilesData) {
                return;
            }

            var invalidate = function(td) {

                var pyramid = new Array(9);
                var last = new Object();
                pyramid[8] = last;

                for (var i = 0; i < td.length; i++) {
                    var xz = td[i];
                    last[xz.X + "#" + xz.Z] = xz;
                }
                for (var p = 7; p >= 0; p--) {
                    var prev = pyramid[p+1];
                    var curr = new Object();
                    pyramid[p] = curr;
                    for (var k in prev) {
                        if (prev.hasOwnProperty(k)) {
                            var oxz = prev[k];
                            var nxz = { X: oxz.X >> 1, Z: oxz.Z >> 1 };
                            curr[nxz.X + "#" + nxz.Z] = nxz;
                        }
                    }
                }
                return function(x, y, z) {
                    if (y > 8) {
                        x >>= y - 8;
                        z >>= y - 8;
                        y = 8;
                    }
                    var level = pyramid[y];
                    var k = x + "#" + z;
                    return level.hasOwnProperty(k);
                };
            } (tilesData);


            var tiles = document.getElementsByTagName('img');
            var re = /\/map\/([0-9]+)\/([0-9]+)\/([0-9]+).*/;
            for (var i = 0; i < tiles.length; i++) {
                var img = tiles[i];
                var cl = img.getAttribute('class');
                if (cl.indexOf('leaflet-tile-loaded') < 0) {
                    continue;
                }
                var src = img.src;
                var coord = src.match(re);
                if (coord == null) {
                    continue;
                }
                var y = parseInt(coord[1]);
                var x = parseInt(coord[2]);
                var z = parseInt(coord[3]);
                if (invalidate(x, y, z)) {
                    var idx = src.lastIndexOf('#');
                    if (idx >= 0) {
                        src = src.substring(0, idx);
                    }
                    img.src = src + '#' + Math.random();
                }
            }
        };
    }
});

L.autoUpdate = function(cbLabel, cbFunc, layer, cbMap) {
    var control = new L.Control.AutoUpdate();
    if (cbLabel) {
        control.options.label = cbLabel;
    }

    if (cbFunc) {
        control.intendedFunction = cbFunc;
    }

    if (layer) {
        control.options.layer = layer;
    }

    if (cbMap === '') {
        return control;
    }
    else if (cbMap) {
        cbMap.addControl(control);
    }
    else {
        map.addControl(control);
    }
    return control;
};
