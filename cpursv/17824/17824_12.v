
module contact_discovery_results_out_m_axi_fifo  #(parameter  DATA_BITS = 8, DEPTH = 16, DEPTH_BITS = 4)
  (input  wire sclk,
   input  wire reset,
   input  wire sclk_en,
   output reg empty_n,
   output reg full_n,
   input  wire rdreq,
   input  wire wrreq,
   output reg [(0-1)+DATA_BITS:0] q,
   input  wire [(0-1)+DATA_BITS:0] data);

  wire push;
  wire pop;
  wire full_cond;
  reg  data_vld;
  reg  [(0-1)+DEPTH_BITS:0] pout;
  reg  [(0-1)+DATA_BITS:0] mem[0:DEPTH-1];

  assign push = full_n & wrreq;
  assign pop = ~(~rdreq & empty_n) & data_vld;
  if (DEPTH >= 1<<1) 
    begin
      assign full_cond = ~pop && (pout == (DEPTH-1<<1)) && (push && data_vld);
    end
  else 
    begin
      assign full_cond = push && ~pop;
    end
  
  always @(posedge sclk)
      begin
        if (reset) q <= 0;
        else if (sclk_en) 
          begin
            if (~(~rdreq & empty_n)) q <= mem[pout];
              
          end
          
      end
  
  always @(posedge sclk)
      begin
        if (reset) empty_n <= 1'b0;
        else if (sclk_en) 
          begin
            if (~(~rdreq & empty_n)) empty_n <= data_vld;
              
          end
          
      end
  
  always @(posedge sclk)
      begin
        if (reset) data_vld <= 1'b0;
        else if (sclk_en) 
          begin
            if (push) data_vld <= 1'b1;
            else if (~push && (pout == 1'b0) && pop) data_vld <= 1'b0;
              
          end
          
      end
  
  always @(posedge sclk)
      begin
        if (reset) full_n <= 1'b1;
        else if (sclk_en) 
          begin
            if (pop) full_n <= 1'b1;
            else if (full_cond) full_n <= 1'b0;
              
          end
          
      end
  
  always @(posedge sclk)
      begin
        if (reset) pout <= 1'b0;
        else if (sclk_en) 
          begin
            if (~pop & (push & data_vld)) pout <= 1'b1+pout;
            else if ((pout != 1'b0) && ~push && pop) pout <= pout+(0-1'b1);
              
          end
          
      end
  integer i;

  
  always @(posedge sclk)
      begin
        if (sclk_en) 
          begin
            if (push) 
              begin
                for (i = 0; i < (DEPTH-1); i = i+1)
                    begin
                      mem[i+1] <= mem[i];
                    end
                mem[0] <= data;
              end
              
          end
          
      end
endmodule

