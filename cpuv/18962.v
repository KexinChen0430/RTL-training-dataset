module pullupdown;
  wire pull_up_1, pull_down_1;
  wire [7:0] pull_up_8, pull_down_8;
  reg error;
  assign (pull1, pull0) pull_up_1 = 1'b1;
  assign (pull1, pull0) pull_down_1 = 1'b0;
  assign (pull1, pull0) pull_up_8 = 8'hff;
  assign (pull1, pull0) pull_down_8 = 8'h00;
  reg driver_1;
  reg [7:0] driver_8;
  reg driver_1_en, driver_8_en;
  assign pull_up_1 = (driver_1_en) ? driver_1 : 1'bz;
  assign pull_down_1 = (driver_1_en) ? driver_1 : 1'bz;
  assign pull_up_8 = (driver_8_en) ? driver_8 : 8'bz;
  assign pull_down_8 = (driver_8_en) ? driver_8 : 8'bz;
  initial
    begin : test_block
      integer i;
      driver_1_en = 0;
      driver_8_en = 0;
      error = 0;
      #1; 
      if ((pull_up_1 !== 1'b1) || (pull_down_1 !== 1'b0) ||
          (pull_up_8 !== 8'hFF) || (pull_down_8 !== 8'h00))
        error = 1;
      driver_1_en = 1;
      driver_8_en = 1;
      for (i=0; i<256; i=i+1)
        begin
          driver_1 = ~driver_1; 
          driver_8 = i; 
          $display ("Testing drivers with value %h", driver_8); 
          #1; 
          check_drivers; 
          #10; 
        end
      if (error)
        $display ("FAILED - pullupdown ");
      else
        $display ("PASSED");
    end 
  task check_drivers;
    begin
      if ((pull_up_1 !== driver_1) || (pull_down_1 !== driver_1) ||
          (pull_up_8 !== driver_8) || (pull_down_8 !== driver_8))
        error = 1; 
    end
  endtask 
endmodule