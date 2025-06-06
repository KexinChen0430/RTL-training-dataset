module 
  output wire [18:0]  data_out0,
  output wire [18:0]  data_out1,
  output wire [18:0]  data_out2,
  output wire [18:0]  data_out3,
  output wire [18:0]  data_out4,
  output wire [18:0]  data_out5,
  output wire [18:0]  data_out6,
  output wire [18:0]  data_out7,
  output wire [18:0]  data_out8,
  output wire [18:0]  data_out9
  );
  reg  processing; 
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) 
      processing  <=  1'b0; 
    else if (start) 
      processing  <=  1'b1; 
    else if (start_done) 
      processing  <=  1'b0; 
  end
  reg  [7:0] data_mem [0:9]; 
  integer i; 
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin 
      for (i = 0; i < 10; i = i + 1) begin 
        data_mem[i] <=  8'b0; 
      end
    end else if (processing) begin 
      case(data_in) 
      4'b0000:  data_mem[0] <=  data_mem[0] + 1;
      4'b0001:  data_mem[1] <=  data_mem[1] + 1;
      4'b0010:  data_mem[2] <=  data_mem[2] + 1;
      4'b0011:  data_mem[3] <=  data_mem[3] + 1;
      4'b0100:  data_mem[4] <=  data_mem[4] + 1;
      4'b0101:  data_mem[5] <=  data_mem[5] + 1;
      4'b0110:  data_mem[6] <=  data_mem[6] + 1;
      4'b0111:  data_mem[7] <=  data_mem[7] + 1;
      4'b1000:  data_mem[8] <=  data_mem[8] + 1;
      4'b1001:  data_mem[9] <=  data_mem[9] + 1;
      default:  ; 
      endcase
    end
  end
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) 
      req_coding  <=  1'b0; 
    else if (start_done) 
      req_coding  <=  1'b1; 
    else if (ack_coding) 
      req_coding  <=  1'b0; 
  end
  assign data_out0 = {6'b0, 5'd0, data_mem[0]};
  assign data_out1 = {6'b0, 5'd1, data_mem[1]};
  assign data_out2 = {6'b0, 5'd2, data_mem[2]};
  assign data_out3 = {6'b0, 5'd3, data_mem[3]};
  assign data_out4 = {6'b0, 5'd4, data_mem[4]};
  assign data_out5 = {6'b0, 5'd5, data_mem[5]};
  assign data_out6 = {6'b0, 5'd6, data_mem[6]};
  assign data_out7 = {6'b0, 5'd7, data_mem[7]};
  assign data_out8 = {6'b0, 5'd8, data_mem[8]};
  assign data_out9 = {6'b0, 5'd9, data_mem[9]};
endmodule 