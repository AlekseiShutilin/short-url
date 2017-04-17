$(document).ready( function () {
    var entityFormHandler = new EntityFormHandler();
    entityFormHandler.initialize();
});

function EntityFormHandler() {
    var self = this;

    self.initialize = function () {
        $('#new_entity').on('ajax:success', function (e, data, status, xhr) {

        }).on('ajax:error', function (e, data, status, xhr) {
            var errors = JSON.parse(data.responseText);

            if(errors['url']) {
                self.renderUrlErrors(errors['url'])
            }

            if(errors['short_url']) {
                self.renderShortUrlErrors(errors['short_url'])
            }

            $('#new_entity').on('submit', function () {
                self.clearErrorsLists();
            })

        })
    };

    self.renderUrlErrors = function (errors) {
        var list = $('.url-errors-list');
        errors.forEach( function (error) {
            list.append( '<li class="error">' + error + '</li>' );
        })
    };

    self.renderShortUrlErrors = function (errors) {
        var list = $('.short-url-errors-list');
        errors.forEach( function (error) {
            errors.forEach( function (error) {
                list.append( '<li class="error">' + error + '</li>' );
            })
        })
    };

    self.clearErrorsLists = function () {
        $('.url-errors-list').empty();
        $('.short-url-errors-list').empty();
    }
}