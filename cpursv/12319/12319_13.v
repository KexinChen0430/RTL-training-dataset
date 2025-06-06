
module axi_traffic_gen_v2_0_7_ex_fifo  #(parameter 
       WIDTH        = 10,
       DEPTH        = 8,
       DEPTHBITS    = 3,
       HEADREG      = 1,
       ZERO_INVALID = 0,
       FULL_LEVEL   = 6,
       BLOCK_ACTIVE = 0)
  (input  Clk,
   input  rst_l,
   input  [(0-1)+WIDTH:0] in_data,
   input  in_push,
   input  in_pop,
   output [(0-1)+WIDTH:0] out_data,
   output is_full,
   output is_notfull,
   output is_empty,
   output out_valid,
   output [15:0] ex_fifo_dbgout);

  reg  [(0-1)+WIDTH:0] data_ff[(0-1)+DEPTH:0];
  reg  [(0-1)+DEPTHBITS:0] out_ptr_ff;
  reg  [(0-1)+DEPTHBITS:0] in_ptr_ff;
  reg  [DEPTHBITS:0] depth_ff;
  reg  [(0-1)+WIDTH:0] headreg_ff;
  reg  full_ff,notfull_ff,valid_ff,valid_filt_ff;
  wire [(0-1)+DEPTHBITS:0] 
       in_ptr = in_push ? ('h1+in_ptr_ff[(0-1)+DEPTHBITS:0]) : in_ptr_ff[(0-1)+DEPTHBITS:0];
  wire [DEPTHBITS:0] 
       depth = (in_push && ~in_pop) ? (depth_ff[DEPTHBITS:0]+'h1) : 
(~in_push && in_pop) ? (depth_ff[DEPTHBITS:0]-'h1) : depth_ff[DEPTHBITS:0];
  wire  depth_was1 = depth_ff[DEPTHBITS:0] == 'h1;
  wire  valid = depth[DEPTHBITS:0] != 'h0;
  wire full;

  
  generate
      if (BLOCK_ACTIVE == 1) 
        begin : BLOCK_ACTIVE_FULL_YES

        end
        
  endgenerate

  
  generate
      if (BLOCK_ACTIVE == 0) 
        begin : BLOCK_ACTIVE_FULL_NO
          assign full = depth[DEPTHBITS:0] >= FULL_LEVEL;
        end
        
  endgenerate

  wire  notfull = ~full;

  wire [(0-1)+WIDTH:0]  raw_data = data_ff[out_ptr_ff[(0-1)+DEPTHBITS:0]];

  wire [(0-1)+DEPTHBITS:0] 
       out_ptr = in_pop ? (out_ptr_ff[(0-1)+DEPTHBITS:0]+'h1) : out_ptr_ff[(0-1)+DEPTHBITS:0];

  wire [(0-1)+WIDTH:0] 
       head_raw_data = depth_was1 ? in_data[(0-1)+WIDTH:0] : raw_data[(0-1)+WIDTH:0];

  wire [(0-1)+WIDTH:0] 
       headreg = (in_push && !valid_ff) ? in_data[(0-1)+WIDTH:0] : 
in_pop ? head_raw_data[(0-1)+WIDTH:0] : headreg_ff[(0-1)+WIDTH:0];

  wire valid_filt;

  
  generate
      if (BLOCK_ACTIVE == 1) 
        begin : BLOCK_ACTIVE_VALID_YES

        end
        
  endgenerate

  
  generate
      if (BLOCK_ACTIVE == 0) 
        begin : BLOCK_ACTIVE_VALID_NO
          assign valid_filt = valid;
        end
        
  endgenerate

  
  always @(posedge Clk)
      begin
        in_ptr_ff[(0-1)+DEPTHBITS:0] <= rst_l ? in_ptr[(0-1)+DEPTHBITS:0] : {DEPTHBITS{1'b0}};
        out_ptr_ff[(0-1)+DEPTHBITS:0] <= rst_l ? out_ptr[(0-1)+DEPTHBITS:0] : 
                                        HEADREG ? {{(0-1)+DEPTHBITS{1'b0}},{1'b1}} : {DEPTHBITS{1'b0}};
        depth_ff[DEPTHBITS:0] <= rst_l ? depth[DEPTHBITS:0] : {DEPTHBITS{1'b0}};
        valid_ff <= rst_l ? valid : 1'b0;
        valid_filt_ff <= rst_l ? valid_filt : 1'b0;
        full_ff <= rst_l ? full : 1'b1;
        notfull_ff <= rst_l ? notfull : 1'b0;
        headreg_ff[(0-1)+WIDTH:0] <= rst_l ? headreg[(0-1)+WIDTH:0] : {WIDTH{1'b0}};
      end
  integer i;

  
  always @(posedge Clk)
      begin
        if (in_push) 
          begin
            data_ff[in_ptr_ff[(0-1)+DEPTHBITS:0]] <= in_data[(0-1)+WIDTH:0];
          end
          
      end
  assign out_data[(0-1)+WIDTH:0] = (ZERO_INVALID && ~valid_filt_ff) ? {WIDTH{1'b0}} : 
                                   HEADREG ? headreg_ff[(0-1)+WIDTH:0] : raw_data[(0-1)+WIDTH:0];
  assign out_valid = valid_filt_ff;
  assign is_full = full_ff;
  assign is_notfull = notfull_ff;
  assign is_empty = ~valid_ff;
  assign ex_fifo_dbgout = 16'b0 | depth_ff;
endmodule

