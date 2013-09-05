<%@ Page Title="" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="tasks.aspx.vb" Inherits="tasks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<div id="query_results">

</div>

<script type="text/javascript">
    $(document).ready(function () {
        // init
        getTaskData(0);

        $(".task").live("click", function () {
            getTaskData($(this).attr("rel"));
            return false;
        });
    });

    function getTaskData(pid) {
        $("#query_results").empty();
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "WebService.asmx/GetTaskData",
            data: "{pid:" + pid + "}",
            dataType: "json",
            success: function (msg) {
                var c = eval(msg.d);
                var i = 0;

                // check for parent
                if (c[0].length !== 0) {
                    if (pid !== 0) {
                        $("#query_results").append('<h3><a href="get_task.aspx?id=' + c[1][2] + '" class="task" rel="' + c[1][2] + '">back to parent</a></h3>');
                    }

                    $("#query_results").append('<ul/>');

                    for (i = 0; i <= c.length - 2; i++) {
                        $("#query_results").find("ul").append('<li><a href="get_task.aspx?id=' + c[i][0] + '" rel="' + c[i][0] + '" class="task">' + c[i][1] + '</a></li>');
                    }
                }
            }
        });    
    }
</script>
</asp:Content>

