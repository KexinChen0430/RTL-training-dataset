
module dpram16(we,dataout,datain,clk);

  input  we;
  output [16-1:0] dataout;
  reg  [16-1:0] dataout;
  input  [16-1:0] datain;
  input  clk;
  reg  [16-1:0] mem1;
  reg  [16-1:0] mem2;
  wire [16-1:0] data;

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

