
module my_fifo  #(parameter  max_len = 16, len_wd = 4, entry_wd = 32)
  (input  wire clk,rst,
   input  wire rd,wr,
   input  wire [(-1)+entry_wd:0] data_in,
   output wire full,empty,
   output wire [(-1)+entry_wd:0] data_out,
   output reg [len_wd+(-1):0] len);

  reg  [(-1)+entry_wd:0] reg_ram[max_len-1:0];
  reg  [len_wd:0] rd_ptr,wr_ptr;

  assign full = len == max_len;
  assign empty = len == 0;
  assign data_out = reg_ram[rd_ptr];
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            len <= #5 0;
            rd_ptr <= #5 0;
            wr_ptr <= #5 0;
          end
        else 
          begin
            if ((rd_ptr != wr_ptr) && (wr && rd)) 
              begin
                if (rd_ptr == (max_len-1)) 
                  begin
                    rd_ptr <= #5 {len_wd{1'b0}};
                  end
                else 
                  begin
                    rd_ptr <= #5 {{len_wd+(-1){1'b0}},1'b1}+rd_ptr;
                  end
                if (wr_ptr == (max_len-1)) 
                  begin
                    wr_ptr <= #5 {len_wd{1'b0}};
                  end
                else 
                  begin
                    wr_ptr <= #5 {{len_wd+(-1){1'b0}},1'b1}+wr_ptr;
                  end
              end
            else if (!empty && rd) 
              begin
                len <= #5 len-{{len_wd+(-1){1'b0}},1'b1};
                if (rd_ptr == (max_len-1)) 
                  begin
                    rd_ptr <= #5 {len_wd{1'b0}};
                  end
                else 
                  begin
                    rd_ptr <= #5 {{len_wd+(-1){1'b0}},1'b1}+rd_ptr;
                  end
              end
            else if (!full && wr) 
              begin
                len <= #5 {{len_wd+(-1){1'b0}},1'b1}+len;
                if (wr_ptr == (max_len-1)) 
                  begin
                    wr_ptr <= #5 {len_wd{1'b0}};
                  end
                else 
                  begin
                    wr_ptr <= #5 {{len_wd+(-1){1'b0}},1'b1}+wr_ptr;
                  end
              end
              
          end
      end
  
  always @(posedge clk)
      begin
        if (!rst && 
            (
(wr && 
(rd && 
(((wr || (rd_ptr != wr_ptr)) && !full) || 
(rd_ptr != wr_ptr))) && ((rd || ((!full || rd) && wr)) && wr)) || (!full && wr))) 
          begin
            reg_ram[wr_ptr] <= #5 data_in;
          end
          
      end
endmodule

