module acl_pop (
	clock,
	resetn,
	dir,
    valid_in,
	data_in,
    stall_out,
    predicate,
    valid_out,
    stall_in,
    data_out,
    feedback_in,
    feedback_valid_in,
    feedback_stall_out
);
    parameter DATA_WIDTH = 32;
    parameter string STYLE = "REGULAR";  
    parameter COALESCE_DISTANCE = 1;
    localparam POP_GARBAGE = STYLE == "COALESCE" ? 1 : 0;
input clock, resetn, stall_in, valid_in, feedback_valid_in;
output stall_out, valid_out, feedback_stall_out;
input [DATA_WIDTH-1:0] data_in;
input dir;
input predicate;
output [DATA_WIDTH-1:0] data_out;
input [DATA_WIDTH-1:0] feedback_in;
localparam DISTANCE_WIDTH = (POP_GARBAGE == 1) ? $clog2(COALESCE_DISTANCE) : 1;
reg [DISTANCE_WIDTH-1:0] garbage_count;
wire feedback_downstream, data_downstream;
reg pop_garbage;
always @(posedge clock or negedge resetn)
begin
    if ( !resetn ) begin
       pop_garbage = 0;
    end
    else if ( ( garbage_count == {(DISTANCE_WIDTH){1'b0}} ) && (valid_out & ~stall_in) ) begin
       pop_garbage = POP_GARBAGE;
    end
end
always @(posedge clock or negedge resetn)
begin
    if ( !resetn ) begin
	garbage_count = COALESCE_DISTANCE-1;
    end
    else if ( valid_out & ~stall_in ) begin
        garbage_count = garbage_count - 1'b1;
    end
end
assign feedback_downstream = valid_in & ~dir & feedback_valid_in;
assign data_downstream = valid_in & dir;
assign valid_out = feedback_downstream | ( data_downstream & (~pop_garbage | feedback_valid_in ) ) ;
assign data_out = ~dir ? feedback_in : data_in;
 assign stall_out = ( valid_in & ( ( ~dir & ~feedback_valid_in ) |  ( dir & ~feedback_valid_in & pop_garbage ) )  ) | stall_in;
assign feedback_stall_out = stall_in  | (data_downstream & ~pop_garbage) | ~valid_in | predicate;
endmodule