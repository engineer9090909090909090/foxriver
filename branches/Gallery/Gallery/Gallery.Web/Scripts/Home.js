// created by blue, 2010-4-23
var _CurrentContent = null;
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