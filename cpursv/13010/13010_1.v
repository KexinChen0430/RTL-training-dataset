
module RegisterFile(rw,addr1,addr2,out1,out2,addr3,data3,clk);

  input  rw;
  input  [4:0] addr1;
  input  [4:0] addr2;
  input  [4:0] addr3;
  input  [31:0] data3;
  output [31:0] out1;
  output [31:0] out2;
  input  clk;
  reg  [31:0] regmem[31:0];

  
  initial  
  begin
    regmem[0] = 32'b00000000000000000000000000000010;
  end
  assign out1 = regmem[addr1];
  assign out2 = regmem[addr2];
  
  always @(negedge clk)
      begin
        if (rw == 1'b1) 
          begin
            regmem[addr3] = data3;
          end
          
      end
endmodule

