
module button_hold(rst,clk,out_status,pin_select,press_done);

  input  rst;
  input  clk;
  input  [15:0] pin_select;
  output [25:0] out_status;
  output press_done;
  reg  [25:0] out_status;
  reg  [31:0] counter;
  reg  pull_done;
  reg  press_done;

  
  always @(posedge clk or negedge rst)
      begin
        if (!rst) counter <= 'h0;
        else 
          counter <= ((pin_select != 'h0) && (counter < 32'hFFFFFFFF)) ? (1'b1+counter) : 'h0;
      end
  
  always @(posedge clk or negedge rst)
      begin
        if (!rst) out_status <= 26'h3ffffff;
        else 
          begin
            case (pin_select[7:0])

              8'h41: out_status[0] <= pull_done;

              8'h5a: out_status[25] <= pull_done;

              default: out_status <= 26'h3ffffff;

            endcase

          end
      end
  
  always @(posedge clk or negedge rst)
      begin
        if (!rst) pull_done <= 1'bz;
        else 
          begin
            pull_done <= ((counter < 'd3500000) && (pin_select[15:8] == 8'h53)) ? 1'b0 : 
                        ((pin_select[15:8] == 8'h4c) && (counter < 'd100000000)) ? 1'b0 : 
                        ((pin_select[15:8] == 8'h56) && (counter < 'd500000000)) ? 1'b0 : 
                        (pin_select[15:8] == 8'h44) ? 1'b0 : 
                        (pin_select[15:8] == 8'h48) ? 1'b1 : 1'bz;
          end
      end
  
  always @(posedge clk or negedge rst)
      begin
        if (!rst) press_done <= 1'b0;
        else 
          press_done <= ((counter > 'd3500000) && (pin_select[15:8] == 8'h53)) ? 1'b1 : 
                       ((pin_select[15:8] == 8'h4c) && (counter > 'd100000000)) ? 1'b1 : 
                       ((pin_select[15:8] == 8'h56) && (counter > 'd500000000)) ? 1'b1 : 
                       (pin_select[15:8] == 8'h44) ? 1'b1 : 
                       (pin_select[15:8] == 8'h48) ? 1'b1 : 1'b0;
      end
endmodule

