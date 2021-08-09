module.exports = {
    proxy: "localhost:8080",
    files: ["**/*.css", "**/*.pug", "**/*.js"],
    ignore: ["node_modules"],
    reloadDelay: 10,
    ui: true,
    notify: false,
    port: 8080,
  };
