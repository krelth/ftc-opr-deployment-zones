var helpers = function () {};

helpers.register = function (Handlebars) {
    Handlebars.registerHelper('include', function (path) {
        var partial = Handlebars.partials[path];
        if (typeof partial !== 'function') {
            partial = Handlebars.compile(partial);
        }
        var context = {};
        var text = partial(context);
        if (path != 'ui') text = text.replace(/\\/gm, '\\\\');
        text = text.replace(/(\r\n|\n|\r)/gm, '\\n');
        text = text.replace(/\"/gm, '\\"');
        return new Handlebars.SafeString(text);
    });
};

module.exports = helpers;
