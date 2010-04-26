// Create By Blue, 2010-4-26
var g = {
    ControlPanel : null,
    ImageHolder : null
}
function photo (src1, src2) {
    this.s1 = src1;
    this.s2 = src2;
    this.load = false;
}
var photoList = new Array();
$(document).ready(function(){
    var testCount = 23;
    for ( var i = 0; i < testCount; ++i ) {
        var p = new photo(i + '.jpg', 't' + i + '.jpg');
        photoList.push( p);
    }
    
    
});