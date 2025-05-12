module bw_r_tlb_tag_ram( 
	rd_tag, 
	rw_index_vld, 
	wr_vld_tmp, 
	clk, 
	rw_index, 
	tlb_index, 
	tlb_index_vld, 
	rw_disable, 
	rst_tri_en, 
	wr_tte_tag, 
	tlb_entry_vld, 
	tlb_entry_used, 
	tlb_entry_locked, 
	rd_tte_tag, 
	mismatch, 
	tlb_writeable, 
	wr_vld, 
	cam_vld, 
	cam_data, 
	cam_hit, 
	cam_pid, 
	demap_all, 
	demap_other, 
	demap_hit); 
input rd_tag; 
input rw_index_vld; 
input wr_vld_tmp; 
input clk; 
input [`TLB_INDEX_WIDTH-1:0] rw_index; 
input [`TLB_INDEX_WIDTH-1:0] tlb_index; 
input tlb_index_vld; 
input rw_disable; 
input rst_tri_en; 
input [58:0] wr_tte_tag; 
input [`TLB_ENTRIES-1:0] tlb_entry_vld; 
input tlb_writeable; 
input wr_vld; 
input [2:0] cam_pid; 
input demap_all; 
input demap_other; 
input [53:0] cam_data; 
input cam_vld ; 
output [`TLB_ENTRIES-1:0] cam_hit ; 
output [`TLB_ENTRIES-1:0] demap_hit ; 
output [`TLB_ENTRIES-1:0] tlb_entry_used; 
output [`TLB_ENTRIES-1:0] tlb_entry_locked; 
reg [`TLB_ENTRIES-1:0] tlb_entry_locked ; 
output [58:0] rd_tte_tag; 
reg [58:0] rd_tte_tag; 
output [`TLB_ENTRIES-1:0] mismatch; 
reg [`TLB_ENTRIES-1:0] sat; 
reg [`TLB_ENTRIES-1:0] mismatch; 
reg [`TLB_ENTRIES-1:0] cam_hit ; 
reg [`TLB_ENTRIES-1:0] demap_all_but_locked_hit ; 
reg [58:0] tag ; 
reg [`TLB_ENTRIES-1:0] mismatch_va_b47_28; 
reg [`TLB_ENTRIES-1:0] mismatch_va_b27_22; 
reg [`TLB_ENTRIES-1:0] mismatch_va_b21_16; 
reg [`TLB_ENTRIES-1:0] mismatch_va_b15_13; 
reg [`TLB_ENTRIES-1:0] mismatch_ctxt; 
reg [`TLB_ENTRIES-1:0] mismatch_pid; 
reg [`TLB_ENTRIES-1:0] mismatch_type; 
reg [`TLB_ENTRIES-1:0] tlb_entry_used ; 
integer i,j,n,m, w, p, k, s, t; 
reg [58:0] tte_tag_ram  [`TLB_ENTRIES-1:0]  ; 
reg [58:0] tmp_tag ; 
wire wren = rw_index_vld & wr_vld_tmp & ~rw_disable; 
wire tlben = tlb_index_vld & ~rw_index_vld & wr_vld_tmp & ~rw_disable; 
wire  [`TLB_INDEX_WIDTH-1:0] wr_addr = wren ? rw_index : tlb_index; 
always @ (negedge clk) begin 
	if(wren | tlben) begin 
		tte_tag_ram[wr_addr] <= wr_tte_tag[58:0]; 
		tlb_entry_used[wr_addr] <= wr_tte_tag[`STLB_TAG_U]; 
		tlb_entry_locked[wr_addr] = wr_tte_tag[`STLB_TAG_L]; 
	end else begin
	  tlb_entry_used <= (tlb_entry_used | cam_hit) & (tlb_entry_locked | ~{`TLB_ENTRIES{~tlb_writeable & ~cam_vld & ~wr_vld & ~rd_tag & ~rst_tri_en}}) ; 
        end
	if(rd_tag & ~rw_disable) begin 
		tmp_tag  <= tte_tag_ram[rw_index]; 
	end
