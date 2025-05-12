module or1200_pic(
    clk, rst, spr_cs, spr_write, spr_addr, spr_dat_i, spr_dat_o,
    pic_wakeup, intr,
    pic_int
);
input       clk;        
input       rst;        
input       spr_cs;     
input       spr_write;  
input   [31:0]  spr_addr;   
input   [31:0]  spr_dat_i;  
output  [31:0]  spr_dat_o;  
output      pic_wakeup; 
output      intr;       
input   [`OR1200_PIC_INTS-1:0] pic_int; 
`ifdef OR1200_PIC_IMPLEMENTED
`ifdef OR1200_PIC_PICMR
reg [`OR1200_PIC_INTS-1:2] picmr; 
`else
wire [`OR1200_PIC_INTS-1:2] picmr; 
`endif
`ifdef OR1200_PIC_PICSR
reg [`OR1200_PIC_INTS-1:0] picsr; 
`else
wire [`OR1200_PIC_INTS-1:0] picsr; 
`endif
wire    picmr_sel;   
wire    picsr_sel;   
wire    [`OR1200_PIC_INTS-1:0] um_ints; 
reg [31:0]   spr_dat_o;   
assign picmr_sel = (spr_cs && (spr_addr[`OR1200_PICOFS_BITS] == `OR1200_PIC_OFS_PICMR)) ? 1'b1 : 1'b0;
assign picsr_sel = (spr_cs && (spr_addr[`OR1200_PICOFS_BITS] == `OR1200_PIC_OFS_PICSR)) ? 1'b1 : 1'b0;
`ifdef OR1200_PIC_PICMR
always @(posedge clk or posedge rst)
    if (rst)
        picmr <= {1'b1, {`OR1200_PIC_INTS-3{1'b0}}}; 
    else if (picmr_sel && spr_write) begin
        picmr <= #1 spr_dat_i[`OR1200_PIC_INTS-1:2]; 
    end
`else
assign picmr = (`OR1200_PIC_INTS)'b1; 
`endif
`ifdef OR1200_PIC_PICSR
always @(posedge clk or posedge rst)
    if (rst)
        picsr <= {`OR1200_PIC_INTS{1'b0}}; 
    else if (picsr_sel && spr_write) begin
        picsr <= #1 spr_dat_i[`OR1200_PIC_INTS-1:0] | um_ints; 
    end else
        picsr <= #1 picsr | um_ints; 
`else
assign picsr = pic_int; 
`endif
always @(spr_addr or picmr or picsr)
    case (spr_addr[`OR1200_PICOFS_BITS])   
`ifdef OR1200_PIC_READREGS
        `OR1200_PIC_OFS_PICMR: begin
                    spr_dat_o[`OR1200_PIC_INTS-1:0] = {picmr, 2'b0}; 
`ifdef OR1200_PIC_UNUSED_ZERO
                    spr_dat_o[31:`OR1200_PIC_INTS] = {32-`OR1200_PIC_INTS{1'b0}}; 
`endif
                end
`endif
        default: begin
                spr_dat_o[`OR1200_PIC_INTS-1:0] = picsr; 
`ifdef OR1200_PIC_UNUSED_ZERO
                spr_dat_o[31:`OR1200_PIC_INTS] = {32-`OR1200_PIC_INTS{1'b0}}; 
`endif
            end
    endcase
assign um_ints = pic_int & {picmr, 2'b11};
assign intr = |um_ints;
assign pic_wakeup = intr;
`else
assign intr = pic_int[1] | pic_int[0];
assign pic_wakeup = intr;
`ifdef OR1200_PIC_READREGS
assign spr_dat_o[`OR1200_PIC_INTS-1:0] = `OR1200_PIC_INTS'b0;
`ifdef OR1200_PIC_UNUSED_ZERO
assign spr_dat_o[31:`OR1200_PIC_INTS] = 32-`OR1200_PIC_INTS'b0;
`endif
`endif
`endif
endmodule 