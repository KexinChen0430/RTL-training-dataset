
module debounce(clk,reset_n,data_in,data_out);

  parameter  WIDTH = 32;
  parameter  POLARITY = HIGH;
  parameter  TIMEOUT = 50000;
  parameter  TIMEOUT_WIDTH = 16;
  input  wire clk;
  input  wire reset_n;
  input  wire [WIDTH-1:0] data_in;
  output wire [WIDTH-1:0] data_out;
  reg  [TIMEOUT_WIDTH-1:0] counter[0:WIDTH-1];
  wire counter_reset[0:WIDTH-1];
  wire counter_enable[0:WIDTH-1];

  genvar i;
  
  generate
      for (i = 0; i < WIDTH; i = 1+i)
          begin : debounce_counter_loop
            
            always @(posedge clk or negedge reset_n)
                begin
                  if (reset_n == 0) 
                    begin
                      counter[i] <= 0;
                    end
                  else 
                    begin
                      if (counter_reset[i] == 1) 
                        begin
                          counter[i] <= 0;
                        end
                      else if (counter_enable[i] == 1) 
                        begin
                          counter[i] <= counter[i]+1'b1;
                        end
                        
                    end
                end
            if (POLARITY == HIGH) 
              begin
                assign counter_reset[i] = data_in[i] == 0;
                assign counter_enable[i] = (counter[i] < TIMEOUT) & (data_in[i] == 1);
                assign data_out[i] = (counter[i] == TIMEOUT) ? 1'b1 : 1'b0;
              end
            else 
              begin
                assign counter_reset[i] = data_in[i] == 1;
                assign counter_enable[i] = (data_in[i] == 0) & (counter[i] < TIMEOUT);
                assign data_out[i] = (counter[i] == TIMEOUT) ? 1'b0 : 1'b1;
              end
          end
  endgenerate

endmodule

