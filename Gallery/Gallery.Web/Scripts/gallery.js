// Create By Blue, 2010-4-26
// to create a Gallery slide show
var g = {
    ControlPanel: null,
    ImageHolder: null
}
var fixedSize = false;
var fixedW = 556
var fixedH = 556;

var $slide, $des;
var currentPage = 0;
var pageCount = 0;
var $selectedImg = null;
var $showingImg = null;
var isRequesting = false;
var playingIndex = -1;
var isPlaying = 0;
function photo(src1, src2) {
    // if s1 == '' we'll use a default gif
    this.s1 = src1;
    this.s2 = src2;
    this.load = 0;
    this.selected = 0;
    this.index = 0;

    this.width = 558;
    this.height = 558;
}

$(document).ready(function() {
    $slide = $('#Slide');
    $des = $('#divDescription');

    if ($.trim(description).length > 0) {
        //$des.css({'visibility':'visible','height':'2
        $des.text(description)
            .fadeIn('slow');
    }
    Gallery_Init();
    Play();
});
function Gallery_Init() {
    pageCount = Math.floor(photoList.length / 12) + 1;
    for (var i = 0; i < photoList.length; ++i) {
        photoList[i].index = i;
        var $d = $("<div><div>")
            .addClass('thumb')
            .appendTo($slide);
        var img = photoList[i];
        if (img.s1.length == 0) {
            img.s1 = 'images/defaultThumb.jpg';
        } else {
            img.s1 = '/photos/' + img.s1;
        }
        if (img.s2.length == 0) {
            img.s2 = 'images/default.jpg';
        } else {
            img.s2 = '/photos/' + img.s2;
        }
        var $img = $("<img id='" + "__" + i + "' />")
            .addClass('img_thumb')
            .css({ 'opacity': 0.6 })
            .attr('src', img.s1)
            .data('data', photoList[i])
            .appendTo($d);
        $img.attr('s2', img.sr2);
        $img.hover(function(e) {
            if ($(e.target).data('data').selected)
                return;
            $(e.target)
                    .css({ 'border': 'solid 2px silver' })
                    .fadeTo(400, 1);

        },
            function(e) {
                if ($(e.target).data('data').selected)
                    return;

                $(e.target)
                    .css({ 'border': 'none' })
                    .fadeTo(400, 0.6);
            })
            .click(function(e) {
                if (isRequesting)
                    return;
                if (isPlaying) {
                    Stop();
                }
                var $img = $(e.target);
                //                $img.css({'border':'solid 2px silver'})
                var data = $img.data('data');
                if (data.selected) {
                    return;
                }
                PlayImage(data);
            });
    }
    $("<div style='clear:both'></div>").appendTo($slide);
};
function SetThumbSelected($img) {
    var data = $img.data('data');
    data.selected = 1;
    if ($selectedImg) {
        $selectedImg.css({ 'opacity': 0.6 });
        $selectedImg.data('data').selected = 0;
    }
    $selectedImg = $img;

    if (!data.load) {
        LoadImage(data);
    } else {
        ShowImage($('#_' + data.index));
    }
};

function SetThumbStyle($img) {
    var data = $img.data('data');
    data.selected = 1;
    if ($selectedImg) {
        $selectedImg.css({ 'opacity': 0.6, 'border': 'none' });
        $selectedImg.data('data').selected = 0;
    }
    $selectedImg = $img;
    $selectedImg.css({ 'opacity': 1, 'border': 'solid 2px silver' });
    $selectedImg.data('data').selected = 1;
};
var timer = null;
var speed = 2000;
function PlayImage(data, callback) {
    SetThumbStyle($('#__' + data.index));
    var SetCallback = function() {
        if (callback) {
            callback();
        }
        if (isPlaying) {
            timer = window.setTimeout(function() { startPlay(); }, speed);
        }
    }
    if (data.load) {
        ShowImage($('#_' + data.index), SetCallback);
        return;
    }

    LoadImage(data, function() {
        ShowImage($('#_' + data.index), SetCallback);
    });

}

function ShowImage($img, callback) {
    var show = function() {

        //$img.css({'border': 'solid 2px silver'});
        $img.fadeIn('fast', function() {
            $showingImg = $img;
            if (callback) {
                callback();
            }
        });
    };
    if ($showingImg) {
        $showingImg.fadeOut('fast', function() {
            show();
        });
    } else {
        show();
    }
}
function LoadImage(data, callback) {
    //alert(data.width);
    var w = data.width, h = data.height;
    var mgL = 0, mgT = 0;
    //alert(data.height);
    //alert(w);
    //alert(h);
    if (w > h) {
        mgL = 0;
        h = Math.floor(fixedW * h / w);
        w = fixedW;
        mgT = Math.floor((fixedH - h) / 2);
    } else {
//    alert(w);
//    alert(h);
        mgT = 0;
        w = Math.floor(fixedH * w / h);
        h = fixedH;
        mgL = Math.floor((fixedW - w) / 2);
//        alert(w);
//        alert(fixedW);
        //        alert((fixedW - w) / 2);
        // Warning :MARGIN-LFET:
        //mgL -= 30;
    }

    isRequesting = true;
    var img = new Image();
    img.id = "_" + data.index;
    var $img = $(img);
    $img.css({ 'display': 'none', 'float':'left', 'border': 'none','width':w + 'px','height':h + 'px','margin-top': mgT + 'px','margin-left':mgL + 'px' });
    /*
    if (fixedSize) {
        $img.css({ 'width': (fixedW - 2) + 'px', 'height': (fixedH - 2) + 'px' });
    } else {
        $img.css({ 'border': 'solid 2px gray' });
    }
    */
    //alert(mgL);
    $(img).load(function(e) {
        isRequesting = false;
        if (callback) {
            callback();
        }
    }).appendTo($('#imgHolder'))
    .attr('src', data.s2);
}

function SetPage(increasement) {
    //currentPage += increasement;
    var top = parseInt($slide.css('top').replace('px', ''), 10);
    if (increasement > 0) {
        top += 360;
    } else {
        top -= 360;
    }
    $slide.animate({ 'top': top + 'px' });
}

function Up() {
    if (isPlaying || currentPage == 0)
        return;

    SetPage(1);
    --currentPage;
};
function Down() {
    if (isPlaying || currentPage >= pageCount - 1)
        return;

    SetPage(-1);
    ++currentPage;
};
function Play() {
    if (isPlaying || photoList.length < 1)
        return;
    //
    isPlaying = 1;
    currentPage = 0;
    $slide.css({ 'top': '0px', 'left': '0px' });
    playingIndex = -1;
    startPlay();
};


function startPlay() {
    ++playingIndex;

    if (playingIndex == photoList.length) {
        playingIndex = 0;
        $slide.css({ 'top': '0px', 'left': '0px' });
        currentPage = 0;
    } else {

        var newPage = Math.floor(playingIndex / 12);
        if (newPage > currentPage) {
            SetPage(-1);
        } else if (newPage < currentPage) {
            SetPage(1);
        }

        //        SetPage(-1);
        currentPage = newPage;
    }

    PlayImage(photoList[playingIndex]);
}
function Stop() {
    if (timer) {
        window.clearTimeout(timer);
    }
    timer = null;
    isPlaying = false;
};