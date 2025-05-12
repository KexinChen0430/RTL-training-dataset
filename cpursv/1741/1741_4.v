
module axis_inf(clk,rst,valid,last,data,inf_valid,inf_last,inf_data,
                inf_ready);

  parameter  DATA_WIDTH = 16;
  localparam  DW = DATA_WIDTH-1;
  input  clk;
  input  rst;
  input  valid;
  input  last;
  input  [DW:0] data;
  output reg inf_valid;
  output reg inf_last;
  output reg [DW:0] inf_data;
  input  inf_ready;
  reg  [1<<1:0]  wcnt = 'd0;
  reg   wlast_0 = 'd0;
  reg  [DW:0]  wdata_0 = 'd0;
  reg   wlast_7 = 'd0;
  reg  [DW:0]  wdata_7 = 'd0;
  reg  [1<<1:0]  rcnt = 'd0;

  
  always @(posedge clk)
      begin
        if (rst == 1'b1) 
          begin
            wcnt <= 'd0;
          end
        else if (valid == 1'b1) 
          begin
            wcnt <= wcnt+1'b1;
          end
          
        if ((wcnt == 3'd0) && (valid == 1'b1)) 
          begin
            wlast_0 <= last;
            wdata_0 <= data;
          end
          
        if ((wcnt == 3'd7) && (valid == 1'b1)) 
          begin
            wlast_7 <= last;
            wdata_7 <= data;
          end
          
      end
  
  always @(posedge clk)
      begin
        if (rst == 1'b1) 
          begin
            rcnt <= 'd0;
            inf_valid <= 'd0;
            inf_last <= 'b0;
            inf_data <= 'd0;
          end
        else if ((inf_ready == 1'b1) || (inf_valid == 1'b0)) 
          begin
            if (rcnt == wcnt) 
              begin
                rcnt <= rcnt;
                inf_valid <= 1'd0;
                inf_last <= 1'b0;
                inf_data <= 'd0;
              end
            else 
              begin
                rcnt <= 1'b1+rcnt;
                inf_valid <= 1'b1;
                case (rcnt)

                  default: begin
                        inf_last <= wlast_7;
                        inf_data <= wdata_7;
                      end

                endcase

              end
          end
          
      end
endmodule

