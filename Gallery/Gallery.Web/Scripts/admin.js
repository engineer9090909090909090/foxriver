// Create by blue, 2010-4-22
var _IsRequesting = false;
var admin = {
    MangeItems : [{'text':'Update Password','img':'user.gif', 'controlId':'passwordManagement'},
    {'text':'gallery management','img':'user.gif', 'controlId':'galleryManagement'}],
    
    CurrentControl : 'Login'
}

$(document).ready(function(){
    var left = 20;
    var top = 20;
    var $menuContainer = $('#menu_container');
    for ( var i = 0; i < admin.MangeItems.length; ++i ) {
        var item = admin.MangeItems[i];
        var $div = $("<div style='width:64px;'></div>").appendTo($menuContainer);
        var $a = $("<a href='javascript:void(0);'></a>")
            .appendTo($div)
            .data('controlId', item.controlId)
            .click(function(e){
                //alert(e.target.tagName);
                var a = e.target;
                if ( a.tagName.toLowerCase != 'a') {
                    a = $(e.target).parents("a");
                }
                
                Swamp( $('#' + admin.CurrentControl), $('#' + a.data('controlId')));
            });
        $("<img src='images\\" + item.img + "'>").appendTo($a);
        $("<div></div>").text(item.text).appendTo($a);
       
       $("<div style='width:20px;height:10px;overflow:hidden'></div>").appendTo($menuContainer);
    }
    
    $('#Login').css({'display':'block'});
});

function Login() {
    var input = $('input', $('#Login'));
    var para = {};
    $.extend(para, {'name': $(input[0]).attr('value')});
    $.extend(para, {'password':$(input[1]).attr('value')});
    
    _postJSON({'method':'Login'}, para, function (data){
        Swamp($('#Login'), $('#passwordManagement'));
    });
    
}

function Swamp($1, $2) {
    if ( $1) {
        $1.fadeOut('fast', function () {
            $2.fadeIn('fast');
        });
     } else {
        $2.fadeIn('fast');
     }
     admin.CurrentControl = $2[0].id;
}

function getPostUrl() {
    var u = document.location.href;
    if ( u.indexOf("?") <0 ) {
        return u;
    }
    
    return u.substr(0, u.indexOf("?"));
}
function _postJSON  ( queryData, postData, callback, errorCallback) {
    if ( _IsRequesting) {
        alert("Please wait for the current operation's finish");
        return;
    }
    _IsRequesting = true;
    var url = getPostUrl();
    
    url +='?nothing=' +encodeURI((new Date()).toString());
    $.extend(queryData,{'ajax':'1'});
    for (var q in queryData) {
        url += "&" + q + "=" + encodeURI(queryData[q]);
    }
    
    /*
    //alert(url);
    //alert(postData);
    $.ajax({'url':url,
        'type':'post',
        'dataType':'json',
        'data': postData,
        'error' : function(result){
            //var o = eval( result.responseText );
            //alert(result.statusText);
//            alert(o.msgId);
            for ( p in result ) {
                alert(p + "->" +result[p]);
            }
        },
        'success': function(result){alert(result);}
    });
    return;
    */
    $.post(url, postData, function(data) {
        _IsRequesting = false;
        if (data.msgId && data.msgId < 0) {
            if ( data.msgId == -1000) {
                alert("Session expired!");
                return;
            }
        
            // get error from server!
            if ( errorCallback && typeof errorCallback === 'function') {
                errorCallback(data);
            } else {
                alert(data.message);
            }

        } else {
            if (callback && typeof callback == 'function') {
                callback(data);
            }
        }
    }, "json");
};