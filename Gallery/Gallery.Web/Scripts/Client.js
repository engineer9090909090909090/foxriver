// created by blue, 2010-5-4
// it sucks today.
var $table;
$(document).ready(function() {
    $table = $('#ClientTable');
    Page_Load();
});
function Page_Load() {
    var $sel = $('#selGalleries');
//    alert(gList.length);
    for (var i = 0; i < gList.length; ++i) {
        //        alert(i);
//        alert(gList[i].text);
        //$sel.prepend("<option value='" + gList[i].id + "'>" + gList[i].text + "</option>");
            //.text(gList[i].text)
        //.appendTo($sel);
        $("<option value='" + gList[i].id + "'>" + gList[i].text + "</option>").appendTo($sel);
    }
    for ( var i = 0; i < clients.length; ++i ) {
        AddRow(clients[i]);
    }
}

function AddRow(client) {
    var newRow = $('#TEMP').clone(true)
        .appendTo($table)
        .show();
    var rowObj = GetRowObj(newRow);
    newRow.attr('cid', client.id);
    
    rowObj.$firstName.text(client.firstName);
    rowObj.$lastName.text(client.lastName);
    rowObj.$password.attr('value', client.password);
    rowObj.$email.text(client.email);
    
    var links = $('a', newRow);
    // set password
    $(links[0]).click(SetPassword);
    
    // send mail
    $(links[1]).click(Send);
}

function GetRowObj( $row) {
    var obj = {};
    $.extend(obj, {'$row': $row});
    $.extend(obj, {'$firstName': $('.first_name', $row) });
    $.extend(obj, {'$lastName': $('.last_name', $row)});
    $.extend(obj, {'$email': $('.client_email', $row)});
    $.extend(obj, {'$send': $('.send', $row)});
    $.extend(obj, {'$password':$('input', $row)});
    
    return obj;
}

function SetPassword(e) {
    if (! confirm("Set password for the client now?")) {
        return;
    }
    var rowObj = FindRowObj( $(e.target));
    var clientId = rowObj.$row.attr('cid')
    var pwd = rowObj.$password.attr('value');
    _postJSON({'method':'SetClientPassword'},
        {'id': clientId, 'password': pwd},
        function(data) {
            if (data.msgId == 0 ) {
                alert("Set OK!");
            }
    });
}

function Send(e) {
    if ( !confirm("Send mail to client now?")) {
        return;
    }
    alert("Send OK!");
}

function FindRowObj($link) {
    var $r = $link.parents('.row');
    return GetRowObj($r);
}
