
module hls_saturation_enbkb_div_u  #(parameter  in0_WIDTH = 32, in1_WIDTH = 32, out_WIDTH = 32)
  (input  clk,
   input  reset,
   input  ce,
   input  [(0-1)+in0_WIDTH:0] dividend,
   input  [in1_WIDTH-1:0] divisor,
   output wire [(0-1)+out_WIDTH:0] quot,
   output wire [(0-1)+out_WIDTH:0] remd);

  localparam 
       cal_WIDTH = (in0_WIDTH > in1_WIDTH) ? in0_WIDTH : in1_WIDTH;
  reg  [(0-1)+in0_WIDTH:0] dividend_tmp[0:in0_WIDTH];
  reg  [in1_WIDTH-1:0] divisor_tmp[0:in0_WIDTH];
  reg  [(0-1)+in0_WIDTH:0] remd_tmp[0:in0_WIDTH];
  wire [(0-1)+in0_WIDTH:0] comb_tmp[0:(0-1)+in0_WIDTH];
  wire [cal_WIDTH:0] cal_tmp[0:(0-1)+in0_WIDTH];

  assign quot = dividend_tmp[in0_WIDTH];
  assign remd = remd_tmp[in0_WIDTH];
  
  always @(posedge clk)
      begin
        if (ce) 
          begin
            dividend_tmp[0] <= dividend;
            divisor_tmp[0] <= divisor;
            remd_tmp[0] <= 1'b0;
          end
          
      end
  genvar i;
  
  generate
      for (i = 0; i < in0_WIDTH; i = 1+i)
          begin : loop
            if (in0_WIDTH == 1) assign comb_tmp[i] = dividend_tmp[i][0];
            else 
              assign comb_tmp[i] = {remd_tmp[i][in0_WIDTH-1<<1:0],dividend_tmp[i][(0-1)+in0_WIDTH]};
            assign cal_tmp[i] = {1'b0,comb_tmp[i]}-{1'b0,divisor_tmp[i]};
            
            always @(posedge clk)
                begin
                  if (ce) 
                    begin
                      if (in0_WIDTH == 1) dividend_tmp[1+i] <= ~cal_tmp[i][cal_WIDTH];
                      else 
                        dividend_tmp[1+i] <= {dividend_tmp[i][in0_WIDTH-1<<1:0],~cal_tmp[i][cal_WIDTH]};
                      divisor_tmp[1+i] <= divisor_tmp[i];
                      remd_tmp[1+i] <= cal_tmp[i][cal_WIDTH] ? comb_tmp[i] : cal_tmp[i][(0-1)+in0_WIDTH:0];
                    end
                    
                end
          end
  endgenerate

endmodule

