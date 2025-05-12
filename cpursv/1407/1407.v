
module counter48  #(parameter  DATASIZE = 16)
  (input  wire clk,
   input  wire res_n,
   input  wire increment,
   input  wire [DATASIZE-1:0] load,
   input  wire load_enable,
   output wire [DATASIZE-1:0] value);

  reg  [DATASIZE-1:0] value_reg;
  reg  load_enable_reg;

  assign value = value_reg;
  
  always @(posedge clk)
      begin
        if (!res_n) 
          begin
            value_reg <= {DATASIZE{1'b0}};
            load_enable_reg <= 1'b0;
          end
        else 
          begin
            load_enable_reg <= load_enable;
            case ({load_enable_reg,increment})

              2'b00: value_reg <= value_reg;

              2'b01: value_reg <= value_reg+1'b1;

              2'b10: value_reg <= {DATASIZE{1'b0}};

              2'b11: value_reg <= {DATASIZE{1'b0}}+1'b1;

            endcase

          end
      end
endmodule

