// created by blue, 2010-4-23
var _CurrentContent = null;
function GalleryEntity(id, text, show ){
    this.id = id;
    this.text = text;
    this.show = show;
};
var GalleryList = new Array();
function Test_Init() {
    var g = new GalleryEntity(1, "g1", 1);
    GalleryList.push(g);
    
    g = new GalleryEntity(2, "g2", 1);
    GalleryList.push(g);
    
    g = new GalleryEntity(3, "g3", 1);
    GalleryList.push(g);
    
    for ( var i = 4; i <= 10; ++i ) {
        g = new GalleryEntity(1, "temp " + i, 0);
        GalleryList.push(g);
    }
}
$(document).ready(function(){
    Test_Init();
    var menuContainer = $('#Menu');
    for ( var i = 0; i <  GalleryList.length; ++i ) {
        $('<div></div>')
            .data('data', GalleryList[i])
            .text(GalleryList[i].text)
            .appendTo(menuContainer)
            .addClass('#Menu div')
            .hover(function(e){
                $(e.target).css({'text-decoration':'underline'});
                },
                function(e){
                    $(e.target).css({'text-decoration':'none'});
                })
            .click(function(e){
                    MenuItem_Click(e);
                });
            
    }// end for
    
    var tmpRowData = GetRow($('#TempRow'));
    // upload thumb
    tmpRowData.u1.click(function(){
        alert('2');
    });
    tmpRowData.u2.click(function(){
        alert('3');
    });
    
    tmpRowData.del.click(function(){
        if (!confirm("Delete this row!"))
            return;
        alert('dd');
    });
    
    tmpRowData.up.click(function(){
        alert('up');
    });
    
    tmpRowData.down.click(function(){
        alert('down');
    });
    
    tmpRowData.view.click(function(){
        alert('view');
    });
});

function GetRow ( $row){
    var data = {};
    //var div = $('img', $row);
    $.extend(data, {'thumb' :$('img', $row)});
    
    var files = $("input[type='file']", $row);
    $.extend(data,{'f1': $(files[0])});
    $.extend(data,{'f2': $(files[1])});
    
    var links = $("a", $row);
    $.extend(data, {'u1': $(links[0]) });
    $.extend(data, {'u2': $(links[1])});
    
    $.extend(data,{'del':$(links[2])});
    $.extend(data,{'up':$(links[3])});
    $.extend(data,{'down':$(links[4])});
    $.extend(data,{'view':$(links[5])});
    
    return data;
}
function addRow() {
    var newRow = $('#TempRow')
        .clone(true)
        .css({'display':''})
        .appendTo($('#RowContainer'));
    
}
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
    if ( id1 == id2) {
        return;
    }
    var showNext = function() {
        $('#' + id2).css({'display':'block'});
        $('#' + id2).animate({'left':'150px'}, 800, 'swing');
    }
    if ( id1 ) {
        $('#' + id1 ).fadeOut('fast', function() {
            showNext();
        });
    } else {
        showNext();
    }
    _CurrentContent = id2;
    
};