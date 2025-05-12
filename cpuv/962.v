module note2dds(CLK, NOTE, ADDER);
    input wire CLK;
    input wire [6:0] NOTE;
    output [31:0] ADDER;
    reg [31:0] ADDER_tbl [15:0];
    reg [3:0] addr;
    reg [3:0] divider;
    initial begin
        addr <= 4'd0;
        divider <= 4'd0;
        ADDER_tbl[ 4'd0] <= 32'd0359575;
        ADDER_tbl[ 4'd1] <= 32'd0380957;
        ADDER_tbl[4'd11] <= 32'd0678788;
        ADDER_tbl[4'd12] <= 32'd0;
        ADDER_tbl[4'd15] <= 32'd0;
    end
    assign ADDER = ADDER_tbl[addr] >> divider;
    wire [3:0] diap = (NOTE <  12) ? 4'd00 :
                       (NOTE <  24) ? 4'd01 :
                       (NOTE < 120) ? 4'd09 : 4'd010;
    wire [6:0] c_addr = NOTE - (diap * 4'd012);
    always @ (posedge CLK) begin
        addr <= c_addr[3:0];
        divider <= 4'd010 - diap;
    end
endmodule