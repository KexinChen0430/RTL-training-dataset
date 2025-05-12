
module soc_system_master_secure_timing_adt(input  clk,
                                           input  reset_n,
                                           input  in_valid,
                                           input  [7:0] in_data,
                                           output reg out_valid,
                                           output reg [7:0] out_data,
                                           input  out_ready);

  reg  [7:0] in_payload;
  reg  [7:0] out_payload;
  reg  ready;
  reg  in_ready;

  
  always @(negedge in_ready)
      begin
        $display("%m: The downstream component is backpressuring by deasserting ready, but the upstream component can't be backpressured.");
      end
  
  always @* 
      begin
        in_payload = {in_data};
        {out_data} = out_payload;
      end
  
  always @* 
      begin
        ready[0] = out_ready;
        out_valid = in_valid;
        out_payload = in_payload;
        in_ready = ready[0];
      end
endmodule

