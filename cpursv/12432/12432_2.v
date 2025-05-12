
module REGISTER_FILE  #(parameter 
       REGISTER_WIDTH    = 32,
       REGISTER_DEPTH    = 32,
       STACK_POINTER_ADD = 1<<1,
       STACK_POINTER_VAL = 32'd1024,
       HIGH              = 1'b1)
  (input  CLK,
   input  [(0-1)+$clog2(REGISTER_DEPTH):0] RS1_ADDRESS,
   input  [(0-1)+$clog2(REGISTER_DEPTH):0] RS2_ADDRESS,
   input  [(0-1)+$clog2(REGISTER_DEPTH):0] RD_ADDRESS,
   input  [(0-1)+REGISTER_WIDTH:0] RD_DATA,
   input  RD_WRITE_EN,
   output [(0-1)+REGISTER_WIDTH:0] RS1_DATA,
   output [(0-1)+REGISTER_WIDTH:0] RS2_DATA);

  reg  [(0-1)+REGISTER_WIDTH:0] register[REGISTER_DEPTH+(0-1):0];
  reg  [(0-1)+REGISTER_WIDTH:0] rs1_data_reg;
  reg  [(0-1)+REGISTER_WIDTH:0] rs2_data_reg;
  integer i;

  
  initial  
  begin
    for (i = 0; i < REGISTER_DEPTH; i = i+1)
        begin
          if (i == STACK_POINTER_ADD) register[i] = STACK_POINTER_VAL;
          else register[i] = {REGISTER_WIDTH{1'b0}};
        end
  end
  
  always @(*)
      begin
        rs1_data_reg = register[RS1_ADDRESS];
        rs2_data_reg = register[RS2_ADDRESS];
      end
  
  always @(negedge CLK)
      begin
        if ((RD_ADDRESS != 5'b0) & (RD_WRITE_EN == HIGH)) 
          begin
            register[RD_ADDRESS] <= RD_DATA;
          end
          
      end
  assign RS1_DATA = rs1_data_reg;
  assign RS2_DATA = rs2_data_reg;
endmodule