end 
always @(posedge clk) begin 
  if(rd_tag & ~rw_disable) 
    rd_tte_tag[58:0] = {tmp_tag[58:27], tlb_entry_vld[rw_index], tlb_entry_locked[rw_index], tlb_entry_used[rw_index], tmp_tag[23:0]}; 
  else if(wren | tlben) 
    rd_tte_tag[58:0] = wr_tte_tag[58:0]; 
end 
reg [58:0] tte_tag_ram2  [`TLB_ENTRIES-1:0]; 
always @ (negedge clk) begin 
  if(wren | tlben) 
    tte_tag_ram2[wr_addr] <= wr_tte_tag[58:0]; 
end 
always @ (cam_data or cam_pid or cam_vld or demap_all
           or demap_other or tlb_entry_vld) 
	begin
		for (n=0;n<`TLB_ENTRIES;n=n+1) 
			begin
			tag[58:0] = tte_tag_ram2[n] ; 
			mismatch_va_b47_28[n] = 
			(tag[`STLB_TAG_VA_47_28_HI:`STLB_TAG_VA_47_28_LO]
			!= cam_data[`CAM_VA_47_28_HI+13:`CAM_VA_47_28_LO+13]);
			mismatch_va_b27_22[n] = 
			(tag[`STLB_TAG_VA_27_22_HI:`STLB_TAG_VA_27_22_LO]
			!= cam_data[`CAM_VA_27_22_HI+13:`CAM_VA_27_22_LO+13]);
			mismatch_va_b21_16[n] = 
			(tag[`STLB_TAG_VA_21_16_HI:`STLB_TAG_VA_21_16_LO]
			!= cam_data[`CAM_VA_21_16_HI+13:`CAM_VA_21_16_LO+13]) ;
			mismatch_va_b15_13[n] = 
			(tag[`STLB_TAG_VA_15_13_HI:`STLB_TAG_VA_15_13_LO]
			!= cam_data[`CAM_VA_15_13_HI+13:`CAM_VA_15_13_LO+13]) ;
			mismatch_ctxt[n] = 
			(tag[`STLB_TAG_CTXT_12_0_HI:`STLB_TAG_CTXT_12_0_LO]
			!= cam_data[`CAM_CTXT_12_0_HI:`CAM_CTXT_12_0_LO]) ;
			mismatch_pid[n] = (tag[`STLB_TAG_PID_HI:`STLB_TAG_PID_LO] != cam_pid[2:0]) ; 
			mismatch_type[n] = (tag[`STLB_TAG_R] ^ cam_data[`CAM_REAL_V+13]); 
			mismatch[n] = 
			(mismatch_va_b47_28[n] & cam_data[`CAM_VA_47_28_V+13]) 				|
			(mismatch_va_b27_22[n] & tag[`STLB_TAG_VA_27_22_V] & cam_data[`CAM_VA_27_22_V+13]) 	|
			(mismatch_va_b21_16[n] & tag[`STLB_TAG_VA_21_16_V] & cam_data[`CAM_VA_21_16_V+13]) 	|
			(mismatch_va_b15_13[n] & tag[`STLB_TAG_VA_15_13_V] & cam_data[`CAM_VA_15_13_V+13]) 	|
			(mismatch_ctxt[n] & ~cam_data[`CAM_CTXT_GK+13])	|
			(mismatch_type[n] & ~demap_all)  	|
			mismatch_pid[n] ;	
			demap_all_but_locked_hit[n] = ~tag[`STLB_TAG_L] & demap_all ; 
			cam_hit[n] 	= ~mismatch[n] & cam_vld   & tlb_entry_vld[n] ; 
		end
	end  
	assign demap_hit = demap_all ? ~mismatch & demap_all_but_locked_hit & tlb_entry_vld & {`TLB_ENTRIES{demap_other}}
				     : ~mismatch & tlb_entry_vld & {`TLB_ENTRIES{demap_other}}; 
endmodule 