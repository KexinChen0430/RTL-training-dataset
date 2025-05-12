
module address_generator(clk,rst_n,strand_offset,strand_idx,strand_length,addr);

  parameter  MEM_ADDR_WIDTH = 24;
  parameter  STRAND_PARAM_WIDTH = 16;
  input  clk;
  input  rst_n;
  input  [(-1)+STRAND_PARAM_WIDTH:0] strand_offset;
  input  [(-1)+STRAND_PARAM_WIDTH:0] strand_idx;
  input  [(-1)+STRAND_PARAM_WIDTH:0] strand_length;
  output reg [(-1)+MEM_ADDR_WIDTH:0] addr;

  
  always @(posedge clk)
      begin
        if (rst_n == 1'b0) 
          begin
            addr = {MEM_ADDR_WIDTH{1'b0}};
          end
        else 
          begin
            if (strand_idx > ((-1)+strand_length)) 
              begin
                addr = (-strand_length)+(strand_offset+strand_idx);
              end
            else 
              begin
                addr = strand_offset+strand_idx;
              end
          end
      end
endmodule

