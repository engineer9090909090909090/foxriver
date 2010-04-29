// created by blue, 2010-4-23
var _CurrentContent = null;
var _IsRequesting = false;
function GalleryEntity(id, text, show) {
    this.id = id;
    this.text = text;
    this.show = show;
};
var $CurrentGalleryItem = null;
var $cbxShow = null;
var $tbGalleryName = null;
var $BigPhoto = null;
function GalleryItem_Click($item) {
    if ($CurrentGalleryItem) {
        $CurrentGalleryItem.css({ 'background-color': '' });
    }
    $item.css({ 'background-color': 'Silver' });
    $CurrentGalleryItem = $item;
    var data = $item.data('data');
    $tbGalleryName.attr('value', data.text);
    if (data.show) {
        $cbxShow.attr('checked', true);
    } else {
        $cbxShow.attr('checked', false);
    }

    $('#RowContainer').children().remove();
    //alert(data.id);
    B();
    _postJSON({ 'method': 'GetPhotos' }, { "galleryId": data.id }, function(data) {
        //                alert( '[' + data.msgId  + ']');
        if (data.msgId) {
            alert(data.message);
        } else {
            FillTable(data.data);
        }
        E();
    });
};
function UpdateGallery() {
    var show = $cbxShow.attr('checked') ? 1 : 0;
    var gName = $tbGalleryName.attr('value');
    var gId = $CurrentGalleryItem.data('data').id;
    //alert(gId);
    _postJSON({'method':'UpdateGallery'}, {'galleryId': gId, 'galleryName': gName,'show': show}, function (data){
        E();
        if ( data.msgId ) {
            alert(data.message);
        } else {
            $CurrentGalleryItem.text(gName);
            var gData = $CurrentGalleryItem.data('data');
            gData.show = show;
            gData.text = gName;
            alert('Update OK!');
        }
    });
};
function FillTable(photoList) {
    for (var i = 0; i < photoList.length; ++i) {
        var $newRow = addRow(photoList[i].id);
        FillRow(photoList[i], $newRow);
    }
};

function FillRow(photo, $row) {
    $row.data('data', photo.id);
    var rowControl = GetRow($row);
    if (photo.s1.length > 0) {
        rowControl.thumb.attr('src', 'Photos/' + photo.s1);
    } else {
        rowControl.thumb.attr('src', 'Images/defaultThumb.jpg');
    }
    
    rowControl.view.attr('img', photo.s2);
    if ( photo.s2 && photo.s2.length > 0 ) {
        rowControl.view.show();
    } else {
        rowControl.view.hide();
    }
    
}

$(document).ready(function() {
    var menuContainer = $('#Menu');
    $cbxShow = $('#cbxShow');
    $tbGalleryName = $('#tbGalleryName');
    //var firstGallery = null;
    for (var i = 0; i < GalleryList.length; ++i) {
        $('<div></div>')
            .data('data', GalleryList[i])
            .text(GalleryList[i].text)
            .appendTo(menuContainer)
            .addClass('#Menu div')
            .hover(function(e) {
                $(e.target).css({ 'text-decoration': 'underline' });
            },
                function(e) {
                    $(e.target).css({ 'text-decoration': 'none' });
                })
            .click(function(e) {
                //MenuItem_Click(e);
                GalleryItem_Click($(e.target));
            });

    } // end for

    var getInputFile = function($link) {
        var $div = $link.parent();
        return $div.children('input');
    };
    var tmpRowData = GetRow($('#TempRow'));
    // upload thumb
    tmpRowData.u1.click(function(e) {
        var $file = getInputFile($(e.target));
        SavePhoto($file);
    });
    tmpRowData.u2.click(function(e) {
        var $file = getInputFile($(e.target));
        SavePhoto($file);
    });

    tmpRowData.del.click(function(e) {
        if (!confirm("Delete this photo!"))
            return;
        var $r = $(e.target).parents('.row');
        //alert(div.length);
        B();
        //        alert($r.data('data'));
        _postJSON({ "method": "DeletePhoto" }, { "photoId": $r.data('data') }, function(data) {
            if (data.msgId) {
                alert(data.message);
            } else {
                $r.remove();
            }
            E();
        });

    });

    tmpRowData.up.click(function() {
        alert('up');
    });

    tmpRowData.down.click(function() {
        alert('down');
    });

    tmpRowData.view.click(function(e) {
        //alert('view');
        var src = $(e.target).attr('img');
        //alert(link.attr('img'));
        if ( !src || src.length == 0 ) {
            return;
        }
        //B();
        var photo = new Image();
        $(photo)
        .appendTo(document.body)
        .attr('title', 'Click to hide photo')
        .css({'display':'none','position':'absolute','left':'200px','top':'150px','cursor':'pointer','border':'solid 2px silver'})
        .click(function(e){
            $(e.target).remove();
        })
        .load( function(e){
            $(e.target).show()
        })
        .attr('src', 'Photos/' + src );
    });


    //
    //    alert($('#Menu').children('div')[0].innerHTML);
    $($('#Menu').children('div')[1]).click();
});

