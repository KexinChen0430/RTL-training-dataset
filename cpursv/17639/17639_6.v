
module gpio_wb  #(parameter  BASE_ADDR = 32'h00000400)
  (input  clk_i,
   input  rst_i,
   input  [31:0] dat_i,
   output reg [31:0] dat_o,
   input  [31:0] adr_i,
   input  we_i,
   input  [3:0] sel_i,
   input  cyc_i,
   input  stb_i,
   output reg ack_o,
   input  [15:0] sw_bi,
   output reg [15:0] gpio_bo);

  localparam  IDLE = 0;
  localparam  ACK = 1;
  wire  read = cyc_i & (!we_i & stb_i);
  wire  write = (stb_i & we_i) & cyc_i;
  reg  state_r;

  
  always @(posedge clk_i or posedge rst_i)
      if (rst_i) 
        begin
          state_r <= 0;
          ack_o <= 1'b0;
          gpio_bo <= 0;
          dat_o <= 0;
        end
      else 
        begin
          ack_o <= 1'b0;
          case (state_r)

            IDLE: begin
                  if (write) 
                    begin
                      if (adr_i == BASE_ADDR) gpio_bo <= dat_i[15:0];
                        
                      ack_o <= 1'b1;
                      state_r <= ACK;
                    end
                  else if (read) 
                    begin
                      dat_o <= (adr_i == BASE_ADDR) ? sw_bi : 0;
                      state_r <= ACK;
                    end
                    
                end

            ACK: begin
                  ack_o <= 1'b1;
                  state_r <= IDLE;
                end

          endcase

        end
endmodule

