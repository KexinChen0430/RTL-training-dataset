
module register(clk,Reset,R_Addr_A,R_Addr_B,W_Addr,W_Data,Write_Reg,R_Data_A,
                R_Data_B);

  input  clk;
  input  Reset;
  input  Write_Reg;
  input  [4:0] R_Addr_A,R_Addr_B,W_Addr;
  input  [31:0] W_Data;
  output [31:0] R_Data_A;
  output [31:0] R_Data_B;
  reg  [31:0] REGISTERS[0:31];
  integer i;

  assign R_Data_A = (R_Addr_A == 5'b00000) ? 32'h0000_0000 : REGISTERS[R_Addr_A];
  assign R_Data_B = (R_Addr_B == 5'b00000) ? 32'h0000_0000 : REGISTERS[R_Addr_B];
  
  always @(posedge clk or posedge Reset)
      begin
        if (Reset) 
          begin
            for (i = 0; i <= 31; i = i+1)
                begin
                  REGISTERS[i] <= 32'h0000_0000;
                end
          end
        else 
          begin
            if (Write_Reg && (W_Addr != 5'b00000)) 
              begin
                REGISTERS[W_Addr] <= W_Data;
              end
              
          end
      end
endmodule

