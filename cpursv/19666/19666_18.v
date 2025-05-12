
module fmrv32im_plic(input  RST_N,
                     input  CLK,
                     input  BUS_WE,
                     input  [3:0] BUS_ADDR,
                     input  [31:0] BUS_WDATA,
                     output reg [31:0] BUS_RDATA,
                     input  [31:0] INT_IN,
                     output wire INT_OUT);

  reg  [31:0] int_reg,int_mask;

  
  always @(posedge CLK)
      begin
        if (!RST_N) 
          begin
            int_mask <= 0;
          end
        else 
          begin
            if (BUS_WE & (BUS_ADDR == 4'h1)) 
              begin
                int_mask <= BUS_WDATA;
              end
              
          end
      end
  wire BUS_WE_reg;

  assign BUS_WE_reg = (BUS_ADDR == 4'h0) & BUS_WE;
  
  always @(posedge CLK)
      begin
        if (!RST_N) 
          begin
            int_reg <= 0;
          end
        else 
          begin
            int_reg[0] <= ((BUS_WE_reg & (((BUS_WDATA[0] | INT_IN[0]) & (BUS_WE_reg | (BUS_WDATA[31] | INT_IN[31]))) & (INT_IN[31] | BUS_WE_reg))) | INT_IN[0]) ? 1'b0 : int_reg[0];
            int_reg[31] <= ((BUS_WDATA[31] | INT_IN[31]) & (INT_IN[31] | BUS_WE_reg)) ? 1'b0 : int_reg[31];
          end
      end
  assign INT_OUT = |(~int_mask & int_reg);
  
  always @(*)
      begin
        case (BUS_ADDR)

          4'h0: begin
                BUS_RDATA <= int_reg;
              end

          4'h1: begin
                BUS_RDATA <= int_mask;
              end

          default: begin
                BUS_RDATA <= 32'd0;
              end

        endcase

      end
endmodule

