module RPCv3RouterReceiver_expanding
#(
    parameter OUT_DATA_WIDTH = 32,
    parameter IN_DATA_WIDTH = 16
)
(
    input wire clk,
    input wire                        rpc_rx_en,          
    input wire[IN_DATA_WIDTH-1:0]     rpc_rx_data,        
    output reg                        rpc_rx_ready = 0,   
    input wire                        rpc_fab_rx_space_available, 
    output wire                       rpc_fab_rx_packet_start,    
    output reg                        rpc_fab_rx_data_valid = 0,  
    output reg[OUT_DATA_WIDTH-1:0]    rpc_fab_rx_data = 0,        
    output reg                        rpc_fab_rx_packet_done = 0  
);
    initial begin
        case(IN_DATA_WIDTH)
            16: begin
            end
            32: begin
            end
            64: begin
            end
            default: begin
                $display("ERROR: RPCv3RouterReceiver_expanding IN_DATA_WIDTH must be 16/32/64");
                $finish;
            end
        endcase
        case(OUT_DATA_WIDTH)
            32: begin
            end
            64: begin
            end
            128: begin
            end
            default: begin
                $display("ERROR: RPCv3RouterReceiver_expanding OUT_DATA_WIDTH must be 32/64/128");
                $finish;
            end
        endcase
        if(IN_DATA_WIDTH >= OUT_DATA_WIDTH) begin
            $display("ERROR: RPCv3RouterReceiver_expanding IN_DATA_WIDTH must be less than OUT_DATA_WIDTH");
            $finish;
        end
    end
    localparam MESSAGE_CYCLES = 128 / IN_DATA_WIDTH;
    `include "../../synth_helpers/clog2.vh"
    localparam CYCLE_BITS = clog2(MESSAGE_CYCLES);
    localparam CYCLE_MAX = CYCLE_BITS ? CYCLE_BITS-1 : 0;
    localparam EXPANSION_RATIO = OUT_DATA_WIDTH / IN_DATA_WIDTH;
    localparam PHASE_BITS = clog2(EXPANSION_RATIO);
    wire                    rx_starting             = (rpc_rx_en && rpc_rx_ready);
    assign                  rpc_fab_rx_packet_start = rx_starting;
    reg[2:0]                rx_count        = 0;
    wire                    rx_active       = (rx_count != 0) || rx_starting;
    always @(posedge clk) begin
        rpc_fab_rx_data_valid           <= 0;
        rpc_fab_rx_packet_done          <= 0;
        if(rx_active) begin
            rpc_fab_rx_data             <= { rpc_fab_rx_data[OUT_DATA_WIDTH-IN_DATA_WIDTH : 0], rpc_rx_data };
            if(rx_starting)
                rx_count                <= 1;
            else
                rx_count                <= rx_count + 1'h1;
            if(rx_count[PHASE_BITS-1:0] == {PHASE_BITS{1'b1}})
                rpc_fab_rx_data_valid   <= 1'b1;
            if( (IN_DATA_WIDTH == 64) && (rx_count == 1) ) begin
                rpc_fab_rx_packet_done  <= 1;
                rx_count                <= 0;
            end
            else if( (IN_DATA_WIDTH == 32) && (rx_count == 3) ) begin
                rpc_fab_rx_packet_done  <= 1;
                rx_count                <= 0;
            end
            else if( (IN_DATA_WIDTH == 16) && (rx_count == 7) ) begin
                rpc_fab_rx_packet_done  <= 1;
                rx_count                <= 0;
            end
        end
    end
    reg     rpc_rx_ready_ff = 0;
    always @(posedge clk) begin
        if(rpc_rx_en)
            rpc_rx_ready_ff     <= 0;
        if(rpc_fab_rx_space_available)
            rpc_rx_ready_ff     <= 1;
    end
    always @(*) begin
        rpc_rx_ready            <= rpc_rx_ready_ff;
    end
endmodule