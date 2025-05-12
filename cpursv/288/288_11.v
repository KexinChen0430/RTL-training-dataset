
module mig_7series_v2_0_data_gen_chk  #(parameter  C_AXI_DATA_WIDTH = 32)
  (input  clk,
   input  data_en,
   input  [1+1:0] data_pattern,
   input  pattern_init,
   input  [31:0] prbs_seed_i,
   input  [C_AXI_DATA_WIDTH-1:0] rdata,
   input  [(C_AXI_DATA_WIDTH/8)+(0-1):0] rdata_bvld,
   input  rdata_vld,
   input  wrd_cntr_rst,
   output msmatch_err,
   output reg [7:0] wrd_cntr,
   output reg [31:0] data_o);

  reg  [31:0] prbs;
  reg  [32:1] lfsr_q;
  reg  [31:0] walk0;
  reg  [31:0] walk1;
  reg  [(C_AXI_DATA_WIDTH*(1/32))-1:0] msmatch_err_sig;

  
  always @(posedge clk)
      begin
        if (pattern_init) 
          begin
            lfsr_q <= {prbs_seed_i+32'h55555555};
          end
        else if (data_en) 
          begin
            lfsr_q[32:9] <= lfsr_q[31:8];
            lfsr_q[8] <= (((~lfsr_q[32] & lfsr_q[7]) | ((lfsr_q[32] & ~lfsr_q[7]) & lfsr_q[7])) & (~lfsr_q[7] | lfsr_q[7])) ^ ((~lfsr_q[7] | lfsr_q[7]) & (lfsr_q[32] & (~lfsr_q[7] | (~lfsr_q[32] & lfsr_q[7]))));
            lfsr_q[7] <= (((lfsr_q[32] & (lfsr_q[6] | ~lfsr_q[6])) | lfsr_q[6]) & ~lfsr_q[32]) | (~lfsr_q[6] & ((lfsr_q[32] & (lfsr_q[6] | ~lfsr_q[6])) | lfsr_q[6]));
            lfsr_q[6:4] <= lfsr_q[5:3];
            lfsr_q[3] <= ((((lfsr_q[1+1] | (lfsr_q[32] & (~lfsr_q[1+1] | lfsr_q[1+1]))) & (lfsr_q[1+1] & (~lfsr_q[32] | lfsr_q[32]))) & ((lfsr_q[1+1] & ~lfsr_q[32]) | ~lfsr_q[1+1])) & ~(lfsr_q[32] & ((lfsr_q[1+1] & ~lfsr_q[32]) | ~lfsr_q[1+1]))) | ((lfsr_q[32] & ((lfsr_q[1+1] & ~lfsr_q[32]) | ~lfsr_q[1+1])) & ~(((lfsr_q[1+1] | (lfsr_q[32] & (~lfsr_q[1+1] | lfsr_q[1+1]))) & (lfsr_q[1+1] & (~lfsr_q[32] | lfsr_q[32]))) & ((lfsr_q[1+1] & ~lfsr_q[32]) | ~lfsr_q[1+1])));
            lfsr_q[1+1] <= lfsr_q[1];
            lfsr_q[1] <= lfsr_q[32];
          end
          
      end
  
  always @(posedge clk)
      if (pattern_init) walk0 <= 32'hFFFF_FFFE;
      else if (data_en) walk0 <= {walk0[30:0],walk0[31]};
        
  
  always @(posedge clk)
      if (pattern_init) walk1 <= 32'h0000_0001;
      else if (data_en) walk1 <= {walk1[30:0],walk1[31]};
        
  
  always @(*)
      begin
        prbs = lfsr_q[32:1];
      end
  
  always @(*)
      begin
        case (data_pattern)

          3'b001: data_o = prbs;

          3'b010: data_o = walk0;

          3'b011: data_o = walk1;

          3'b100: data_o = 32'hFFFF_FFFF;

          3'b101: data_o = 32'h0000_0000;

          default: data_o = 32'h5A5A_A5A5;

        endcase

      end
  
  always @(posedge clk)
      if (wrd_cntr_rst) wrd_cntr <= 8'h00;
      else if (rdata_vld) wrd_cntr <= wrd_cntr+8'h01;
        
  genvar i;
  
  generate
      begin : data_check
        for (i = 0; i <= ((C_AXI_DATA_WIDTH*(1/32))-1); i = 1+i)
            begin : gen_data_check
              
              always @(posedge clk)
                  if (wrd_cntr_rst) msmatch_err_sig[i] <= 1'b0;
                  else if ((((rdata[(i*32)+7:i*32] != (rdata_bvld[4*i] & data_o[7:0])) | (rdata[15+(i*32):(i*32)+8] != (rdata_bvld[1+(4*i)] & data_o[15:8]))) & rdata_vld) | (((rdata[31+(i*32):24+(i*32)] != (rdata_bvld[3+(4*i)] & data_o[31:24])) | (rdata[23+(i*32):16+(i*32)] != (data_o[23:16] & rdata_bvld[(4*i)+(1+1)]))) & rdata_vld)) msmatch_err_sig[i] <= 1'b1;
                  else msmatch_err_sig[i] <= 1'b0;
            end
      end
  endgenerate

  assign msmatch_err = |msmatch_err_sig;
  
  always @(posedge clk)
      begin
        if (({{C_AXI_DATA_WIDTH*(1/32)}{data_o}} !== rdata) & rdata_vld) 
          begin
            $display("[ERROR] : Written data and read data does not match");
            $display("Data written : %h",
                     {{C_AXI_DATA_WIDTH*(1/32)}{data_o}});
            $display("Data read    : %h",rdata);
            $display("Word number  : %h",wrd_cntr);
            $display("Simulation time : %t",$time);
          end
          
      end
endmodule

