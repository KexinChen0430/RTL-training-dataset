module main; 
   reg [3:0] mem [1:0], D; 
   reg	     rst, clk, wr, wadr, radr; 
   (* ivl_synthesis_on *) 
   always @(posedge clk) 
     if (rst) begin 
	mem[0] <= 0; 
	mem[1] <= 0; 
     end else if (wr) begin 
	mem[wadr] <= D; 
     end
   wire [3:0] Q = mem[radr]; 
   (* ivl_synthesis_off *) 
   initial begin 
      rst = 0; 
      clk = 0; 
      wadr = 0; 
      radr = 0; 
      wr = 0; 
      #1 clk = 1; 
      #1 clk = 0; 
      rst = 1; 
      #1 clk = 1; 
      #1 clk = 0; 
      #1 if (mem[0] !== 0 || mem[1] !== 0) begin 
	 $display("FAILED -- Reset 1: mem[0]=%b, mem[1]=%b", mem[0], mem[1]); 
	 $finish; 
      end
   end
endmodule 