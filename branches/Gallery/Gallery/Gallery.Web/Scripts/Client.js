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
    rowObj.$sel[0].value = client.galleryId;
    
    var links = $('a', newRow);
    // set password
    $(links[0]).click(SetPassword);
    
    // remove
    //$(links[1]).click(Send);
    
    // Remove password
    $(links[1]).click(Remove);
    
    //del
    $(links[2]).click(Del);
}

function GetRowObj( $row) {
    var obj = {};
    $.extend(obj, {'$row': $row});
    $.extend(obj, {'$firstName': $('.first_name', $row) });
    $.extend(obj, {'$lastName': $('.last_name', $row)});
    $.extend(obj, {'$email': $('.client_email', $row)});
    //$.extend(obj, {'$send': $('.send', $row)});
    $.extend(obj, {'$password':$('input', $row)});
    $.extend(obj, {'$sel': $('select', $row)});
    
    return obj;
}

function SetPassword(e) {
    var rowObj = FindRowObj( $(e.target));
    if ( rowObj.$sel[0].value == '-1') {
        alert("Please select a gallery for this client");
        return;
    }
    
    if ($.trim(rowObj.$password.attr('value')).length == 0 ) {
        alert("Please enter password for this client");
        return;
    }
    if (! confirm("Set password for the client now?")) {
        return;
    }
    
    var clientId = rowObj.$row.attr('cid')
    var pwd = rowObj.$password.attr('value');
    _postJSON({'method':'SetClientPassword'},
        {'id': clientId, 'password': pwd,'galleryId': rowObj.$sel[0].value },
        function(data) {
            if (data.msgId == 0 ) {
                alert("Set OK!");
            } else {
                alert(data.message);
            }
    });
}

function Del(e) {
    if (! confirm("Delete this client?")) {
        return;
    }
    var rowObj = FindRowObj( $(e.target));
    var clientId = rowObj.$row.attr('cid');
    //alert(clientId);
    _postJSON({'method':'DeleteClient'}, {'clientId': clientId}, function (data) {
        if ( data.msgId == 0 ) {
            rowObj.$row.remove();
        } else {
            alert(data.message);
        }
    });
}

function Send(e) {
    if ( !confirm("Send mail to client now?")) {
        return;
    }
    alert("Send OK!");
}

function Remove(e) {
    var rowObj = FindRowObj( $(e.target));
    var clientId = rowObj.$row.attr('cid')
    if ( !confirm("Remove password?")) {
        return;
    }
    //alert("Send OK!");
    
    _postJSON({'method':'RemovePassword'}, 
        {'id':clientId}, function(data) {
            if ( data.msgId == 0 ) {
                rowObj.$sel[0].value = -1;
                rowObj.$password.attr('value', '');
                alert("Removed OK!");
            }
        });
}

function FindRowObj($link) {
    var $r = $link.parents('.row');
    return GetRowObj($r);
}
