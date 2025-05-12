module acl_enable_sink
#(
    parameter integer DATA_WIDTH = 32,
    parameter integer PIPELINE_DEPTH = 32,
    parameter integer SCHEDULEII = 1,
    parameter integer IP_PIPELINE_LATENCY_PLUS1 = 1,
    parameter integer ZERO_LATENCY_OFFSET = 1
)
(
    input  logic clock,
    input  logic resetn,
    input  logic [DATA_WIDTH-1:0] data_in,
    output logic [DATA_WIDTH-1:0] data_out,
    input  logic input_accepted,
    input  logic valid_in,
    output logic valid_out,
    input  logic stall_in,
    output logic stall_entry,
    output logic enable,
    input  logic inc_pipelined_thread,
    input  logic dec_pipelined_thread
);
    wire throttle_pipelined_iterations;
    assign data_out = data_in;
    assign valid_out = valid_in;
    assign enable = ((IP_PIPELINE_LATENCY_PLUS1 == 1) ? ~valid_out : 1'b0) | ~stall_in;
    assign stall_entry = ~enable | throttle_pipelined_iterations;
    reg[$clog2(SCHEDULEII):0] IIschedcount;
    reg[$clog2(SCHEDULEII):0] threads_count;
    always @(posedge clock or negedge resetn)
    begin
       if (!resetn) begin
          IIschedcount <= 0;
          threads_count <= 0;
       end else if(enable) begin
          IIschedcount <= (input_accepted && dec_pipelined_thread) ? IIschedcount : (IIschedcount == (SCHEDULEII - 1) ? 0 : (IIschedcount + 1));
          if (input_accepted) begin
             threads_count <= threads_count + inc_pipelined_thread - dec_pipelined_thread;
          end
       end
    end
    assign throttle_pipelined_iterations = (IIschedcount >= (threads_count > 0 ? threads_count : 1));
endmodule