// Create by blue, 2010-4-22
var _IsRequesting = false;

var _EnabledFileType = ['jpg', 'jpeg','gif','png'];
var admin = {
    MangeItems : [{'text':'Update Password','img':'user.gif', 'controlId':'passwordManagement'}
    ,{'text':'gallery management','img':'user.gif', 'controlId':'galleryManagement'}
    ,{'text':'photo upload', 'img':'user.gif','controlId':'photo'}],
    
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
                if ( !_IsSignIn ) {
                    Swamp2(admin.CurrentControl, "Login");
                    return;
                }
                var a = e.target;
                if ( a.tagName.toLowerCase != 'a') {
                    a = $(e.target).parents("a");
                }
                Swamp2( admin.CurrentControl, a.data('controlId'));
            });
        $("<img src='images/" + item.img + "'>").appendTo($a);
        $("<div></div>").text(item.text).appendTo($a);
       
       $("<div style='width:20px;height:10px;overflow:hidden'></div>").appendTo($menuContainer);
    }
    if ( _IsSignIn ) {
        Swamp2(null, 'passwordManagement');
    } else {
        Swamp2(null, 'Login');
    }
    //$('#Login').css({'display':'block'});
});

function Login() {
    var input = $('input', $('#Login'));
    var para = {};
    $.extend(para, {'name': $(input[0]).attr('value')});
    $.extend(para, {'password':$(input[1]).attr('value')});
    
    _postJSON({'method':'Login'}, para, function (data){
        if ( data.msgId) {
            alert(data.message);
        } else {
            _IsSignIn = 1;
            Swamp($('#Login'), $('#passwordManagement'));
        }
        E();
    });
    
};
function Swamp2(id1, id2) {
    if ( id1 == id2 ) {
        return;
    }
    var show = function ()  {
        $('#' + id2).fadeIn('fast');
        admin.CurrentControl = id2;
    };
    
    if ( id1 ) {
        $('#' + id1 ).fadeOut('fast', function() {show();});
    } else {
        show();
    }
};


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
function checkSignIn() {
    if ( !_IsSignIn ) {
        Swamp2(admin.CurrentControl, "Login");
    }
}
function B() {
    _IsRequesting = true;
    $("#Loading").show();
};
function E() {
    _IsRequesting = false;
    $("#Loading").hide();
};
function SavePhoto() {
    B();
    if ( !checkFile() ) {
        E();
        return;
    };
    $.ajaxFileUpload({
		url:'savephoto.aspx', 
		secureuri:false,
		fileElementId:'fileToUpload',
		dataType: 'json',
		success: function (data, status){
			if ( data.msgId ) {
			    E();
			    alert(data.message);
			} else {
				saveInformation(data);
			}
		},
		error: function (data, status, e) {
		    E();
		    for(p in data ) {
		        //alert(data[p]);
		    }
		}
	});
    var saveInformation = function(data) {
        alert(data.message);
        E();
    };
};

function checkFile() {
    var fileName = $('#fileToUpload').attr('value');
    fileName = fileName.substr(fileName.lastIndexOf('.') + 1 ).toLowerCase();
    if (! fileName ) {
        return false;
    }
    for ( var i = 0; i < _EnabledFileType.length ; ++i ) {
        if ( _EnabledFileType[i] == fileName)
            return true;
    }
    alert("Please select correct file type!");
    return false;
};

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