$(document).ready(function(){ 
$("#categories_multiselect").multiSelect({
   // selectableHeader: "<div class='categories_header left_one'>Untracked Areas<a href='#' class='categories_select' id='select-all'>Select All</a></div>",
  //  selectedHeader: "<div class='categories_header right_one'>Tracked Areas<a href='#'  class='categories_select' id='deselect-all'>Deselect All</a></div>"
    selectableHeader: "<div class='categories_header left_one'><a href='#' class='categories_select pull-right' id='select-all'>Select All</a></div>",
    selectedHeader: "<div class='categories_header right_one'><a href='#'  class='categories_select pull-right' id='deselect-all'>Deselect All</a></div>"

});
  $('#select-all').click(function(){
    $('#categories_multiselect').multiSelect('select_all');
    return false;
  });
  $('#deselect-all').click(function(){
    $('#categories_multiselect').multiSelect('deselect_all');
    return false;
  });
  
  $(".category_check").change(function(){
  //alert("abhiram")
    // alert()
    //alert($(this).data('category'))
    $("#" + $(this).data('category')).toggle();

  });
  
  $(".quality_check").change(function(){
  //alert("abhiram")
    // alert()
    //alert($(this).data('category'))
    $("#" + $(this).data('quality')).toggle();

  });
  
  $(".duration_check").change(function(){
  //alert("abhiram")
    // alert()
    //alert($(this).data('category'))
    $("#" + $(this).data('duration')).toggle();

  });

    $(".delivery_time_check").change(function(){
  //alert("abhiram")
    // alert()
    //alert($(this).data('category'))
    $("#" + $(this).data('delivery_time')).toggle();

  });
});