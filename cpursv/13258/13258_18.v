
module altera_avalon_st_idle_remover(input  clk,
                                     input  reset_n,
                                     output reg in_ready,
                                     input  in_valid,
                                     input  [7:0] in_data,
                                     input  out_ready,
                                     output reg out_valid,
                                     output reg [7:0] out_data);

  reg  received_esc;
  wire escape_char,idle_char;

  assign idle_char = in_data == 8'h4a;
  assign escape_char = in_data == 8'h4d;
  
  always @(posedge clk or negedge reset_n)
      begin
        if (!reset_n) 
          begin
            received_esc <= 0;
          end
        else 
          begin
            if (in_ready & in_valid) 
              begin
                if (escape_char & ~received_esc) 
                  begin
                    received_esc <= 1;
                  end
                else if (out_valid) 
                  begin
                    received_esc <= 0;
                  end
                  
              end
              
          end
      end
  
  always @* 
      begin
        in_ready = out_ready;
        out_valid = (~idle_char & in_valid) & (received_esc | ~escape_char);
        out_data = received_esc ? ((((((~in_data & 8'h20) | in_data) & (8'h20 & (~in_data | ~8'h20))) & (in_data | ~in_data)) & (in_data | ~in_data)) ^ ((in_data | ~in_data) & ((((~in_data | ~8'h20) & in_data) & ((~in_data & 8'h20) | in_data)) & (in_data | ~in_data)))) : in_data;
      end
endmodule

