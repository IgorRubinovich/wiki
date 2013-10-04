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
    //auth: function(client, action) {
    //	action.allow();
    //}
}
