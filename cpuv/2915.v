module timer #(
        parameter       [31:0]  TIMER_ENABLE_REGISTER = 32'h0,
        parameter       [31:0]  TIMER_LIMIT_REGISTER  = 32'h4,
        parameter       [31:0]  TIMER_INTACK_REGISTER = 32'h8,
        parameter       [31:0]  TIMER_START_REGISTER  = 32'hC
) (
        input wire                  i_clk,
        input wire                  i_rst,
        input wire  [31:0]          i_wb_dat,
        input wire   [3:0]          i_wb_adr,
        input wire                  i_wb_stb,
        input wire                  i_wb_cyc,
        input wire                  i_wb_wen,
        input wire  [3:0]           i_wb_sel,
        output reg [31:0]           o_wb_dat,
        output reg                  o_wb_ack,
        output  reg                 o_irq
);
reg [31:0] DEVEN;   
reg [31:0] DEVPR;   
reg [31:0] DEVAK;   
reg [31:0] DEVST;   
`ifndef ZAP_SOC_TIMER
`define ZAP_SOC_TIMER
        `define DEVEN TIMER_ENABLE_REGISTER
        `define DEVPR TIMER_LIMIT_REGISTER
        `define DEVAK TIMER_INTACK_REGISTER
        `define DEVST TIMER_START_REGISTER
`endif
reg [31:0] ctr;         
reg        start;       
reg        done;        
reg        clr;         
reg [31:0] state;       
reg        enable;      
reg [31:0] finalval;    
reg [31:0] wbstate;     
localparam IDLE         = 0;
localparam COUNTING     = 1;
localparam DONE         = 2;
localparam WBIDLE       = 0;
localparam WBREAD       = 1;
localparam WBWRITE      = 2;
localparam WBACK        = 3;
localparam WBDONE       = 4;
always @ (*)
        o_irq    = done;
always @ (*)
begin
        start    = DEVST[0];
        enable   = DEVEN[0];
        finalval = DEVPR;
        clr      = DEVAK[0];
end
always @ ( posedge i_clk )
begin
        DEVST <= 0; 
        if ( i_rst )
        begin
                DEVEN <= 0;
                DEVPR <= 0;
                DEVAK <= 0;
                DEVST <= 0;
                wbstate  <= WBIDLE;
                o_wb_dat <= 0;
                o_wb_ack <= 0;
        end
        else
        begin
                case(wbstate)
                        WBIDLE:
                        begin
                                o_wb_ack <= 1'd0;
                                if ( i_wb_stb && i_wb_cyc )
                                begin
                                        if ( i_wb_wen )
                                                wbstate <= WBWRITE;
                                        else
                                                wbstate <= WBREAD;
                                end
                        end
                        WBWRITE:
                        begin
                                case(i_wb_adr)
                                `DEVEN: 
                                begin
                                        $display($time, " - %m :: Writing register DEVEN...");
                                        if ( i_wb_sel[0] ) DEVEN[7:0]   <= i_wb_dat >> 0;
                                        if ( i_wb_sel[1] ) DEVEN[15:8]  <= i_wb_dat >> 8;
                                        if ( i_wb_sel[2] ) DEVEN[23:16] <= i_wb_dat >> 16;
                                        if ( i_wb_sel[3] ) DEVEN[31:24] <= i_wb_dat >> 24;
                                end
                                `DEVPR: 
                                begin
                                        $display($time, " - %m :: Writing register DEVPR...");
                                        if ( i_wb_sel[0] ) DEVPR[7:0]   <= i_wb_dat >> 0;
                                        if ( i_wb_sel[1] ) DEVPR[15:8]  <= i_wb_dat >> 8;
                                        if ( i_wb_sel[2] ) DEVPR[23:16] <= i_wb_dat >> 16;
                                        if ( i_wb_sel[3] ) DEVPR[31:24] <= i_wb_dat >> 24;
                                end
                                `DEVAK: 
                                begin
                                        $display($time, " - %m :: Writing register DEVAK...");
                                        if ( i_wb_sel[0] ) DEVAK[7:0]   <= i_wb_dat >> 0;
                                        if ( i_wb_sel[1] ) DEVAK[15:8]  <= i_wb_dat >> 8;
                                        if ( i_wb_sel[2] ) DEVAK[23:16] <= i_wb_dat >> 16;
                                        if ( i_wb_sel[3] ) DEVAK[31:24] <= i_wb_dat >> 24;
                                end
                                `DEVST: 
                                begin
                                        $display($time, " - %m :: Writing register DEVST...");
                                        if ( i_wb_sel[0] ) DEVST[7:0]   <= i_wb_dat >> 0;
                                        if ( i_wb_sel[1] ) DEVST[15:8]  <= i_wb_dat >> 8;
                                        if ( i_wb_sel[2] ) DEVST[23:16] <= i_wb_dat >> 16;
                                        if ( i_wb_sel[3] ) DEVST[31:24] <= i_wb_dat >> 24;
                                end
                                endcase
                                wbstate <= WBACK;
                        end
                        WBREAD:
                        begin
                                case(i_wb_adr)
                                `DEVEN: o_wb_dat <= DEVEN;
                                `DEVPR: o_wb_dat <= DEVPR;
                                `DEVAK: o_wb_dat <= done; 
                                `DEVST: o_wb_dat <= 32'd0; 
                                endcase
                                wbstate <= WBACK;
                        end
                        WBACK:
                        begin
                                o_wb_ack   <= 1'd1;
                                wbstate    <= WBDONE;
                        end
                        WBDONE:
                        begin
                                o_wb_ack  <= 1'd0;
                                wbstate   <= IDLE;
                        end
                endcase
        end
end
always @ (posedge i_clk)
begin
        if ( i_rst || !enable )
        begin
                ctr     <= 0;
                done    <= 0;
                state   <= IDLE;
        end
        else 
        begin
                case(state)
                IDLE:
                begin
                        if ( start )
                        begin
                                $display($time," - %m :: Timer started counting...");
                                state <= COUNTING;
                        end
                end
                COUNTING:
                begin
                        ctr <= ctr + 1;
                        if ( ctr == finalval )
                        begin
                                $display($time, " - %m :: Timer done counting...");
                                state <= DONE;
                        end
                end
                DONE:
                begin
                        done <= 1;
                        if ( start )
                        begin
                                $display($time, " - %m :: Timer got START from DONE state...");
                                done  <= 0;
                                state <= COUNTING;
                                ctr   <= 0;
                        end
                        else if ( clr ) 
                        begin
                                $display($time, " - %m :: Timer got done in ACK state...");
                                done  <= 0;
                                state <= IDLE;
                                ctr   <= 0;
                        end
                end
                endcase
        end
end
endmodule