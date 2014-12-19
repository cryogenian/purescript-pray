var gulp = require("gulp"),
    purescript = require("gulp-purescript"),
    browserify = require("gulp-browserify"),
    watchify = require("watchify"),
    concat = require("gulp-concat");

var src = [
    "bower_components/purescript-*/src/**/*.purs",
    "src/**/*.purs"
];

var nodeModules = ["node_modules/**/*"];

gulp.task("deps-copy", function() {
    return gulp.src(nodeModules) 
        .pipe(gulp.dest('dist/node_modules'));
});

var onError = function(psc) {
    return function(e) {
        console.error('\u0007');
        console.error(e.message);
        psc.end();
    };
};

gulp.task('compile', function() {
    var psc = purescript.psc({
        output: "main.js",
        main: "Main",
        modules: ["Main"]
    });
    psc.on('error', onError(psc));
    gulp.src(src)
        .pipe(psc)
        .pipe(concat("main.js"))
        .pipe(gulp.dest("."));
});

gulp.task("bundle", function() {
    return gulp.src("main.js")
        .pipe(browserify({}))
        .pipe(gulp.dest("example"));
});



gulp.task("build", ["compile", "bundle"]);

gulp.task("dev", ["build"], function() {
    gulp.watch(src, ["build"]);
});
