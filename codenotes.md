Notes

jQuery-ui

Datepicker

  <script src="//code.jquery.com/jquery-1.9.1.js"></script>
  <script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
  <script>
  $(function() {
    $( "#datepicker" ).datepicker();
  });
  </script>
  
  
  
  
  
  FOR THE HEADER DIV
  
<div id="wrapperHeader">
 <div id="header">
  <img src="images/logo.png" alt="logo" />
 </div> 
</div>



div#wrapperHeader {
 width:100%;
 height;200px; /* height of the background image? */
 background:url(images/header.png) repeat-x 0 0;
 text-align:center;
}

div#wrapperHeader div#header {
 width:1000px;
 height:200px;
 margin:0 auto;
}

div#wrapperHeader div#header img {
 width:; /* the width of the logo image */
 height:; /* the height of the logo image */
 margin:0 auto;
}