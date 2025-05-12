
module note2dds(clk,note,adder);

  input  wire clk;
  input  wire [8:0] note;
  output [31:0] adder;
  reg  [31:0] adder_tbl[15:0];
  reg  [3:0] addr;
  reg  [3:0] divider;

  
  initial  
  begin
    addr <= 4'd0;
    divider <= 4'd0;
    adder_tbl[4'd0] <= 32'd01438301;
    adder_tbl[4'd1] <= 32'd01523827;
    adder_tbl[4'd2] <= 32'd01614439;
    adder_tbl[4'd3] <= 32'd01710438;
    adder_tbl[4'd4] <= 32'd01812146;
    adder_tbl[4'd5] <= 32'd01919902;
    adder_tbl[4'd6] <= 32'd02034065;
    adder_tbl[4'd7] <= 32'd02155017;
    adder_tbl[4'd8] <= 32'd02283161;
    adder_tbl[4'd9] <= 32'd02418925;
    adder_tbl[4'd10] <= 32'd02562762;
    adder_tbl[4'd11] <= 32'd02715152;
    adder_tbl[4'd12] <= 32'd0;
    adder_tbl[4'd13] <= 32'd0;
    adder_tbl[4'd14] <= 32'd0;
    adder_tbl[4'd15] <= 32'd0;
  end
  assign adder = adder_tbl[addr]>>divider;
  wire [5:0] 
       diap = (note < 12) ? 6'd00 : 
(note < 24) ? 6'd01 : 
(note < 504) ? 6'd41 : 6'd042;

  wire [6:0]  c_addr = (0-(diap*4'd012))+note;

  
  always @(posedge clk)
      begin
        addr <= c_addr[3:0];
        divider <= (-diap)+6'd042;
      end
endmodule

