// Demyx
// https://demyx.sh

const demyxBS = {
  browserSync: {
    open: false,
    ui: false,
    rewriteRules:[{
      match: /domain.tld/g,
      fn: function (e,r,t) {
        return 'domain.tld/demyx/bs'
      }
    }],
    scriptPath: function (path) {
      return '/demyx/bs' + path;
    },
    socket: {
      domain: 'domain.tld'
    }
  },
};
