module test_bench; 
  supply1 vdd; 
  supply0 gnd; 
  reg __task_done_flag__; 
  reg [31:0] FID; 
  initial begin 
    __task_done_flag__ = 0; 
    #0 
    $stop; 
  end 
  always @(posedge __task_done_flag__) begin 
    #0 __task_done_flag__ = 0; 
    #0 $stop; 
  end 
  task wait_ticks; 
    input ticks; 
    output done_flag; 
    integer ticks; 
    begin
      #ticks done_flag = 1; 
    end 
  endtask 
endmodule 