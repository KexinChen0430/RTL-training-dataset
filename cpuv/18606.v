module my_module (serial_in, final_out); 
   input [15:0] serial_in;               
   output [15:0] final_out [0:7];        
   logic signed [15:0] parallel_out [0:7]; 
   submod_a a_inst
     (
      .parallel_out (parallel_out), 
      .serial_in    (serial_in));   
   submod_b b_inst
     (
      .final_out    (final_out),    
      .parallel_out (parallel_out)); 
endmodule