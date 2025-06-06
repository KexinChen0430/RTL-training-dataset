
module fmrv32im_timer(input  RST_N,
                      input  CLK,
                      input  BUS_WE,
                      input  [3:0] BUS_ADDR,
                      input  [31:0] BUS_WDATA,
                      output reg [31:0] BUS_RDATA,
                      output wire EXPIRED);

  reg  [31:0] counter,mask;

  
  always @(posedge CLK)
      begin
        if (!RST_N) 
          begin
            counter <= 0;
            mask <= 0;
          end
        else 
          begin
            if ((BUS_ADDR == 4'h0) & BUS_WE) 
              begin
                counter <= BUS_WDATA;
              end
            else 
              begin
                counter <= 32'd1+counter;
              end
            if ((BUS_ADDR == 4'h1) & BUS_WE) 
              begin
                mask <= BUS_WDATA;
              end
              
          end
      end
  assign EXPIRED = counter >= mask;
  
  always @(*)
      begin
        case (BUS_ADDR)

          4'h0: begin
                BUS_RDATA <= counter;
              end

          4'h1: begin
                BUS_RDATA <= mask;
              end

          default: begin
                BUS_RDATA <= 32'd0;
              end

        endcase

      end
endmodule

