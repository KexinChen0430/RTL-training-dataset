module mbus_master_ctrl_testbench ( 
    input      CLK, 
    input      RESETn, 
    input      CIN, 
    input      DIN, 
    input      COUT_FROM_BUS, 
    input      DOUT_FROM_BUS, 
    output reg COUT, 
    output reg DOUT, 
    input      SLEEP_REQ0, 
    input      SLEEP_REQ1, 
    input      WAKEUP_REQ0, 
    input      WAKEUP_REQ1, 
    input      WAKEUP_REQ2, 
    input      WAKEUP_REQ3, 
    output reg MBC_ISOLATE, 
    output     MBC_ISOLATE_B, 
    output reg MBC_RESET, 
    output     MBC_RESET_B, 
    output     MBC_SLEEP, 
    output     MBC_SLEEP_B, 
    input      CLR_EXT_INT, 
    output reg EXTERNAL_INT, 
    input      LRC_SLEEP, 
    input      MBUS_BUSY 
);
    reg     set_tran_to_wake; 
    reg     rst_tran_to_wake; 
    reg     tran_to_wake; 
    reg     mbc_sleep_int; 
    assign  MBC_ISOLATE_B = ~MBC_ISOLATE; 
    assign  MBC_RESET_B   = ~MBC_RESET; 
    assign  MBC_SLEEP_B   = ~MBC_SLEEP; 
    wire wakeup_req_ored = WAKEUP_REQ0 | WAKEUP_REQ1 | WAKEUP_REQ2 | WAKEUP_REQ3; 
    wire sleep_req = (~MBC_ISOLATE) & (SLEEP_REQ0 | SLEEP_REQ1); 
    wire set_tran_to_wake_in_sleep = mbc_sleep_int & ~DIN; 
    wire going_sleep = ~set_tran_to_wake_in_sleep & sleep_req; 
    always @* begin 
        if (~RESETn) set_tran_to_wake <= 1'b0; 
        else if (set_tran_to_wake_in_sleep) 
             set_tran_to_wake <= 1'b1; 
        else set_tran_to_wake <= 1'b0; 
    end
    always @* begin 
        if (~RESETn) rst_tran_to_wake <= 1'b1; 
        else if (going_sleep) 
             rst_tran_to_wake <= 1'b1; 
        else rst_tran_to_wake <= 1'b0; 
    end
    always @ ( posedge rst_tran_to_wake or posedge set_tran_to_wake ) begin 
        if (rst_tran_to_wake)       tran_to_wake <= 1'b0; 
        else if (set_tran_to_wake)  tran_to_wake <= 1'b1; 
        else                        tran_to_wake <= tran_to_wake; 
    end
    wire next_mbc_isolate = mbc_sleep_int | ~tran_to_wake; 
    wire next_mbc_sleep_int = MBC_ISOLATE & ~tran_to_wake; 
    always @ (posedge CLK or negedge RESETn) begin 
        if (~RESETn) begin 
            MBC_ISOLATE     <= `MBUSTB_SD 1'b1; 
            mbc_sleep_int   <= `MBUSTB_SD 1'b1; 
            MBC_RESET       <= `MBUSTB_SD 1'b1; 
        end
        else begin 
            MBC_ISOLATE     <= `MBUSTB_SD next_mbc_isolate; 
            mbc_sleep_int   <= `MBUSTB_SD next_mbc_sleep_int; 
            MBC_RESET       <= `MBUSTB_SD MBC_ISOLATE; 
        end
    end
    assign MBC_SLEEP = mbc_sleep_int & DIN; 
    wire clr_ext_int_b = ~(MBC_ISOLATE_B & CLR_EXT_INT); 
    wire RESETn_local = RESETn & CIN; 
    wire RESETn_local2 = RESETn & clr_ext_int_b; 
    wire mbus_busy_b_isol = ~(MBUS_BUSY & MBC_RESET_B); 
    wire int_busy = (wakeup_req_ored & mbus_busy_b_isol & LRC_SLEEP); 
    reg ext_int_dout; 
    always @ (posedge int_busy or negedge RESETn_local) begin 
        if (~RESETn_local) ext_int_dout <= `MBUSTB_SD 0; 
        else ext_int_dout <= `MBUSTB_SD 1; 
    end
    always @ (posedge int_busy or negedge RESETn_local2) begin 
        if (~RESETn_local2) EXTERNAL_INT <= `MBUSTB_SD 0; 
        else EXTERNAL_INT <= `MBUSTB_SD 1; 
    end
always @* begin 
    if (!RESETn)          COUT <= `MBUSTB_SD 1'b1; 
    else if (MBC_ISOLATE) COUT <= `MBUSTB_SD 1'b1; 
    else                  COUT <= `MBUSTB_SD COUT_FROM_BUS; 
    if (!RESETn)           DOUT <= `MBUSTB_SD 1'b1; 
    else if (ext_int_dout) DOUT <= `MBUSTB_SD 0; 
    else if (MBC_ISOLATE)  DOUT <= `MBUSTB_SD 1'b1; 
    else                   DOUT <= `MBUSTB_SD DOUT_FROM_BUS; 
end
endmodule 