module test_sub (   
   clk                         
   );
   input                    clk; 
   integer                  i;   
   reg 	                    a;   
   reg [`REG_WIDTH - 1:0]   b;   
   reg [`REG_WIDTH - 1:0]   mem [`MEM_SIZE - 1:0]; 
   wire 		    c;   
   wire [`REG_WIDTH - 1:0]  d;   
   reg [`REG_WIDTH - 1:0]   e;   
   reg [`REG_WIDTH - 1:0]   f;   
   assign  c = ~a;               
   assign  d = ~b;               
   initial begin
      a = 0;                     
      b = `REG_WIDTH'h0;         
      for (i = 0; i < `MEM_SIZE; i++) begin 
	 mem[i] = i [`REG_WIDTH - 1:0]; 
      end
      e = 0;                     
      f = 0;                     
   end
   always @(posedge clk) begin   
      mem[b]     <= {`REG_WIDTH {a}}; 
      mem[b - 1] <= b - 1;       
      a          <= ~a;          
      b          <= b + 1;       
   end
endmodule