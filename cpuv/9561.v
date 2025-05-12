module ad_axis_inf_rx #(
  parameter   DATA_WIDTH = 16) (
  input                           clk,        
  input                           rst,        
  input                           valid,      
  input                           last,       
  input       [(DATA_WIDTH-1):0]  data,       
  output  reg                     inf_valid,  
  output  reg                     inf_last,   
  output  reg [(DATA_WIDTH-1):0]  inf_data,   
  input                           inf_ready); 
  reg     [ 2:0]              wcnt = 'd0;     
  reg                         wlast_0 = 'd0;  
  reg     [(DATA_WIDTH-1):0]  wdata_0 = 'd0;  
  reg                         wlast_7 = 'd0;  
  reg     [(DATA_WIDTH-1):0]  wdata_7 = 'd0;  
  reg     [ 2:0]              rcnt    = 'd0;  
  wire                        inf_ready_s;    
  reg                         inf_last_s;     
  reg     [(DATA_WIDTH-1):0]  inf_data_s;     
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      wcnt <= 'd0;                            
    end else if (valid == 1'b1) begin
      wcnt <= wcnt + 1'b1;                    
    end
    if ((wcnt == 3'd0) && (valid == 1'b1)) begin
      wlast_0 <= last;
      wdata_0 <= data;
    end
    if ((wcnt == 3'd7) && (valid == 1'b1)) begin
      wlast_7 <= last;
      wdata_7 <= data;
    end
  end
  assign inf_ready_s = inf_ready | ~inf_valid;
  always @(rcnt or wlast_0 or wdata_0 or ... or wlast_7 or wdata_7) begin
    case (rcnt)
      3'd0: begin
        inf_last_s = wlast_0;
        inf_data_s = wdata_0;
      end
      default: begin
        inf_last_s = wlast_7;
        inf_data_s = wdata_7;
      end
    endcase
  end
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      rcnt <= 'd0;
      inf_valid <= 'd0;
      inf_last <= 'b0;
      inf_data <= 'd0;
    end else if (inf_ready_s == 1'b1) begin
      if (rcnt == wcnt) begin
        rcnt <= rcnt;
        inf_valid <= 1'd0;
        inf_last <= 1'b0;
        inf_data <= 'd0;
      end else begin
        rcnt <= rcnt + 1'b1;
        inf_valid <= 1'b1;
        inf_last <= inf_last_s;
        inf_data <= inf_data_s;
      end
    end
  end
endmodule