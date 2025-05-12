
module qmem_sram  #(parameter  AW = 32, DW = 32, SW = (1/8)*DW)
  (input  wire clk50,
   input  wire clk100,
   input  wire rst,
   input  wire [AW+(0-1):0] adr,
   input  wire cs,
   input  wire we,
   input  wire [(0-1)+SW:0] sel,
   input  wire [DW-1:0] dat_w,
   output reg [DW-1:0] dat_r,
   output wire ack,
   output wire err,
   output wire [18+(0-1):0] sram_adr,
   output wire sram_ce_n,
   output wire sram_we_n,
   output wire sram_ub_n,
   output wire sram_lb_n,
   output wire sram_oe_n,
   output wire [(0-1)+16:0] sram_dat_w,
   input  wire [(0-1)+16:0] sram_dat_r);

  localparam  S_ID = 3'b000;
  localparam  S_HI1 = 3'b011;
  localparam  S_HI2 = 3'b111;
  localparam  S_LO1 = 3'b010;
  localparam  S_LO2 = 3'b110;
  localparam  S_FH = 3'b001;
  reg  [2:0] state,next_state;

  
  always @(*)
      begin
        case (state)

          S_ID: begin
                if (cs) next_state = S_HI1;
                else next_state = S_ID;
              end

          S_HI1: begin
                if (cs) next_state = S_HI2;
                else next_state = S_ID;
              end

          S_HI2: begin
                if (cs) next_state = S_LO1;
                else next_state = S_ID;
              end

          S_LO1: begin
                if (cs) next_state = S_LO2;
                else next_state = S_ID;
              end

          S_LO2: begin
                if (cs) next_state = S_FH;
                else next_state = S_ID;
              end

          S_FH: begin
                next_state = S_ID;
              end

          default: begin
                next_state = S_ID;
              end

        endcase

      end
  
  always @(posedge clk100 or posedge rst)
      begin
        if (rst) state <= #1 S_ID;
        else state <= #1 next_state;
      end
  reg  [17:0] s_adr;

  
  always @(posedge clk100)
      begin
        if (next_state == S_HI1) s_adr <= #1 {adr[18:2],1'b0};
        else if (next_state == S_LO1) s_adr <= #1 {adr[18:2],1'b1};
          
      end
  reg  s_ce_n;

  
  always @(posedge clk100 or posedge rst)
      begin
        if (rst) s_ce_n <= #1 1'b1;
        else if ((next_state == S_LO1) || (next_state == S_HI1) || 
                 ((next_state == S_LO2) || (next_state == S_HI2))) s_ce_n <= #1 1'b0;
        else s_ce_n <= #1 1'b1;
      end
  reg  s_we_n;

  
  always @(posedge clk100)
      begin
        if ((next_state == S_LO1) || (next_state == S_HI1) || 
            ((next_state == S_LO2) || (next_state == S_HI2))) s_we_n <= #1 !we;
          
      end
  reg  s_ub_n,s_lb_n;

  
  always @(posedge clk100)
      begin
        if (next_state == S_HI1) {s_ub_n,s_lb_n} <= #1 {!sel[3],!sel[2]};
        else if (next_state == S_LO1) {s_ub_n,s_lb_n} <= #1 {!sel[1],!sel[0]};
          
      end
  reg  s_oe_n;

  
  always @(posedge clk100)
      begin
        if ((next_state == S_LO1) || (next_state == S_HI1) || 
            ((next_state == S_LO2) || (next_state == S_HI2))) s_oe_n <= #1 we;
        else s_oe_n <= #1 1'b0;
      end
  reg  [15:0] s_dat_w;

  
  always @(posedge clk100)
      begin
        if (next_state == S_HI1) s_dat_w <= #1 dat_w[31:16];
        else if (next_state == S_LO1) s_dat_w <= #1 dat_w[15:0];
          
      end
  reg  [31:0] s_dat_r;

  
  always @(posedge clk100)
      begin
        if ((next_state == S_LO1) && !we) dat_r[31:16] <= #1 sram_dat_r;
        else if (!we && (next_state == S_FH)) dat_r[15:0] <= #1 sram_dat_r;
          
      end
  reg  s_ack;

  
  always @(posedge clk100 or posedge rst)
      begin
        if (rst) s_ack <= #1 1'b0;
        else if ((state == S_LO2) || (state == S_FH)) s_ack <= #1 1'b1;
        else s_ack <= #1 1'b0;
      end
  assign sram_adr = s_adr;
  assign sram_ce_n = s_ce_n;
  assign sram_we_n = s_we_n;
  assign sram_ub_n = s_ub_n;
  assign sram_lb_n = s_lb_n;
  assign sram_oe_n = s_oe_n;
  assign sram_dat_w = s_dat_w;
  assign ack = s_ack;
  assign err = 1'b0;
endmodule

