
module check2;

  
  initial  
  begin
    $printtimescale(check_tu_nest);
    $printtimescale(check_tp_nest);
    $printtimescale(check_tup_nest);
    $printtimescale(check_tpu_nest);
    $display("");
    $printtimescale(check_tu_nest.nested);
    $printtimescale(check_tp_nest.nested);
    $printtimescale(check_tup_nest.nested);
    $printtimescale(check_tpu_nest.nested);
  end
endmodule

