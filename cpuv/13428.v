module gtxe2_chnl_rx_oob #( 
    parameter width = 20, 
    parameter   [2:0]   SATA_BURST_VAL  = 3'b100,
    parameter   [2:0]   SATA_EIDLE_VAL  = 3'b100,
    parameter           SATA_MIN_INIT   = 12,
    parameter           SATA_MIN_WAKE   = 4,
    parameter           SATA_MAX_BURST  = 8,
    parameter           SATA_MIN_BURST  = 4,
    parameter           SATA_MAX_INIT   = 21,
    parameter           SATA_MAX_WAKE   = 7
)
(
    input   wire            reset, 
    input   wire            clk, 
    input   wire            usrclk2, 
    input   wire            RXN, 
    input   wire            RXP, 
    input   wire    [1:0]   RXELECIDLEMODE, 
    output  wire            RXELECIDLE, 
    output  wire            RXCOMINITDET, 
    output  wire            RXCOMWAKEDET 
);
localparam burst_min_len = 150;
localparam burst_max_len = 340;
localparam wake_idle_min_len = 150;
localparam wake_idle_max_len = 340;
localparam init_idle_min_len = 450;
localparam init_idle_max_len = 990;
localparam wake_bursts_cnt = SATA_BURST_VAL;
localparam init_bursts_cnt = SATA_BURST_VAL;
wire    idle;
assign  idle = (RXN == RXP) | (RXP === 1'bx) | (RXP === 1'bz); 
wire    state_notrans;
wire    state_error; 
wire    state_done; 
reg     state_idle; 
reg     state_burst; 
wire    set_notrans;
wire    set_done;
wire    set_error;
wire    set_idle;
wire    set_burst;
wire    clr_idle;
wire    clr_burst;
assign  state_notrans = ~state_idle & ~state_burst;
always @ (posedge clk)
begin
    state_idle  <= (state_idle | set_idle) & ~reset & ~clr_idle;
    state_burst <= (state_burst | set_burst) & ~reset & ~clr_burst;
end
assign  set_notrans = set_done | set_error;
assign  set_idle    = state_burst & clr_burst & idle;
assign  set_burst   = state_notrans & ~idle | state_idle & clr_idle & ~idle;
assign  clr_idle    = ~idle | set_notrans;
assign  clr_burst   = idle | set_notrans;
reg     [31:0]  burst_len;
reg     [31:0]  idle_len;
reg     [31:0]  bursts_cnt;
always @ (posedge clk)
begin
    burst_len   <= reset | ~state_burst ? 0 : burst_len + 1;
    idle_len    <= reset | ~state_idle ? 0 : idle_len + 1;
    bursts_cnt  <= reset | state_notrans ? 0 : state_burst & clr_burst ? bursts_cnt + 1 : bursts_cnt;
end
wire    burst_len_violation;
wire    idle_len_violation;
wire    wake_idle_violation;
wire    init_idle_violation;
reg     wake_idle_ok;
reg     init_idle_ok;
reg     burst_len_curr_ok;
reg     init_idle_curr_ok;
reg     wake_idle_curr_ok;
wire    done_wake;
wire    done_init;
always @ (posedge clk)
begin
    wake_idle_ok <= reset | state_notrans ? 1'b1 : wake_idle_violation ? 1'b0 : wake_idle_ok;
    init_idle_ok <= reset | state_notrans ? 1'b1 : init_idle_violation ? 1'b0 : init_idle_ok;
    wake_idle_curr_ok <= reset | ~state_idle ? 1'b0 : idle_len == wake_idle_min_len ? 1'b1 : wake_idle_curr_ok;
    init_idle_curr_ok <= reset | ~state_idle ? 1'b0 : idle_len == init_idle_min_len ? 1'b1 : init_idle_curr_ok;
    burst_len_curr_ok <= reset | ~state_burst? 1'b0 : burst_len == burst_min_len ? 1'b1 : burst_len_curr_ok;
end
assign  burst_len_violation = state_burst & set_idle & ~burst_len_curr_ok | state_burst & burst_len == burst_max_len;
assign  wake_idle_violation = state_idle & set_burst & ~wake_idle_curr_ok | state_idle & idle_len == wake_idle_max_len;
assign  init_idle_violation = state_idle & set_burst & ~init_idle_curr_ok | state_idle & idle_len == init_idle_max_len;
assign  idle_len_violation = (~wake_idle_ok | wake_idle_violation) & init_idle_violation | wake_idle_violation & (~init_idle_ok | init_idle_violation);
assign  done_wake   = state_burst & ~idle & bursts_cnt == (wake_bursts_cnt - 1) & wake_idle_ok;
assign  done_init   = state_burst & ~idle & bursts_cnt == (init_bursts_cnt - 1)& init_idle_ok;
assign  set_error   = idle_len_violation | burst_len_violation;
assign  set_done    = ~set_error & (done_wake | done_init);
reg rxcominitdet_clk = 1'b0;
reg rxcominitdet_usrclk2 = 1'b0;
reg rxcomwakedet_clk = 1'b0;
reg rxcomwakedet_usrclk2 = 1'b0;
always @ (posedge clk)
begin
    rxcominitdet_clk <= reset ? 1'b0 : done_init | rxcominitdet_clk & ~rxcominitdet_usrclk2;
    rxcomwakedet_clk <= reset ? 1'b0 : done_wake | rxcomwakedet_clk & ~rxcomwakedet_usrclk2;
end
always @ (posedge usrclk2)
begin
    rxcominitdet_usrclk2 <= reset ? 1'b0 : rxcominitdet_clk & ~rxcominitdet_usrclk2;
    rxcomwakedet_usrclk2 <= reset ? 1'b0 : rxcomwakedet_clk & ~rxcomwakedet_usrclk2;
end
assign  RXCOMINITDET = rxcominitdet_usrclk2;
assign  RXCOMWAKEDET = rxcomwakedet_usrclk2;
assign  RXELECIDLE = RXP === 1'bz ? 1'b1 : RXP === 1'bx ? 1'b1 : RXP == RXN;
endmodule 