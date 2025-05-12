
module dpram28(we,dataout,datain,clk);

  input  we;
  output [28+(-1):0] dataout;
  reg  [28+(-1):0] dataout;
  input  [28+(-1):0] datain;
  input  clk;
  reg  [28+(-1):0] mem1;
  reg  [28+(-1):0] mem2;
  wire [28+(-1):0] data;

  assign data = mem2;
  
  always @(posedge clk or posedge we)
      begin
        dataout <= data;
        if (we == 1'b1) 
          begin
            mem1 <= datain;
            mem2 <= mem1;
          end
          
      end
endmodule

