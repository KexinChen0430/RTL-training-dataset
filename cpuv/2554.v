module clk_gen
  (
   input            hb_clk,
   input            hb_resetn,
   input            pll_locked,
   input [1:0]      bpp,
   input [13:0]     hactive_regist,
   input [2:0]      pixclksel,
   input            vga_mode,
   input [1:0]	    int_fs,
   input 	    sync_ext,
   input            pix_clk,
   output           pix_clk_vga,
   output reg       crt_clk,
   output reg       locked,
   output reg [2:0] 	    int_clk_sel   
   );
  reg [2:0]	    horiz_actv_decode;
  reg [2:0] 	    current, next; 
  reg 		    set_clock; 
  reg [1:0] 	    int_crt_divider; 
  reg [5:0] 	    counter;
  reg [7:0] 	    neg_enable;
  reg [7:0] 	    neg_enable_0;
  reg [7:0] 	    neg_enable_1;
  reg [1:0] 	    crt_count0;
  reg [1:0] 	    crt_count1;
  reg [1:0] 	    crt_count2;
  reg [1:0] 	    crt_count3;
  reg [1:0] 	    crt_count4;
  reg [1:0] 	    crt_count5;
  reg [1:0] 	    crt_count6;
  reg [1:0] 	    crt_count7;
  reg [2:0] 	    crt_counter;
  reg [1:0]         crt_divider;
  reg [2:0]         clk_sel;
  wire [7:0] 	    gated_clocks;
  parameter 	    IDLE          = 3'b000,
		    ENABLE_CLOCK  = 3'b001,
		    WAIT4CHANGE   = 3'b010,
		    WAIT4QUIET    = 3'b011,
		    WAIT4QUIET2   = 3'b100;
wire int_fs_1 = int_fs[1];
`include "hres_table_4clk.h"
always @*
	begin
   		casex({vga_mode, bpp})
   		3'b1_xx: crt_divider = 2'b00;
   		3'b0_01: crt_divider = 2'b10;
   		3'b0_10: crt_divider = 2'b01;
   		default: crt_divider = 2'b00;
		endcase
	end
always @*
	begin
   		casex({vga_mode, pixclksel, sync_ext, int_fs_1})
		6'b1_001_0_x:		clk_sel = 3'b001; 
		6'b1_100_0_x:		clk_sel = 3'b001;
		6'b1_001_1_x:		clk_sel = 3'b010; 
		6'b1_100_1_x:		clk_sel = 3'b010;
		6'b1_011_x_0:		clk_sel = 3'b001; 
		6'b1_101_x_0:		clk_sel = 3'b001;
		6'b1_011_x_1:		clk_sel = 3'b010; 
		6'b1_101_x_1:		clk_sel = 3'b010;
		default:		clk_sel = horiz_actv_decode;
		endcase
	end
  always @(posedge hb_clk or negedge hb_resetn)
    if (!hb_resetn) begin
      current     <= IDLE;
      int_clk_sel <= 3'b0;
      locked      <= 1'b0;
    end else begin
      locked <= current == IDLE;
      current <= next;
      if (set_clock) begin
	int_clk_sel <= clk_sel;
	int_crt_divider <= crt_divider;
      end
      if (current == WAIT4CHANGE || current == IDLE)
	counter <= 6'h0;
      else if (current == WAIT4QUIET ||
	       current == WAIT4QUIET2)
	counter <= counter + 6'h1;
    end
  always @* begin
    set_clock = 1'b0;
    next = current;
    case (current)
      IDLE: begin
	if (pll_locked) begin
	  next = WAIT4QUIET;
	end else
          next = IDLE;
      end
      ENABLE_CLOCK: begin
	next = WAIT4CHANGE;
      end
      WAIT4CHANGE: begin
	if ((clk_sel != int_clk_sel) || (crt_divider != int_crt_divider)) begin
	  next = WAIT4QUIET;
	end else
	  next = WAIT4CHANGE;
      end
      WAIT4QUIET: begin
	if (&counter[4:0]) begin
	  next = WAIT4QUIET2;
	  set_clock = 1'b1;
	end else
          next = WAIT4QUIET;
      end
      WAIT4QUIET2: begin
	if (&counter) begin
	  next = ENABLE_CLOCK;
	end else
          next = WAIT4QUIET2;
      end
    endcase 
  end
  always @(posedge pix_clk or negedge hb_resetn)
	begin
		if(!hb_resetn)
			begin
      				crt_clk <= 1'b1;
    				crt_counter <= 3'b000;
			end
		else begin
    				crt_counter <= crt_counter + 3'h1;
    				case (int_crt_divider)
      				0: crt_clk <= 1'b1;
      				1: crt_clk <= ~crt_counter[0];
      				2: crt_clk <= ~|crt_counter[1:0];
      				3: crt_clk <= ~|crt_counter[2:0];
    				endcase 
		end
  	end
endmodule