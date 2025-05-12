module memory_management_unit (
);
    wire [0:7] addr; 
    always @ (*) begin 
        case ({reset, s}) 
            2'b00: addr = page;       
            2'b01: addr = cfg_page;   
            2'b10: addr = clr_cnt;    
            2'b11: addr = clr_cnt;    
        endcase
    end
    initial begin 
        reg [8:0] i; 
        for (i=0 ; i<9'd256 ; i=i+9'd1) begin 
            if (i == 1) map[i] = 1; 
            else map[i] = 0; 
        end
    end
    reg map_wr = 0; 
    reg [0:7] rd_addr; 
    reg [0:7] map [0:255]; 
    always @ (posedge clk) begin 
        if (map_wr) map[addr] <= cfg_frame & frame_clear; 
        rd_addr <= addr; 
    end
    assign frame = map[rd_addr]; 
    localparam mmask = 2**MODULE_ADDR_WIDTH - 1;
    localparam fmask = 2**FRAME_ADDR_WIDTH - 1;
    localparam [3:0] frame_addr_mask = fmask[3:0];
    localparam [3:0] module_addr_mask = mmask[3:0];
    localparam [7:0] invalidity_mask = ~{module_addr_mask, frame_addr_mask};
    assign pvalid = (addr < 2) || (frame != 0); 
    wire frame_addr_valid = (cfg_frame & invalidity_mask) == 8'd0; 
    wire cfg_cmd_valid = s && (cfg_page > 1) && frame_addr_valid; 
    localparam CIDLE   = 3'd0;
    localparam CCFG    = 3'd1;
    localparam COK     = 3'd2;
    localparam RESET   = 3'd3;
    localparam CLEAR   = 3'd4;
    reg [2:0] cstate = CIDLE; 
    reg [7:0] clr_cnt; 
    reg [7:0] frame_clear; 
    assign reset_hold = (cstate == CLEAR) | (cstate == RESET); 
    always @ (posedge clk) begin
        if (reset & ~reset_hold) cstate <= RESET; 
        else case (cstate) 
            CIDLE: begin 
                frame_clear <= 8'hff; 
                if (cfg_cmd_valid) begin 
                    map_wr <= 1; 
                    cstate <= CCFG; 
                end
            end
            CCFG: begin 
                map_wr <= 0; 
                cfgok <= 1; 
                cstate <= COK; 
            end
            COK: begin 
                if (~s) begin 
                    cfgok <= 0; 
                    cstate <= CIDLE; 
                end
            end
            RESET: begin 
                clr_cnt <= 2; 
                map_wr <= 1; 
                frame_clear <= 8'd0; 
                cstate <= CLEAR; 
            end
            CLEAR: begin 
                if (clr_cnt == 8'hff) begin 
                    cstate <= CIDLE; 
                    map_wr <= 0; 
                end else begin
                    clr_cnt <= clr_cnt + 1'b1; 
                end
            end
        endcase
    end
endmodule