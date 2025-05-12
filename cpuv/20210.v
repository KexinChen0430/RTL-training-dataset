module toy_icache(
    input clk, 
    input reset, 
    input [31:0] ic_addr, 
    input ic_rq, 
    output reg ic_data_out_valid, 
    output reg [31:0] ic_data_out, 
    input [31:0] data_in, 
    input data_in_ready, 
    output reg data_rd, 
    output reg [31:0] data_address 
);
reg [31-`IC_WIDTH_BITS+1:0] ictags[0:`IC_LINES-1]; 
reg [31:0] cacheram[0:`IC_LINES*`IC_WIDTH-1]; 
wire [31-`IC_WIDTH_BITS:0] addrtag;
assign addrtag = ic_addr[31:`IC_WIDTH_BITS];
reg [31-`IC_WIDTH_BITS+1:0] icnewtag;
parameter S_IDLE = 0; 
parameter S_FILL = 1; 
parameter S_FILL_STEP = 2; 
reg [1:0] ic_state;
reg [31:0] ictagsout;
reg [1:0] ic_rq_shift;
always @(posedge clk)
    if (!reset) begin
        ic_data_out_valid <= 0;
        ic_data_out <= 0;
        icnewtag <= 0;
        data_rd <= 0;
        ic_state <= S_IDLE;
        ictagsout <= 0;
        ic_rq_shift <= 0;
    end else begin
        ic_rq_shift <= {ic_rq_shift[0], ic_rq};
        ictagsout <= ictags[ic_addr[`IC_WIDTH_BITS+`IC_LINES_BITS-1:`IC_WIDTH_BITS]];
        case (ic_state)
            S_IDLE: 
                if (ic_rq_shift[1]) begin 
                    if(ictagsout == {1'b1, addrtag}) 
                    begin
                        ic_data_out <= cacheram[ic_addr[`IC_WIDTH_BITS+`IC_LINES_BITS-1:0]];
                        ic_data_out_valid <= 1;
                    end else begin 
                        ic_data_out_valid <= 0;
                        ictags[ic_addr[`IC_WIDTH_BITS+`IC_LINES_BITS-1:`IC_WIDTH_BITS]] <= 0; 
                        ic_state <= S_FILL; 
                        data_address <= {ic_addr[31:`IC_WIDTH_BITS],`IC_WIDTH_ZERO}; 
                        data_rd <= 1; 
                        icnewtag <= {1'b1, addrtag}; 
                    end
                end else begin
                    ic_data_out_valid <= 0;
                    ic_data_out <= 0;
                end
            S_FILL: 
                if (data_in_ready) begin 
                    if (ic_rq && data_address == ic_addr) begin 
                        ic_data_out <= data_in;
                        ic_data_out_valid <= 1;
                    end else begin
                        ic_data_out_valid <= 0;
                        ic_data_out <= 0;
                    end
                    cacheram[data_address[`IC_LINES_BITS+`IC_WIDTH_BITS-1:0]] <= data_in;
                    data_rd <= 0; 
                    if (data_address[`IC_WIDTH_BITS-1:0] == `IC_WIDTH_ONES) begin
                        ictags[data_address[`IC_LINES_BITS+`IC_WIDTH_BITS-1:`IC_WIDTH_BITS]] <= icnewtag; 
                        ic_state <= S_IDLE; 
                    end else begin
                        ic_state <= S_FILL_STEP; 
                        data_address <= data_address + 1; 
                    end
                end else begin 
                end
            S_FILL_STEP: 
                data_rd <= 1;
                ic_state <= S_FILL;
                ic_data_out_valid <= 0;
                ic_data_out <= 0;
        endcase 
    end
endmodule