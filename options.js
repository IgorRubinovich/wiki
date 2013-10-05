var cookie = require('cookie');

// ShareJS options
module.exports = {
    // Port to listen on
    port: 8000,

    // Database options
    db: {
        type: 'mysql',
        database: 'pragmatiki_cmpip_wiki',
        host: 'mysql.alwaysdata.com',
        user: 'pragmatiki',
        password: 'pragmatiki33',
        schema: ''
    },

    // The server will statically host webclient/ directory at /share/*.
    // (Eg, the web client can be found at /share/share.js).
    // Set staticpath: null to disable.
    staticpath: '/share',

    // REST frontend options. Set rest: null to disable REST frontend.
    rest: {
    },

    // SocketIO frontend options. Set socketio: null to disable socketIO frontend.
    socketio: {
        // Specify tuples for io.configure:
        // 'transports': ['xhr-polling', 'flashsocket']
    },

    // Browserchannel server options. Set browserChannel:null to disable browserchannel.
    browserChannel: {},

    // Authentication code to test if clients are allowed to perform different actions.
    // See documentation for details.
    auth: function(client, action) {
        var header = client.headers["cookie"];
        if (!header) {
            action.reject();
            return;
        }

        var cookies = cookie.parse(header);
        if (!cookies) {
            action.reject();
            return;
        }

        var wp_cookie = cookies['wordpress_ae900921635efaeb4fb81dcc09a4fdf4'];
        if (!wp_cookie) {
            action.reject();
            return;
        }

        var wp_cookie_parts = wp_cookie.split('|');
        if (!wp_cookie_parts[0]) {
            action.reject();
            return;
        }

        client.name = wp_cookie_parts[0];

        action.accept();
    }
}
