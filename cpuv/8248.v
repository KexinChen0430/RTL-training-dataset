module sm_txt_crt
  (
   input            start_txt_sm,
   input 	    sync_c_crt_line_end,
   input 	    hreset_n,
   input 	    crt_gnt,
   input 	    svga_ack,
   input 	    mem_clk,
   input 	    text_mode,
   input 	    dum_ff_rd_cnt0,
   input 	    data_complete,
   input [7:0]      c_hde,               
   output           tx_cnt_inc,
   output 	    txt_crt_svga_req,
   output 	    dum_ff_read,
   output 	    enrd_tx_addr,
   output 	    enrd_font_addr,
   output 	    extend_font_addr
   );
  reg [2:0]    tx_cnt_qout;
  reg [3:0]    current_state;
  reg [3:0]    next_state;
  reg [5:0]    char_count;          
  reg          tc_s0, tc_s1;
  reg          tc_s1x, tc_s2;
  reg          tc_s2x, tc_s3;
  reg          tc_s3x, tc_s4;
  reg          tc_s5, tc_s5x;
  reg          tc_s6;
  wire         cpu_rd_reset;
  wire         txt_cnt_0;
  wire         cntx_inc;
  wire         char_done;
  parameter    txt_crt_state0  = 4'b0000,
               txt_crt_state1x = 4'b0001,
	       txt_crt_state2  = 4'b0011,
	       txt_crt_state1  = 4'b0111,
	       txt_crt_state2x = 4'b0010,
	       txt_crt_state3  = 4'b1010,
	       txt_crt_state3x = 4'b1011,
	       txt_crt_state5  = 4'b1111,
	       txt_crt_state4  = 4'b1110,
	       txt_crt_state5x = 4'b1101,
	       txt_crt_state6  = 4'b1100;
  always @ (posedge mem_clk or negedge hreset_n)
    if (!hreset_n)                   char_count <= 6'b0;
    else if (sync_c_crt_line_end)    char_count <= 6'b0;
    else if (tc_s6 && data_complete) char_count <= char_count + 1;
  assign       char_done = {char_count, 3'b0} >= c_hde + 4;
  always @ (posedge mem_clk or negedge hreset_n) begin
    if (~hreset_n)                current_state <= txt_crt_state0;
    else if (sync_c_crt_line_end) current_state <= txt_crt_state0;
    else                          current_state <= next_state;
  end
  always @* begin
    tc_s0    = 1'b0;
    tc_s1    = 1'b0;
    tc_s1x   = 1'b0;
    tc_s2    = 1'b0;
    tc_s2x   = 1'b0;
    tc_s3    = 1'b0;
    tc_s3x   = 1'b0;
    tc_s4    = 1'b0;
    tc_s5    = 1'b0;
    tc_s5x   = 1'b0;
    tc_s6    = 1'b0;
    case (current_state) 
      txt_crt_state0: begin
	tc_s0 = 1'b1;
        if (crt_gnt & start_txt_sm & text_mode && ~char_done)
	  next_state = txt_crt_state1x;
	else
          next_state = txt_crt_state0;
      end
      txt_crt_state1x: begin
	tc_s1x = 1'b1;
	if (svga_ack)
	  next_state = txt_crt_state2;
	else
	  next_state = txt_crt_state1x;
      end
      txt_crt_state2: begin
	tc_s2 = 1'b1;
	if (~txt_cnt_0)
	  next_state = txt_crt_state1;
	else
	  next_state = txt_crt_state2x;
      end
      txt_crt_state1: begin
        tc_s1 = 1'b1;
        if (svga_ack)
          next_state = txt_crt_state2;
	else
	  next_state = txt_crt_state1;
      end
      txt_crt_state2x: begin
	tc_s2x = 1'b1;
	next_state = txt_crt_state3;
      end
      txt_crt_state3: begin
	tc_s3 = 1'b1;
	if (data_complete == 1)
	  next_state = txt_crt_state3x;
	else
	  next_state = txt_crt_state3;
      end
      txt_crt_state3x: begin
        tc_s3x = 1'b1;
        next_state = txt_crt_state5;
      end
      txt_crt_state4: begin
	tc_s4 = 1'b1;
	next_state = txt_crt_state5;
      end
      txt_crt_state5: begin
        tc_s5 = 1'b1;
        if (~dum_ff_rd_cnt0 & svga_ack)
          next_state = txt_crt_state4;
        else if (dum_ff_rd_cnt0 & svga_ack)
	  next_state = txt_crt_state5x;
	else
          next_state = txt_crt_state5;
      end
      txt_crt_state5x: begin
        tc_s5x = 1'b1;
        next_state = txt_crt_state6;
      end
      txt_crt_state6: begin
        tc_s6 = 1'b1;
        if (data_complete)
          next_state = txt_crt_state0;
        else
	  next_state = txt_crt_state6;
      end
    endcase
  end
  assign dum_ff_read = (tc_s4 | tc_s5x);
  assign enrd_tx_addr = (tc_s2 | tc_s2x);
  assign txt_crt_svga_req = (tc_s1x |((tc_s1 | tc_s2) & ~txt_cnt_0) |
                             tc_s3x | (tc_s4 | tc_s5) );
  assign enrd_font_addr = (tc_s4 | tc_s5x);
  assign extend_font_addr = tc_s4 | tc_s5 | tc_s5x;
  assign tx_cnt_inc = (svga_ack & (tc_s2 | tc_s1)) | tc_s2x;
  assign cntx_inc = svga_ack & (tc_s1x | tc_s2 | tc_s1);
  assign txt_cnt_0 = ~|tx_cnt_qout;
  always @ (posedge mem_clk or negedge hreset_n) begin
    if (~hreset_n)                tx_cnt_qout <= 0;
    else if (sync_c_crt_line_end) tx_cnt_qout <= 0;
    else if (cntx_inc)            tx_cnt_qout <= tx_cnt_qout + 1;
  end
endmodule