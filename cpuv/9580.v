module's undeclared outputs)
   reg			data_empty;
   parameter [2:0]
		S_IDLE = 3'b000,
		S_PROC = 3'b010,
		S_WAIT = 3'b100,
   		S_DONE = 3'b111;
   reg [7:0] 	   waddr;
   reg [LZF_WIDTH-1:0] hash;
   reg 		       hwe, hdone;
   reg [2:0]
	     state, state_next;
   output [7:0] data;
   output 	data_valid;
   reg [7:0] 	       data, data_next;
   reg 		       data_valid, data_valid_next;
   reg 		       getn_next, getn_reg;
   always @(posedge clk or posedge rst)
     begin
	if (rst)
	  state <= #1 S_IDLE;
	else
	  state <= #1 state_next;
     end
   always @(posedge clk or posedge rst)
     begin
	if (rst)
	  getn_reg <= #1 1;
	else
	  getn_reg <= #1 getn_next;
     end
   assign m_src_getn = ce ? getn_reg : 'bz;
   reg 	  data_empty_next;
   always @(posedge clk)
     begin
	data_valid <= #1 data_valid_next;
	data <= #1 data_next;
	data_empty <= #1 data_empty_next;
     end
   reg [2:0] 	       iidxL;
   always @(posedge clk or posedge rst)
     begin
	if (rst)
	  iidxL <= #1 0;
	else if (data_valid_next)
	  iidxL <= #1 iidxL + 1;
     end
   always @(posedge clk or posedge rst)
     begin
	if (rst)
	  hdone <= #1 0;
	else if (hdone == 0 && (&waddr))
	  hdone <= #1 1;
     end
   always @(posedge clk or posedge rst)
     begin
	if (rst)
	  waddr <= #1 0;
	else if (hdone == 0)
	  waddr <= #1 waddr + 1'b1;
	else
	  waddr <= #1 data_next;
     end
   always @(posedge clk or posedge rst)
     begin
	if (rst)
	  hwe <= #1 0;
	else if (hdone == 0)
	  hwe <= #1 1;
	else
	  hwe <= #1 data_valid_next;
     end
   always @(ce or fo_full or hdone or iidxL or m_last
	    or src_empty or state)
     begin
	state_next = S_IDLE;
	data_valid_next = 0;
	getn_next = 1;
	data_empty_next = 0;
	case (state)
	  S_IDLE: begin
	     if (hdone && (!src_empty) && ce)
	       state_next = S_PROC;
	     else
	       state_next = S_IDLE;
	  end
	  S_PROC: begin
	     if (m_last) begin
		data_valid_next = 1;
		state_next = S_DONE;
	     end else if (fo_full && (&iidxL)) begin
		data_valid_next = 1;
		state_next = S_WAIT;
	     end else if (src_empty && (!m_last)) begin
		state_next = S_PROC;
	     end else if (iidxL == 3'b110) begin
		data_valid_next = 1;
		state_next = S_PROC;
		getn_next = 0;
	     end else begin
		data_valid_next = 1;
		state_next = S_PROC;
	     end
	  end 
	  S_WAIT: begin
	     if (fo_full)
	       state_next = S_WAIT;
	     else if (!src_empty || m_last) begin
		state_next = S_PROC;
	     end else
	       state_next = S_WAIT;
	  end
	  S_DONE: begin
	     state_next = S_DONE;
	     data_empty_next = 1;
	  end
	endcase 
     end
   always @(fi or iidxL)
     begin
	data_next = 0;
	case (iidxL)
	  3'h0: data_next = fi[07:00];
	  3'h1: data_next = fi[15:08];
	  3'h2: data_next = fi[23:16];
	  3'h3: data_next = fi[31:24];
	  3'h4: data_next = fi[39:32];
	  3'h5: data_next = fi[47:40];
	  3'h6: data_next = fi[55:48];
	  3'h7: data_next = fi[63:56];
	endcase 
     end 
   output [7:0] hash_data, hash_data1;
   output [LZF_WIDTH-1:0] hash_ref;
   output [7:0] 	  data_d1;
   output [7:0] 	  data_d2;
   reg [LZF_WIDTH+15:0] htab [255:0];
   reg [7:0] 	       hash_data, data_d1, data_d2, hash_data1, raddr;
   reg [LZF_WIDTH-1:0] hash_ref;
   output [LZF_WIDTH-1:0] iidx;
   reg [LZF_WIDTH-1:0] iidx;
   always @(posedge clk)
     begin
	if (hwe)
	  htab[waddr] <= #1 {data_next, data_d1, iidx};
	if (data_valid)
	  {hash_data1, hash_data, hash_ref} <= #1 htab[raddr];
     end
   always @(posedge clk)
     begin
	raddr <= #1 data_next;
     end
   always @(posedge clk)
     begin
	if (data_valid)
	  data_d1 <= #1 data;
     end
   output [7:0] hash_d1;
   reg [7:0] hash_d1;
   always @(posedge clk)
     begin
	if (data_valid)
	  hash_d1 <= #1 hash_data1;
     end
   output hash_data_d1;
   reg    hash_data_d1;
   always @(data_d1 or data_valid or hash_d1)
     begin
	if (data_valid)
	  hash_data_d1 = data_d1 == hash_d1;
	else
	  hash_data_d1 = 1'b0;
     end
   always @(posedge clk or posedge rst)
     begin
	if (rst)
	  data_d2 <= #1 0;
	else if (data_valid)
	  data_d2 <= #1 data_d1;
     end
   always @(posedge clk or posedge rst)
     begin
	if (rst)
	  iidx <= #1 0;
	else if (data_valid)
	  iidx <= #1 iidx + 1;
     end
   input [10:0] hraddr;
   output [7:0] hdata;
   reg [7:0] 	hdata;
   reg [10:0] 	hwaddr;
   always @(iidx)
     begin
	hwaddr = iidx[10:0];
     end
   reg [7:0] history[2047:0];
   always @(posedge clk)
     begin
	if (data_valid)
	  history[hwaddr] <= #1 data;
	hdata <= #1 history[hraddr];
     end
endmodule