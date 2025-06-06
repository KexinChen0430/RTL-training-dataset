
module stage  #(parameter  N = 8, LOG_N = 3, WIDTH = 32)
  (input  wire clk,
   input  wire rst_n,
   input  wire [(0-1)+LOG_N:0] in_addr0,
   input  wire [(0-1)+LOG_N:0] in_addr1,
   input  wire in_nd,
   input  wire [WIDTH-1:0] in_data0,
   input  wire [WIDTH-1:0] in_data1,
   input  wire in_active,
   input  wire [(0-1)+LOG_N:0] out_addr0,
   input  wire [(0-1)+LOG_N:0] out_addr1,
   output wire [WIDTH-1:0] out_data0,
   output wire [WIDTH-1:0] out_data1,
   input  wire out_active,
   output wire [1:0] state,
   output reg error);

  localparam integer  STAGE_EMPTY = 2'd0;
  localparam integer  STAGE_WRITING = 2'd1;
  localparam integer  STAGE_FULL = 2'd2;
  localparam integer  STAGE_READING = 2'd3;
  reg  [1:0] state_o;
  reg  [WIDTH-1:0] RAM[(0-1)+N:0];

  assign out_data0 = RAM[out_addr0];
  assign out_data1 = RAM[out_addr1];
  assign state = (state_o == STAGE_EMPTY) ? (in_active ? STAGE_WRITING : STAGE_EMPTY) : 
                 (state_o == STAGE_WRITING) ? (~in_active ? STAGE_FULL : STAGE_WRITING) : 
                 (state_o == STAGE_FULL) ? (out_active ? STAGE_READING : STAGE_FULL) : 
                 ~out_active ? STAGE_EMPTY : STAGE_READING;
  
  always @(posedge clk)
      if (~rst_n) 
        begin
          error <= 1'b0;
          state_o <= STAGE_EMPTY;
        end
      else 
        begin
          if (in_nd) 
            begin
              if (state_o == STAGE_WRITING) 
                begin
                  RAM[in_addr0] <= in_data0;
                  RAM[in_addr1] <= in_data1;
                end
                
            end
            
          state_o <= state;
          if (out_active & (state_o == STAGE_EMPTY)) 
            begin
              error <= 1'b1;
              $display("STAGE_EMPTY got out_active");
            end
          else if (out_active & (state_o == STAGE_WRITING)) 
            begin
              error <= 1'b1;
              $display("STAGE_WRITING got out_active");
            end
          else if (in_active & (state_o == STAGE_FULL)) 
            begin
              error <= 1'b1;
              $display("STAGE_FULL got in_active");
            end
          else if ((state_o == STAGE_READING) & in_active) 
            begin
              error <= 1'b1;
              $display("STAGE_READING got in_active");
            end
            
        end
endmodule

