module BFM_APB2APB (
    input PCLK_PM,          
    input PRESETN_PM,       
    input [31:0] PADDR_PM,  
    input PWRITE_PM,        
    input PENABLE_PM,       
    input [31:0] PWDATA_PM, 
    output [31:0] PRDATA_PM,
    output PREADY_PM,       
    output PSLVERR_PM,      
    input PCLK_SC,          
    output [15:0] PSEL_SC,  
    output [31:0] PADDR_SC, 
    output PWRITE_SC,       
    output PENABLE_SC,      
    output [31:0] PWDATA_SC,
    input [31:0] PRDATA_SC, 
    input PREADY_SC,        
    input PSLVERR_SC        
);
    parameter [9:0] TPD = 1;
    localparam TPDns = TPD * 1;
    reg [31:0] PRDATA_PM;
    reg PREADY_PM;
    reg PSLVERR_PM;
    wire [15:0] #TPDns PSEL_SC;
    wire [31:0] #TPDns PADDR_SC;
    wire #TPDns PWRITE_SC;
    wire #TPDns PENABLE_SC;
    wire [31:0] #TPDns PWDATA_SC;
    parameter [0:0] IDLE = 0;
    parameter [0:0] ACTIVE = 1;
    reg [0:0] STATE_PM;
    parameter [1:0] T0 = 0;
    parameter [1:0] T1 = 1;
    parameter [1:0] T2 = 2;
    reg [1:0] STATE_SC;
    reg [15:0] PSEL_P0;
    reg [31:0] PADDR_P0;
    reg PWRITE_P0;
    reg PENABLE_P0;
    reg [31:0] PWDATA_P0;
    reg PSELEN;
    reg [31:0] PRDATA_HD;
    reg PSLVERR_HD;
    reg PENABLE_PM_P0;
    reg TRIGGER;
    reg DONE;
    always @(posedge PCLK_PM or negedge PRESETN_PM)
    begin
        if (PRESETN_PM == 1'b0)
        begin
            STATE_PM <= IDLE;
            TRIGGER <= 1'b0;
            PREADY_PM <= 1'b0;
            PSLVERR_PM <= 1'b0;
            PRDATA_PM <= {32{1'b0}};
            PENABLE_PM_P0 <= 1'b0;
        end
        else
        begin
            PREADY_PM <= 1'b0;
            PENABLE_PM_P0 <= PENABLE_PM;
            case (STATE_PM)
                IDLE:
                    begin
                        if (PENABLE_PM == 1'b1 & PENABLE_PM_P0 == 1'b0)
                        begin
                            TRIGGER <= 1'b1;
                            STATE_PM <= ACTIVE;
                        end
                    end
                ACTIVE:
                    begin
                        if (DONE == 1'b1)
                        begin
                            STATE_PM <= IDLE;
                            TRIGGER <= 1'b0;
                            PREADY_PM <= 1'b1;
                            PSLVERR_PM <= PSLVERR_HD;
                            PRDATA_PM <= PRDATA_HD;
                        end
                    end
            endcase
        end
    end
    always @(posedge PCLK_SC or negedge TRIGGER)
    begin
        if (TRIGGER == 1'b0)
        begin
            STATE_SC <= T0;
            DONE <= 1'b0;
            PRDATA_HD <= {32{1'b0}};
            PSLVERR_HD <= 1'b0;
            PSELEN <= 1'b0;
            PENABLE_P0 <= 1'b0;
            PADDR_P0 <= {32{1'b0}};
            PWDATA_P0 <= {32{1'b0}};
            PWRITE_P0 <= 1'b0;
        end
        else
        begin
            case (STATE_SC)
                T0:
                    begin
                        STATE_SC <= T1;
                        PADDR_P0 <= PADDR_PM;
                        PWDATA_P0 <= PWDATA_PM;
                        PWRITE_P0 <= PWRITE_PM;
                        PSELEN <= 1'b1;
                        PENABLE_P0 <= 1'b0;
                        DONE <= 1'b0;
                    end
                T1:
                    begin
                        STATE_SC <= T2;
                        PENABLE_P0 <= 1'b1;
                    end
                T2:
                    begin
                        if (PREADY_SC == 1'b1)
                        begin
                            DONE <= 1'b1;
                            PRDATA_HD <= PRDATA_SC;
                            PSLVERR_HD <= PSLVERR_SC;
                            PSELEN <= 1'b0;
                            PENABLE_P0 <= 1'b0;
                            PADDR_P0 <= {32{1'b0}};
                            PWDATA_P0 <= {32{1'b0}};
                            PWRITE_P0 <= 1'b0;
                        end
                    end
            endcase
        end
    end
    always @(PADDR_P0 or PSELEN)
    begin
        PSEL_P0 <= {16{1'b0}};
        if (PSELEN == 1'b1)
        begin
            begin : xhdl_5
                integer i;
                for(i = 0; i <= 15; i = i + 1)
                begin
                    PSEL_P0[i] <= (PADDR_P0[27:24] == i);
                end
            end
        end
    end
    assign PSEL_SC    = PSEL_P0;
    assign PADDR_SC   = PADDR_P0;
    assign PWRITE_SC  = PWRITE_P0;
    assign PENABLE_SC = PENABLE_P0;
    assign PWDATA_SC  = PWDATA_P0;
endmodule