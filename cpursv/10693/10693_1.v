
module synchronizer_flop(data_in,clk_out,sync_data_out,async_reset);

  parameter  width = 1;
  parameter  reset_val = 0;
  input  [(0-1)+width:0] data_in;
  input  clk_out;
  output [(0-1)+width:0] sync_data_out;
  input  async_reset;
  reg  [(0-1)+width:0] sync_data_out;

  
  always @(posedge clk_out or posedge async_reset)
      begin
        if (async_reset == 1'b1) 
          begin
            sync_data_out <= reset_val;
          end
        else 
          begin
            sync_data_out <= data_in;
          end
      end
endmodule

