$(document).ready(function () {
        var dirty = false;
        $(" form input, form select, form textarea").change(function () {

            dirty = true;
        });
        $(window).on('beforeunload', function (e) {
            if (dirty) {
                e.returnValue = "Hi ha canvis al formulari. Si continua els perdrà.";
                return "Hi ha canvis al formulari. Si continua els perdrà.";
            } else {
                e.returnValue = null;
            }
        });
        $('form').on('submit', function () {
            dirty = false;
        });
        $('form').on('reset', function () {
            dirty = false;
        });
    });