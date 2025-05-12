module alu_test
  (
   input clk, 
   output                    reset_n, 
   output                    opcode_valid, 
   output                    opcode, 
   output [DATA_WIDTH-1:0] data, 
   input                    done, 
   input                    overflow, 
   input  [DATA_WIDTH-1:0] result 
   );
   parameter RESET_DURATION = 500; 
   parameter CYCLE_TO_LATCH_FIRST_DATA = 2; 
   logic                   int_reset_n; 
   logic                   int_opcode_valid; 
   logic [1:0]             full_opcode; 
   logic                   int_opcode; 
   logic [DATA_WIDTH-1:0] int_data; 
   int i; 
   logic [3:0] delay; 
   alu_test_stim_s stim; 
   alu_test_stim_s alu_test_stim[0:15] =  { 
   };
   initial
   begin
      int_reset_n = 0; 
      # RESET_DURATION int_reset_n = 1; 
      $display ("\n@ %0d ns: The chip is out of reset", $time); 
      int_opcode_valid = 0; 
      repeat (5)  @(posedge clk); 
      for (i=0; i < 16; i=i+1) begin 
         while(done==0) @(posedge clk); 
         int_opcode_valid = 0; 
         delay = alu_test_stim[i].delay; 
         repeat (delay+2) @(posedge clk); 
      end
      $finish; 
   end
   assign reset_n      = int_reset_n; 
   assign opcode_valid = int_opcode_valid; 
   assign opcode       = int_opcode; 
   assign data         = int_data; 
endmodule