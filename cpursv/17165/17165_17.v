
module top;

  reg  pass;
  reg  [1<<1:0] res[0:7];
  reg  [1<<1:0] in[0:7];
  reg  [7:0] dummy[0:6];
  time  run_time[0:7];
  time  exp_time[0:7];
  integer i;

  
  initial  
  begin
    pass = 1'b1;
    #1 ;
    for (i = 0; i < 8; i = i+1)
        begin
          in[i] = i[1<<1:0];
        end
    #1 ;
    for (i = 0; i < 8; i = i+1)
        begin
          exp_time[i] = $time+(-1);
        end
    check;
    for (i = 0; i < 7; i = i+1)
        begin
          dummy[i] = 1'b0;
          #1 ;
          exp_time[i] = $time+(-1);
          check;
        end
    if (pass) 
      $display(PASSED);
      
  end
  
  task check;

    integer j;

    begin
      for (j = 0; j < 8; j = j+1)
          begin
            if (res[j] !== j[1<<1:0]) 
              begin
                $display("FAILED: index %0d value, at %2t, expected %b, got %b.",
                         j,$time,j[1<<1:0],res[j]);
                pass = 1'b0;
              end
              
            if (run_time[j] !== exp_time[j]) 
              begin
                $display("FAILED: index %0d time, at %2t, expected %2t, got %2t.",
                         j,$time,exp_time[j],run_time[j]);
                pass = 1'b0;
              end
              
          end
    end
  endtask
  genvar m;
  
  generate
      for (m = 0; m <= 7; m = m+1)
          begin : idac_loop
            
            always @(in[m:m] or dummy[m:m])
                begin
                  res[m] = in[m];
                  run_time[m] = $time;
                end
          end
  endgenerate

endmodule

