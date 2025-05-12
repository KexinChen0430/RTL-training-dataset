
module check1;

  
  initial  
  begin
    $printtimescale(check_100s);
    $printtimescale(check_10s);
    $printtimescale(check_1s);
    $printtimescale(check_100ms);
    $printtimescale(check_10ms);
    $printtimescale(check_1ms);
    $printtimescale(check_100us);
    $printtimescale(check_10us);
    $printtimescale(check_1us);
    $printtimescale(check_100ns);
    $printtimescale(check_10ns);
    $printtimescale(check_1ns);
    $printtimescale(check_100ps);
    $printtimescale(check_10ps);
    $printtimescale(check_1ps);
    $printtimescale(check_100fs);
    $printtimescale(check_10fs);
    $printtimescale(check_1fs);
    $display("");
    $printtimescale(check_tup);
    $printtimescale(check_tup_d);
  end
endmodule

