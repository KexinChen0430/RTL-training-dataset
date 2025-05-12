
module contact_discovery_results_out_m_axi_fifo  #(parameter  DATA_BITS = 8, DEPTH = 16, DEPTH_BITS = 4)
  (input  wire sclk,
   input  wire reset,
   input  wire sclk_en,
   output reg empty_n,
   output reg full_n,
   input  wire rdreq,
   input  wire wrreq,
   output reg [DATA_BITS-1:0] q,
   input  wire [DATA_BITS-1:0] data);

  wire push;
  wire pop;
  wire full_cond;
  reg  data_vld;
  reg  [DEPTH_BITS-1:0] pout;
  reg  [DATA_BITS-1:0] mem[0:DEPTH+(0-1)];

  assign push = wrreq & full_n;
  assign pop = ~(~rdreq & empty_n) & data_vld;
  if (DEPTH >= 1<<1) 
    begin
      assign full_cond = data_vld && ~pop && (push && (pout == (DEPTH-1<<1)));
    end
  else 
    begin
      assign full_cond = ~pop && push;
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
            else if (pop && (~push && (pout == 1'b0))) data_vld <= 1'b0;
              
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
            if (push & (data_vld & ~pop)) pout <= 1'b1+pout;
            else if (~push && (pop && (pout != 1'b0))) pout <= pout-1'b1;
              
          end
          
      end
  integer i;

  
  always @(posedge sclk)
      begin
        if (sclk_en) 
          begin
            if (push) 
              begin
                for (i = 0; i < (DEPTH+(0-1)); i = i+1)
                    begin
                      mem[i+1] <= mem[i];
                    end
                mem[0] <= data;
              end
              
          end
          
      end
endmodule

