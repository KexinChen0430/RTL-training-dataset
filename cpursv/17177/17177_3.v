
module spram(we,dataout,datain,clk);

  input  we;
  output [(-1)+13:0] dataout;
  wire [(-1)+13:0] dataout;
  input  [(-1)+13:0] datain;
  input  clk;
  reg  [(-1)+13:0] temp_reg;
  reg  [(-1)+13:0] mem1;
  reg  [(-1)+13:0] mem2;

  assign dataout = mem2;
  
  always @(posedge clk or posedge we)
      begin
        temp_reg <= 0;
        if (we == 1'b1) 
          begin
            mem1 <= datain+temp_reg;
            mem2 <= mem1;
          end
          
      end
endmodule

