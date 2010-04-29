var galleries = [{'text':'Equine Portraits','id':1},
{'text':'Pet Portraits','id':2},
{'text':'Event Photography','id':3}];

function addMenu( menuItem, href ) {
    var item = $('<li></li>')
        .html("<a href='" + href + "'>" + menuItem + "</a>")
        .appendTo($('#Menu'));
    return item;
}

var $sub = null;

function goToGallery(galleryId){
    //document.location.href = 'work.htm?gid=' + galleryId;
    /*
    var $form = $("<form></form>")
        .attr("method","post")
        .attr("action","gallery.aspx")
        .appendTo(document.body);
        */
    var $form = $("<form action='gallery.aspx' method='post'></form>").appendTo(document.body);
    var $gid = $("<input type='text' name='galleryId' value='" + galleryId + "' />").appendTo($form);
//    alert("FFF");
    $form[0].submit();
};
$(document).ready(function() {
    
    addMenu("Home", "home.html");
    addMenu("About Us","about.htm");
    addMenu("Services", "services.htm");
    //var $work = addMenu("Galleries", "work.htm");
    var $work = addMenu("Galleries", "javascript:void(0);");
    $work.click(function(){
        goToGallery(1);
    });
    addMenu("Contact Us", "contact.htm");
    $sub = $("<div style='position:absolute;top:-100px;left:-100px;overflow:hidden;display:none;background-color:#000;color:#fff;text-align:left;'></div>").appendTo(document.body);
    for ( var i = 0; i < galleries.length; ++i ) {
        var div = $('<div></div>')
            .css({'height':'23px','line-height':'23px','margin-left':'5px','margin-right':'20px'})
            .appendTo($sub);
        var $a = $("<a href='javascript:void(0);'></a>")
            .text(galleries[i].text)
            .attr('gid', galleries[i].id)
            .css({'color':'#fff','text-decoration':'none'})
            .appendTo(div)
            .hover(function(e){
                $(e.target).css({'text-decoration':'underline','color':'#28556b'});
            },function(e){
                $(e.target).css({'text-decoration':'none','color':'#fff'});
            })
            .click(function(e) {
                var gid = $(e.target).attr('gid');
                //alert(gid);
                goToGallery(gid);
            });
    }
    
    $work.hover(function ( e) {
        var a = $(e.target);
        $sub.css({'left': a.offset().left + 'px', 'top':(a.offset().top + 22) + 'px', 'display' : ''});
        //$sub.css({});
        },
        function(e) {
    });
    
    $sub.hover(null, function(e) {
        $sub.fadeOut('fast');
    });
});