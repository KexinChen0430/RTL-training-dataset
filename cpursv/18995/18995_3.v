
module dpram16(we,dataout,datain,clk);

  input  we;
  output [(0-1)+16:0] dataout;
  reg  [(0-1)+16:0] dataout;
  input  [(0-1)+16:0] datain;
  input  clk;
  reg  [(0-1)+16:0] mem1;
  reg  [(0-1)+16:0] mem2;
  wire [(0-1)+16:0] data;

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