function GetRow($row) {
    var data = {};
    $.extend(data, { 'thumb': $('img', $row) });

    var files = $("input[type='file']", $row);
    $.extend(data, { 'f1': $(files[0]) });
    $.extend(data, { 'f2': $(files[1]) });

    var links = $("a", $row);
    $.extend(data, { 'u1': $(links[0]) });
    $.extend(data, { 'u2': $(links[1]) });

    $.extend(data, { 'del': $(links[2]) });
    $.extend(data, { 'up': $(links[3]) });
    $.extend(data, { 'down': $(links[4]) });
    $.extend(data, { 'view': $(links[5]) });

    return data;
}

function Add_Click() {
    B();
    _postJSON({ 'method': 'AddPhoto' }, { 'galleryId': $CurrentGalleryItem.data('data').id }, function(data) {
        var newRow = addRow(data.data);
        FillRow({ 'id': data.data, 's1': '', 's2': '' }, newRow);
        E();
    });
};
var idseed = 1024;
function addRow(photoId) {
    var newRow = $('#TempRow')
        .clone(true)
        .css({ 'display': '' })
        .appendTo($('#RowContainer'));
    var data = GetRow(newRow);
    
    data.f1[0].id = '_' + photoId;
    data.f2[0].id = '__' + photoId;
    data.f1.attr('name', data.f1[0].id);
    data.f2.attr('name', data.f2[0].id);
    data.f1.attr('pid', photoId);
    data.f2.attr('pid', photoId);
    data.view.attr('img', '');
    return newRow;
}


function B() {
    $("#Loading").show();
};
function E() {
    _IsRequesting = false;
    $("#Loading").hide();
};
function SavePhoto($input) {
    if (!checkFile($input)) {
        alert("Please select correct file type!");
        return;
    };
    B();
    
//    alert($input.attr('ptype'));
    var inputId = $input[0].id;
    $.ajaxFileUpload({
        url: 'savephoto.aspx?nothing=' + encodeURI(new Date().toString()) + '&name=' + $input.attr('name') + "&ptype=" + $input.attr('ptype') + "&pid=" + $input.attr('pid'),
        secureuri: false,
        //        fileElementId: 'fileToUpload',
        fileElementId: $input.attr('id'),
        dataType: 'json',
        success: function(data, status) {
            if (data.msgId) {
                E();
                alert(data.message);
            } else {
                saveInformation(data,$('#' + inputId));
            }
        },
        error: function(data, status, e) {
//            alert(e);
            E();
            alert( "There are some errors happened, please try again later!");
//            for (p in e) {
//                //alert(e[p]);
//            }
        }
    });
    var saveInformation = function(data, $f) {
        var row =  $f.parents('.row');
        var rowControl = GetRow(row);
//        alert( $f.attr('ptype'));
        if ( $f.attr('ptype') == 's1') {
            rowControl.thumb.attr('src', 'Photos/' + data.message);
        } else {
            // set View
            rowControl.view.attr('img', data.message);
            rowControl.view.show();
        }
        $f.attr('value', '');
        E();
    };
};



function checkFile($input) {
    //var fileName = $('#fileToUpload').attr('value');
    var _EnabledFileType = ['jpg', 'jpeg', 'gif', 'png'];
    var fileName = $input.attr('value');
    fileName = fileName.substr(fileName.lastIndexOf('.') + 1).toLowerCase();
    if (!fileName) {
        return false;
    }
    for (var i = 0; i < _EnabledFileType.length; ++i) {
        if (_EnabledFileType[i] == fileName)
            return true;
    }
    
    return false;
};

function getPostUrl() {
    var u = document.location.href;
    if (u.indexOf("?") < 0) {
        return u;
    }

    return u.substr(0, u.indexOf("?"));
}
function _postJSON(queryData, postData, callback, errorCallback) {
    if (_IsRequesting) {
        alert("Please wait for the current operation's finish");
        return;
    }
    _IsRequesting = true;
    var url = getPostUrl();

    url += '?nothing=' + encodeURI((new Date()).toString());
    $.extend(queryData, { 'ajax': '1' });
    for (var q in queryData) {
        url += "&" + q + "=" + encodeURI(queryData[q]);
    }

    $.post(url, postData, function(data) {
        _IsRequesting = false;
        if (data.msgId && data.msgId < 0) {
            if (data.msgId == -1000) {
                alert("Session expired!");
                return;
            }

            // get error from server!
            if (errorCallback && typeof errorCallback === 'function') {
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
/*
$(document).ready(function(){
//var menuContainer = $('#Menu');
var menuItems = $('#Menu').children('div');
var len = menuItems.length;
for ( var i = 0; i < len; ++i ) {
$(menuItems[i]).hover(function(e){
$(e.target).css({'text-decoration':'underline'});
},
function(e){
$(e.target).css({'text-decoration':'none'});
})
.click(function(e){
MenuItem_Click(e);
});
}
var index = 0;
var show = function() {
$(menuItems[index]).fadeIn('fast');
++index;
if ( index >= len) {
Swamp(null, "Home");
return;
}
window.setTimeout(function(){show()}, 200);
};
    
show();
});
*/

function MenuItem_Click(e) {
    var next = $(e.target).attr('cid');
    //alert(next);
    Swamp(_CurrentContent, next);
};
function Swamp(id1, id2) {
    if (id1 == id2) {
        return;
    }
    var showNext = function() {
        $('#' + id2).css({ 'display': 'block' });
        $('#' + id2).animate({ 'left': '150px' }, 800, 'swing');
    }
    if (id1) {
        $('#' + id1).fadeOut('fast', function() {
            showNext();
        });
    } else {
        showNext();
    }
    _CurrentContent = id2;

};