module timer_periph
(
    clk_i,
    rst_i,
    intr_systick_o,
    intr_hires_o,
    addr_i,
    data_o,
    data_i,
    we_i,
    stb_i
);
parameter  [31:0]   CLK_KHZ                = 12288; 
parameter           SYSTICK_INTR_MS        = 1; 
parameter           ENABLE_SYSTICK_TIMER   = "ENABLED"; 
parameter           ENABLE_HIGHRES_TIMER   = "ENABLED"; 
input               clk_i ; 
input               rst_i ; 
output              intr_systick_o ; 
output              intr_hires_o ; 
input [7:0]         addr_i ; 
output [31:0]       data_o ; 
input [31:0]        data_i ; 
input               we_i ; 
input               stb_i ; 
reg [31:0]          data_o; 
reg                 systick_event; 
reg [31:0]          systick_count; 
reg [31:0]          systick_clk_count; 
reg                 hr_timer_intr; 
reg [31:0]          hr_timer_cnt; 
reg [31:0]          hr_timer_match; 
generate
if (ENABLE_SYSTICK_TIMER == "ENABLED")
begin
    always @ (posedge rst_i or posedge clk_i )
    begin
        if (rst_i == 1'b1) 
        begin
            systick_count        <= 32'h00000000;
            systick_clk_count    <= 32'h00000000;
            systick_event        <= 1'b0;
        end
        else 
        begin
            systick_event         <= 1'b0;
            if (systick_clk_count == CLK_KHZ) 
            begin
                systick_count     <= (systick_count + 1);
                systick_event     <= 1'b1;
                systick_clk_count <= 32'h00000000;
            end
            else
                systick_clk_count <= (systick_clk_count + 1);
        end
    end
    integer systick_event_count; 
    reg     systick_event_intr; 
    always @ (posedge rst_i or posedge clk_i )
    begin
        if (rst_i == 1'b1) 
        begin
            systick_event_count  <= 0;
            systick_event_intr   <= 1'b0;
        end
        else 
        begin
            systick_event_intr  <= 1'b0;
            if (systick_event) 
            begin
                systick_event_count <= (systick_event_count + 1);
                if (systick_event_count == (SYSTICK_INTR_MS-1))
                begin
                    systick_event_intr  <= 1'b1;
                    systick_event_count <= 0;
                end
            end
        end
    end
    assign intr_systick_o = systick_event_intr;
end
else 
begin
    always @ (posedge rst_i or posedge clk_i )
    begin
        if (rst_i == 1'b1)
            systick_count   <= 32'h00000000;
        else
            systick_count   <= 32'h00000000;
    end
    assign  intr_systick_o  = 1'b0;
end
endgenerate
generate
if (ENABLE_HIGHRES_TIMER == "ENABLED")
begin
    always @ (posedge rst_i or posedge clk_i)
    begin
        if (rst_i == 1'b1) 
        begin
            hr_timer_cnt     <= 32'h00000000;
            hr_timer_intr    <= 1'b0;
        end
        else 
        begin
            hr_timer_intr   <= 1'b0;
            hr_timer_cnt    <= (hr_timer_cnt + 1);
            if ((hr_timer_match != 32'h00000000) && (hr_timer_match == hr_timer_cnt))
                hr_timer_intr   <= 1'b1;
        end
    end
    assign intr_hires_o        = hr_timer_intr;
end
else 
begin
    always @ (posedge rst_i or posedge clk_i )
    begin
        if (rst_i == 1'b1)
            hr_timer_cnt   <= 32'h00000000;
        else
            hr_timer_cnt   <= 32'h00000000;
    end
    assign intr_hires_o     = 1'b0;
end
endgenerate
always @ (posedge rst_i or posedge clk_i )
begin
   if (rst_i == 1'b1) 
   begin
       hr_timer_match   <= 32'h00000000;
   end
   else 
   begin
       if (we_i & stb_i)
       begin
           case (addr_i)
           `TIMER_HIRES :
                hr_timer_match <= data_i;
           default :
               ;
           endcase
        end
   end
end
always @ *
begin
   case (addr_i[7:0])
   `TIMER_SYSTICK_VAL :
        data_o = systick_count;
   `TIMER_HIRES :
        data_o = hr_timer_cnt;
   default :
        data_o = 32'h00000000;
   endcase
end
endmodule