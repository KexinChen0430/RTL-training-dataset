module control(clock, reset, write_ready, write, writedata_left, writedata_right);
  input clock, reset, write_ready; 
  input [3:0] switches;            
  output reg write;                
  output reg [23:0] writedata_left, writedata_right; 
  reg [7:0] counter; 
  always @(posedge clock) begin
    if (!reset) begin
      counter <= 8'b0;
    end
    else begin
      if (write_ready) begin
        write <= 1'b1;
        counter[7:0]  <= counter[7:0] + 1'b1;
        if (switches == 4'b0000) begin
          writedata_left[23] <= counter[0];
          writedata_right[23] <= counter[0];
        end
        else if (switches == 4'b0001) begin
          writedata_left[23] <= counter[4];
          writedata_right[23] <= counter[4];
        end
        else if (switches == 4'b0010) begin
          writedata_left[23] <= counter[5];
          writedata_right[23] <= counter[5];
        end
        else if (switches == 4'b0100) begin
          writedata_left[23] <= counter[6];
          writedata_right[23] <= counter[6];
        end
        else if (switches == 4'b1000) begin
          writedata_left[23] <= counter[7];
          writedata_right[23] <= counter[7];
        end
      end
    end
  end
endmodule