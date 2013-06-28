
//function notificationCheck(id) {
//    WebService.setNotificationAsRead('B2B6D6D5-DCC1-4006-ABAE-8EFDE48B77F6', id);
//}

var tasks = {
    pid: 0,
    init: function () {
        WebService.GetTaskData(this.pid, this.success, this.failure);
        //$('.dismiss').bind('click', this.hide);
    },
    success: function (result) {
        var c = eval(result.d);
        console.log(result);
        for (var i in c) {
            console.log(c[i][0]);
            $("#resultstable tr:last").after("<tr><td>" + c[i][0] + "</td><td>" + c[i][1] + "</td><td>" + c[i][2] + "</td></tr>");
        }
    },
    failure: function (error) {
        alert(error.get_message());
    },
    hide: function () {
        $(this).parent().fadeOut();
        notificationCheck($(this).attr("rel"));
        return false;
    }
}
tasks.init();