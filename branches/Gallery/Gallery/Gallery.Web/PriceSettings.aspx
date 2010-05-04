<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PriceSettings.aspx.cs"
    Inherits="Gallery.Web.PriceSettings" %>

<%@ Register TagPrefix="Gallery" TagName="MH" Src="~/ManagementHeader.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Price Settings</title>
    <script language="javascript" src="scripts/jquery-1.4.1.min.js" type="text/javascript"></script>

    <style type="text/css">
        .pleft
        {
            margin-left: 10px;
            font-size: 10pt;
            font-weight: bolder;
            height: 22px;
            line-height: 22px;
            overflow: hidden;
            float: left;
            width: 250px;
            font-family: Tahoma;
            letter-spacing: 0px;
        }
        .pright
        {
            font-size: 10pt;
            font-weight: 900;
            height: 22px;
            line-height: 22px;
            overflow: hidden;
            float: left;
        }
        .input_text
        {
            width: 50px;
            height: 18px;
        }
    </style>

    <script language="javascript" type="text/javascript">
    
    var PriceSettings = '<%= SavedPriceSettings %>';
    function LoadPriceSetting() {
        var ps = PriceSettings.split(',');
        var count = 0;
        $('.input_text', $('#priceWin')).each(function(){
            $(this).attr('value', ps[count]);
            ++count;
        });
    };
    
function SavePrice() {
    if (_IsRequesting ) {
        return;
    }
    var priceArray = new Array();
    $('.input_text', $('#priceWin')).each(function(){
        var price = $(this).attr('value');
        
        if ( parseFloat(price) ==  price ) {
            $(this).css({'background-color':'#ffffff'});
            priceArray.push( price);
        } else {
            $(this).css({'background-color':'red'});
        }
    });
    
    //alert( priceArray.join(','));
    var query = {'method':'UpdatePriceSettings'};
    
    _postJSON(query, {'priceSettings': priceArray.join(',')}, function ( data) {
        //_IsRequesting = false;
        if ( data.msgId == 0 ) {
            alert("Price has been updated!");
        } else {
            alert("There are exceptions happend, please try again!");
        }
    });
}
    
    $(document).ready(function(){
        LoadPriceSetting();
    });
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <Gallery:MH ID="MH1" runat="server" />
    <div class="win" style="width: 700px; z-index: 20; left: 20px;" id="priceWin">
        <div class="window_header" style="width: 700px;">
            Price Maintainance
        </div>
        <div class="window_content" style="width: 700px; height: 600px;">
            <div class="pleft" style="margin-top: 10px; font-size: 11pt; font-family: Verdana">
                Pet Portrait and Equine Photography</div>
            <div style="clear: both;">
            </div>
            <div class="pleft">
                1 Hour Session Package</div>
            <div class="pright">
                $<input type="text" value="150.00" class="input_text" /></div>
            <div style="clear: both;">
            </div>
            <div class="pleft" style="width: 360px; font-family: Tahoma; letter-spacing: 0px;
                font-size: 11px; font-weight: bold;">
                Includes Horse/Pet Portrait and action with horse or pet</div>
            <div style="clear: both;">
            </div>
            <div class="pleft">
                1/2 Hour Session - Portrait</div>
            <div class="pright">
                $<input type="text" value="80.00" class="input_text" /></div>
            <div style="clear: both;">
            </div>
            <div class="pleft">
                1/2 Hour Session -
            </div>
            <div style="clear: both;">
            </div>
            <div class="pleft" style="width: 200px; margin-left: 60px;">
                Action with horse or pet</div>
            <div class="pright">
                $<input type="text" value="80.00" class="input_text" /></div>
            <div style="clear: both;">
            </div>
            <div class="pleft">
                CD containing session photos</div>
            <div class="pright">
                $<input type="text" value="20.00" class="input_text" /></div>
            <div style="clear: both; background-color: Blue;">
            </div>
            <!--</div>-->
            <div class="pleft">
                Prints</div>
            <div style="clear: both;">
            </div>
            <div class="pleft" style="width: 200px; margin-left: 60px;">
                4X6</div>
            <div class="pright" style="float: left; margin-right: 40px;">
                $<input type="text" value="10.00" class="input_text" /></div>
            <div style="clear: both;">
            </div>
            <div class="pleft" style="width: 200px; margin-left: 60px;">
                5X7</div>
            <div class="pright" style="float: left; margin-right: 40px;">
                $<input type="text" value="15.00" class="input_text" /></div>
            <div style="clear: both;">
            </div>
            <div class="pleft" style="width: 200px; margin-left: 60px;">
                8X10</div>
            <div class="pright" style="float: left; margin-right: 40px;">
                $<input type="text" value="20.00" class="input_text" /></div>
            <div style="clear: both;">
            </div>
            <div class="pleft">
                Larger prints available upon request</div>
            <div style="clear: both;">
            </div>
            <div class="pleft" style="margin-top: 10px;">
                Print Service</div>
            <div style="clear: both;">
            </div>
            <div class="pleft" style="width: 200px; margin-left: 60px;">
                Dry mount</div>
            <div style="clear: both;">
            </div>
            <div class="pleft" style="width: 200px; margin-left: 60px;">
                5X7</div>
            <div class="pright" style="float: left; margin-right: 40px;">
                $<input type="text" value="5.00" class="input_text" /></div>
            <div style="clear: both;">
            </div>
            <div class="pleft" style="width: 200px; margin-left: 60px;">
                8X10</div>
            <div class="pright" style="float: left; margin-right: 40px;">
                $<input type="text" value="10.00" class="input_text" /></div>
            <div style="clear: both;">
            </div>
            <div class="pleft" style="width: 200px; margin-left: 60px; margin-top: 15px;">
                Mat ( single white Mat )
            </div>
            <div style="clear: both;">
            </div>
            <div class="pleft" style="width: 200px; margin-left: 60px;">
                5X7 (11X14 external)</div>
            <div class="pright" style="float: left; margin-right: 40px;">
                $<input type="text" value="10.00" class="input_text" /></div>
            <div style="clear: both;">
            </div>
            <div class="pleft" style="width: 200px; margin-left: 60px;">
                8X10 (16X20 external)</div>
            <div class="pright" style="float: left; margin-right: 40px;">
                $<input type="text" value="20.00" class="input_text" /></div>
            <div style="clear: both;">
            </div>
            <div>
                <input type="button" value="Save" onclick="SavePrice();" />
            </div>
        </div>
    </div>
    </form>
</body>
</html>
