module gtxe2_chnl_cpll( 
    input   wire    CPLLLOCKDETCLK, 
    input   wire    CPLLLOCKEN, 
    input   wire    CPLLPD, 
    input   wire    CPLLRESET,  
    output  wire    CPLLFBCLKLOST, 
    output  wire    CPLLLOCK, 
    output  wire    CPLLREFCLKLOST, 
    input   wire    [15:0]  GTRSVD, 
    input   wire    [15:0]  PCSRSVDIN, 
    input   wire    [4:0]   PCSRSVDIN2, 
    input   wire    [4:0]   PMARSVDIN, 
    input   wire    [4:0]   PMARSVDIN2, 
    input   wire    [19:0]  TSTIN, 
    output  wire    [9:0]   TSTOUT, 
    input   wire    ref_clk, 
    output  wire    clk_out, 
    output  wire    pll_locked 
);
parameter   [23:0]  CPLL_CFG        = 29'h00BC07DC; 
parameter   integer CPLL_FBDIV      = 4; 
parameter   integer CPLL_FBDIV_45   = 5; 
parameter   [23:0]  CPLL_INIT_CFG   = 24'h00001E; 
parameter   [15:0]  CPLL_LOCK_CFG   = 16'h01E8; 
parameter   integer CPLL_REFCLK_DIV = 1; 
parameter   integer RXOUT_DIV       = 2; 
parameter   integer TXOUT_DIV       = 2; 
parameter           SATA_CPLL_CFG = "VCO_3000MHZ"; 
parameter   [1:0]   PMA_RSV3        = 1; 
localparam          multiplier  = CPLL_FBDIV * CPLL_FBDIV_45; 
localparam          divider     = CPLL_REFCLK_DIV; 
assign  pll_locked = locked; 
assign  CPLLLOCK = pll_locked; 
wire    fb_clk_out; 
wire    reset; 
reg     mult_clk; 
reg     mult_dev_clk; 
assign  clk_out = mult_dev_clk; 
assign reset = CPLLPD | CPLLRESET; 
time    last_edge;  
time    period;  
integer locked_f; 
reg     locked; 
initial
begin
    last_edge = 0; 
    period = 0; 
    forever @ (posedge ref_clk or posedge reset) 
    begin
        period      = reset ? 0 : $time - (last_edge == 0 ? $time : last_edge); 
        last_edge   = reset ? 0 : $time; 
    end
end
reg tmp = 0; 
initial
begin
    @ (posedge reset); 
    forever @ (posedge ref_clk) 
    begin
        tmp = ~tmp; 
        if (period > 0) 
        begin
            locked_f = 1; 
            mult_clk = 1'b1; 
            repeat (multiplier * 2 - 1) 
            begin
                #(period/multiplier/2) 
                mult_clk = ~mult_clk; 
            end
        end
        else
            locked_f = 0; 
    end
end
initial
begin
    mult_dev_clk = 1'b1; 
    forever
    begin
        repeat (divider) 
            @ (mult_clk); 
        mult_dev_clk = ~mult_dev_clk; 
    end
end
reg [31:0]  counter; 
always @ (posedge ref_clk or posedge reset) 
    counter <= reset | locked_f == 0 ? 0 : counter == `GTXE2_CHNL_CPLL_LOCK_TIME ? counter : counter + 1; 
always @ (posedge ref_clk) 
    locked <= counter == `GTXE2_CHNL_CPLL_LOCK_TIME; 
endmodule