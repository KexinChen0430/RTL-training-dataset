module lname_mbus_member_ctrl (
    input      RESETn, 
    input      CIN, 
    input      DIN, 
    input      COUT_FROM_BUS, 
    input      DOUT_FROM_BUS, 
    output reg COUT, 
    output reg DOUT, 
    input      SLEEP_REQ, 
    input      WAKEUP_REQ, 
    output reg MBC_ISOLATE, 
    output     MBC_ISOLATE_B, 
    output reg MBC_RESET, 
    output     MBC_RESET_B, 
    output reg MBC_SLEEP, 
    output     MBC_SLEEP_B, 
    input      CLR_EXT_INT, 
    output reg EXTERNAL_INT, 
    input      ADDR_WR_EN, 
    input      ADDR_CLR_B, 
    input      [`MBUS_DYNA_WIDTH-1:0] ADDR_IN, 
    output reg [`MBUS_DYNA_WIDTH-1:0] ADDR_OUT, 
    output reg ADDR_VALID, 
    input      LRC_SLEEP, 
    input      MBUS_BUSY 
);
    wire next_mbc_isolate; 
    wire sleep_req_isol; 
    reg  goingsleep; 
    assign MBC_SLEEP_B   = ~MBC_SLEEP; 
    assign MBC_ISOLATE_B = ~MBC_ISOLATE; 
    assign MBC_RESET_B   = ~MBC_RESET; 
    assign next_mbc_isolate = goingsleep | sleep_req_isol | MBC_SLEEP; 
    assign sleep_req_isol  = SLEEP_REQ & MBC_ISOLATE_B; 
    always @ (posedge CIN or negedge RESETn) begin
        if (~RESETn) begin 
            goingsleep  <= `SD 1'b0; 
            MBC_SLEEP   <= `SD 1'b1; 
            MBC_ISOLATE <= `SD 1'b1; 
        end
        else begin 
            goingsleep  <= `SD sleep_req_isol; 
            MBC_SLEEP   <= `SD goingsleep; 
            MBC_ISOLATE <= `SD next_mbc_isolate; 
        end
    end
    always @ (negedge CIN or negedge RESETn) begin
        if (~RESETn) MBC_RESET <= `SD 1'b1; 
        else         MBC_RESET <= `SD MBC_ISOLATE; 
    end
    wire clr_ext_int_b = ~(MBC_ISOLATE_B & CLR_EXT_INT); 
    wire RESETn_local = RESETn & CIN; 
    wire RESETn_local2 = RESETn & clr_ext_int_b; 
    wire mbus_busy_b_isol = ~(MBUS_BUSY & MBC_RESET_B); 
    wire int_busy = (WAKEUP_REQ & mbus_busy_b_isol & LRC_SLEEP); 
    reg ext_int_dout; 
    always @ (posedge int_busy or negedge RESETn_local) begin
        if (~RESETn_local) ext_int_dout <= `SD 0; 
        else ext_int_dout <= `SD 1; 
    end
    always @ (posedge int_busy or negedge RESETn_local2) begin
        if (~RESETn_local2) EXTERNAL_INT <= `SD 0; 
        else EXTERNAL_INT <= `SD 1; 
    end
    always @* begin
        if (~RESETn)          COUT <= `SD 1'b1; 
        else if (MBC_ISOLATE) COUT <= `SD CIN; 
        else                  COUT <= `SD COUT_FROM_BUS; 
        if (~RESETn)           DOUT <= `SD 1'b1; 
        else if (ext_int_dout) DOUT <= `SD 0; 
        else if (MBC_ISOLATE)  DOUT <= `SD DIN; 
        else                   DOUT <= `SD DOUT_FROM_BUS; 
    end
    wire    RESETn_local3 = (RESETn & ADDR_CLR_B); 
    wire    addr_update = (ADDR_WR_EN & (~MBC_ISOLATE)); 
    always @ (posedge addr_update or negedge RESETn_local3) begin
        if (~RESETn_local3) begin 
            ADDR_OUT   <= `SD {`MBUS_DYNA_WIDTH{1'b1}}; 
            ADDR_VALID <= `SD 0; 
        end
        else begin 
            ADDR_OUT   <= `SD ADDR_IN; 
            ADDR_VALID <= `SD 1; 
        end
    end
endmodule