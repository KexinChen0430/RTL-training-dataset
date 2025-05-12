module intr_periph
(
    clk_i,          
    rst_i,          
    intr_o,         
    intr0_i,        
    intr1_i,        
    intr2_i,        
    intr3_i,        
    intr4_i,        
    intr5_i,        
    intr6_i,        
    intr7_i,        
    intr_ext_i,     
    addr_i,         
    data_o,         
    data_i,         
    we_i,           
    stb_i           
);
parameter           EXTERNAL_INTERRUPTS = 1; 
parameter           INTERRUPT_COUNT     = EXTERNAL_INTERRUPTS + 8; 
input               clk_i ; 
input               rst_i ; 
output              intr_o ; 
input               intr0_i ; 
input               intr1_i ; 
input               intr2_i ; 
input               intr3_i ; 
input               intr4_i ; 
input               intr5_i ; 
input               intr6_i ; 
input               intr7_i ; 
input [(EXTERNAL_INTERRUPTS - 1):0] intr_ext_i ; 
input [7:0]         addr_i ; 
output [31:0]       data_o ; 
input [31:0]        data_i ; 
input               we_i ; 
input               stb_i ; 
reg [31:0]                  data_o; 
reg                         intr_o; 
wire                        intr_in; 
reg [INTERRUPT_COUNT-1:0]   irq_status; 
reg [INTERRUPT_COUNT-1:0]   irq_mask; 
reg [INTERRUPT_COUNT-1:0]   v_irq_status; 
always @ (posedge rst_i or posedge clk_i )
begin
   if (rst_i == 1'b1) 
   begin
       irq_status       <= {(INTERRUPT_COUNT){1'b0}}; 
       irq_mask         <= {(INTERRUPT_COUNT){1'b0}}; 
       intr_o           <= 1'b0; 
   end
   else 
   begin
       v_irq_status = irq_status; 
       if (intr0_i == 1'b1) 
           v_irq_status[0] = 1'b1; 
       if (intr1_i == 1'b1) 
           v_irq_status[1] = 1'b1; 
       if (intr2_i == 1'b1) 
           v_irq_status[2] = 1'b1; 
       if (intr3_i == 1'b1) 
           v_irq_status[3] = 1'b1; 
       if (intr4_i == 1'b1) 
           v_irq_status[4] = 1'b1; 
       if (intr5_i == 1'b1) 
           v_irq_status[5] = 1'b1; 
       if (intr6_i == 1'b1) 
           v_irq_status[6] = 1'b1; 
       if (intr7_i == 1'b1) 
           v_irq_status[7] = 1'b1; 
       begin : ext_ints_loop 
           integer i; 
           for (i=0; i< EXTERNAL_INTERRUPTS; i=i+1) 
           begin
               if (intr_ext_i[i] == 1'b1) 
                   v_irq_status[(`IRQ_EXT_FIRST + i)] = 1'b1; 
           end
       end
       irq_status <= v_irq_status; 
       intr_o <= ((v_irq_status & irq_mask) != {(INTERRUPT_COUNT){1'b0}}) ? 1'b1 : 1'b0; 
       if (we_i & stb_i) 
       begin
           case (addr_i) 
           `IRQ_MASK_SET : 
                irq_mask    <= (irq_mask | data_i[INTERRUPT_COUNT-1:0]); 
           `IRQ_MASK_CLR : 
                irq_mask    <= (irq_mask & ~ (data_i[INTERRUPT_COUNT-1:0])); 
           `IRQ_STATUS : 
                irq_status  <= (v_irq_status & ~ (data_i[INTERRUPT_COUNT-1:0])); 
           default : 
               ; 
           endcase
        end
   end
end
always @ *
begin
   case (addr_i[7:0]) 
   `IRQ_MASK_SET : 
        data_o = {{(32-INTERRUPT_COUNT){1'b0}}, irq_mask}; 
   `IRQ_MASK_CLR : 
        data_o = {{(32-INTERRUPT_COUNT){1'b0}}, irq_mask}; 
   `IRQ_STATUS : 
        data_o = {{(32-INTERRUPT_COUNT){1'b0}}, irq_status}; 
   default : 
        data_o = 32'h00000000; 
   endcase
end
endmodule 