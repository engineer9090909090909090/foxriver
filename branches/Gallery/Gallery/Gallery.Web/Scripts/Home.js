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

function GalleryItem_Click($item) {
    if ($CurrentGalleryItem) {
        $CurrentGalleryItem.css({ 'background-color': '' });
    }
    $item.css({ 'background-color': 'Silver' });
    $CurrentGalleryItem = $item;
    var data = $item.data('data');
    //alert(data.text);
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
function FillTable(photoList) {
    for (var i = 0; i < photoList.length; ++i) {
        var $newRow = addRow();
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
}

$(document).ready(function() {
    var menuContainer = $('#Menu');
    $cbxShow = $('#cbxShow');
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
        //alert($file.attr('type'));
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

    tmpRowData.view.click(function() {
        alert('view');
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
        var newRow = addRow();
        FillRow({ 'id': data.data, 's1': '', 's2': '' }, newRow);
        E();
    });
};
var idseed = 1024;
function addRow() {
    var newRow = $('#TempRow')
        .clone(true)
        .css({ 'display': '' })
        .appendTo($('#RowContainer'));
    var data = GetRow(newRow);
    data.f1[0].id = '_' + (idseed++);
    data.f2[0].id = '_' + (idseed++);
    data.f1.attr('name', data.f1[0].id);
    data.f2.attr('name', data.f2[0].id);
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
//    alert($input[0].id);
//    return;
    B();
//    alert('savephoto.aspx?nothing=' + encodeURI(new Date().toString()) + '&name=' + $input.attr('name') + "&ptype=" + $input.attr('ptype'));
//    alert($input[0].outerHTML);
    
    $.ajaxFileUpload({
        url: 'savephoto.aspx?nothing=' + encodeURI(new Date().toString()) + '&name=' + $input.attr('name') + "&ptype=" + $input.attr('ptype'),
        secureuri: false,
        //        fileElementId: 'fileToUpload',
        fileElementId: $input.attr('id'),
        dataType: 'json',
        success: function(data, status) {
            if (data.msgId) {
                E();
                alert(data.message);
            } else {
                saveInformation(data,$input);
            }
        },
        error: function(data, status, e) {
            E();
            for (p in data) {
                alert(data[p]);
            }
        }
    });
    var saveInformation = function(data, $input) {
        alert(data.message);
        $input.attr('value', '');
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