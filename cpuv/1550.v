module nova_ram(pclk, prst, mm_adr, mm_we, mm_din, mm_dout);
   parameter addr_width = 16;
   parameter mem_size = 1 << addr_width;
   parameter mem_mask = mem_size-1;
   input pclk; 
   input prst; 
   input [0:15] mm_adr; 
   input mm_we; 
   input [0:15] mm_din; 
   output [0:15] mm_dout; 
   reg [0:15] m_mem[0:mem_size]; 
   wire [0:addr_width-1] w_adr_masked; 
   integer i; 
   assign w_adr_masked = mm_adr[0:addr_width-1]; 
   assign mm_dout = (~mm_we) ? m_mem[w_adr_masked] : 16'h0000; 
   always @(posedge pclk) begin
      if(prst) begin
         for(i = 0; i < mem_size; i = i + 1)
            m_mem[i] = 16'h0000;
         m_mem[1] = 16'b0000_0000_0000_0100; 
         m_mem[2][0:2] = 3'b011;
         m_mem[2][`NOVA_IO_TRANSFER] = `NOVA_IO_TRANSFER_DIC;
         m_mem[2][`NOVA_IO_CONTROL] = `NOVA_IO_CONTROL_CLR;
         m_mem[2][`NOVA_IO_DEVICE] = 6'o77;
         m_mem[3][`NOVA_LS_DISPLACE] = 8'h2;
         m_mem[4][0:2] = 3'b011;
         m_mem[4][`NOVA_IO_TRANSFER] = `NOVA_IO_TRANSFER_DOC;
         m_mem[4][`NOVA_IO_CONTROL] = `NOVA_IO_CONTROL_CLR;
         m_mem[4][`NOVA_IO_DEVICE] = 6'o77;
      end
      else begin
         if(mm_we) begin
            m_mem[w_adr_masked] <= mm_din;
         end
      end
   end
endmodule