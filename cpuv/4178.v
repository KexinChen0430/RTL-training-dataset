module
   output reg                             dram_reg_req,
   output reg                             dram_reg_rd_wr_L,
   output reg [`DRAM_REG_ADDR_WIDTH - 1:0] dram_reg_addr,
   output reg [`CPCI_NF2_DATA_WIDTH-1:0]  dram_reg_wr_data,
   input                                  dram_reg_ack,
   input [`CPCI_NF2_DATA_WIDTH-1:0]       dram_reg_rd_data,
   input                                  clk,
   input                                  reset);
localparam CORE_TAG_ADDR       = { {(`CPCI_NF2_ADDR_WIDTH - 2 - `CORE_BLOCK_ADDR_WIDTH - `CORE_REG_ADDR_WIDTH){1'b0}},
                                     `CORE_BLOCK_ADDR,
                                     {(`CORE_REG_ADDR_WIDTH) {1'b?}}};
localparam SRAM_TAG_ADDR       = { {(`CPCI_NF2_ADDR_WIDTH - 2 - `SRAM_BLOCK_ADDR_WIDTH - `SRAM_REG_ADDR_WIDTH){1'b0}},
                                     `SRAM_BLOCK_ADDR,
                                     {(`SRAM_REG_ADDR_WIDTH) {1'b?}}};
localparam UDP_TAG_ADDR       = { {(`CPCI_NF2_ADDR_WIDTH - 2 - `UDP_BLOCK_ADDR_WIDTH - `UDP_REG_ADDR_WIDTH){1'b0}},
                                     `UDP_BLOCK_ADDR,
                                     {(`UDP_REG_ADDR_WIDTH) {1'b?}}};
localparam DRAM_TAG_ADDR       = { {(`CPCI_NF2_ADDR_WIDTH - 2 - `DRAM_BLOCK_ADDR_WIDTH - `DRAM_REG_ADDR_WIDTH){1'b0}},
                                     `DRAM_BLOCK_ADDR,
                                     {(`DRAM_REG_ADDR_WIDTH) {1'b?}}};
localparam
   IDLE_STATE = 2'h0,
   GET_REQ_STATE = 2'h1,
   WAIT_ACK_STATE = 2'h2;
localparam
   TIMEOUT_COUNT_DOWN = 9'd511;
reg                              cpu_req, cpu_req_nxt;
reg                              cpu_rd_wr_L, cpu_rd_wr_L_nxt;
reg [`CPCI_NF2_ADDR_WIDTH -3: 0] cpu_addr, cpu_addr_nxt;
reg [`CPCI_NF2_DATA_WIDTH -1: 0] cpu_wr_data, cpu_wr_data_nxt;
reg                              cpu_ack;
reg [`CPCI_NF2_DATA_WIDTH -1: 0] cpu_rd_data;
reg [8:0]                        cpu_timeout_cnt_dn, cpu_timeout_cnt_dn_nxt;
reg [1:0]                        state, state_nxt;
always @(*) begin
   fifo_rd_en = 1'b 0;
   bus_rd_data = {`CPCI_NF2_DATA_WIDTH {1'b 0}};
   bus_rd_vld = 1'b 0;
   cpu_req_nxt = cpu_req;
   cpu_rd_wr_L_nxt = cpu_rd_wr_L;
   cpu_addr_nxt = cpu_addr;
   cpu_wr_data_nxt = cpu_wr_data;
   cpu_timeout_cnt_dn_nxt = cpu_timeout_cnt_dn;
   state_nxt = state;
   case (state)
      IDLE_STATE: begin
         if (! fifo_empty) begin
            fifo_rd_en = 1'b1;
            state_nxt = GET_REQ_STATE;
         end   
      end   
      GET_REQ_STATE: begin
         cpu_req_nxt = 1'b 1;
         cpu_addr_nxt = bus_addr[`CPCI_NF2_ADDR_WIDTH-1:2];
         cpu_timeout_cnt_dn_nxt = TIMEOUT_COUNT_DOWN;
         state_nxt = WAIT_ACK_STATE;
         if (bus_rd_wr_L) begin     
            cpu_wr_data_nxt = {`CPCI_NF2_DATA_WIDTH {1'b 0}};
            cpu_rd_wr_L_nxt = 1'b 1;
         end   
         else begin                 
            cpu_rd_wr_L_nxt = 1'b 0;
            cpu_wr_data_nxt = bus_wr_data;
         end   
      end   
      WAIT_ACK_STATE: begin
         cpu_timeout_cnt_dn_nxt = cpu_timeout_cnt_dn - 1;
         if (cpu_ack || !(|cpu_timeout_cnt_dn)) begin
            if(cpu_timeout_cnt_dn==0) begin
               $display("%t %m ERROR: Timeout while waiting for ack for register access.", $time);
            end
            cpu_rd_wr_L_nxt = 1'b 1;
            if (cpu_rd_wr_L) begin
               bus_rd_data = (cpu_ack === 1'b1) ? cpu_rd_data : 'h deadbeef;
               bus_rd_vld = 1'b 1;
            end   
            cpu_req_nxt = 1'b 0;
            if (! fifo_empty) begin
               fifo_rd_en = 1'b 1;
               state_nxt = GET_REQ_STATE;
            end
            else
              state_nxt = IDLE_STATE;
         end 
      end   
   endcase 
end 
always @(posedge clk) begin
   if (reset) begin
      state <= IDLE_STATE;
      cpu_req <= 1'b 0;
      cpu_rd_wr_L <= 1'b 0;
      cpu_addr <= {(`CPCI_NF2_ADDR_WIDTH-2) {1'b 0}};
      cpu_wr_data <= {`CPCI_NF2_DATA_WIDTH {1'b 0}};
      cpu_timeout_cnt_dn <= 7'h 0;
   end   
   else begin
      state <= state_nxt;
      cpu_req <= cpu_req_nxt;
      cpu_rd_wr_L <= cpu_rd_wr_L_nxt;
      cpu_addr <= cpu_addr_nxt;
      cpu_wr_data <= cpu_wr_data_nxt;
      cpu_timeout_cnt_dn <= cpu_timeout_cnt_dn_nxt;
   end   
end 
always @(posedge clk) begin
   if(reset) begin
      cpu_ack <= 1'b 0;
      cpu_rd_data <= {`CPCI_NF2_DATA_WIDTH {1'b 0}};
      core_reg_req <= 1'b 0;
      core_reg_rd_wr_L <= 1'b 1;
      core_reg_addr <= {`CORE_REG_ADDR_WIDTH {1'b 0}};
      core_reg_wr_data <= {`CPCI_NF2_DATA_WIDTH {1'b 0}};
      udp_reg_req <= 1'b 0;
      udp_reg_rd_wr_L <= 1'b 1;
      udp_reg_addr <= {`UDP_REG_ADDR_WIDTH {1'b 0}};
      udp_reg_wr_data <= {`CPCI_NF2_DATA_WIDTH {1'b 0}};
      sram_reg_req <= 1'b 0;
      sram_reg_rd_wr_L <= 1'b 1;
      sram_reg_addr <= {`SRAM_REG_ADDR_WIDTH {1'b 0}};
      sram_reg_wr_data <= {`CPCI_NF2_DATA_WIDTH {1'b 0}};
      dram_reg_req <= 1'b 0;
      dram_reg_rd_wr_L <= 1'b 1;
      dram_reg_addr <= {`DRAM_REG_ADDR_WIDTH {1'b 0}};
      dram_reg_wr_data <= {`CPCI_NF2_DATA_WIDTH {1'b 0}};
   end 
   else begin
      casez (cpu_addr)
        CORE_TAG_ADDR: begin
           cpu_ack <= core_reg_ack;
           cpu_rd_data <= core_reg_rd_data;
           core_reg_req <= cpu_req;
           core_reg_rd_wr_L <= cpu_rd_wr_L;
           core_reg_addr <= cpu_addr[`CORE_REG_ADDR_WIDTH-1:0];
           core_reg_wr_data <= cpu_wr_data;
        end
        UDP_TAG_ADDR: begin
           cpu_ack <= udp_reg_ack;
           cpu_rd_data <= udp_reg_rd_data;
           udp_reg_req <= cpu_req;
           udp_reg_rd_wr_L <= cpu_rd_wr_L;
           udp_reg_addr <= cpu_addr[`UDP_REG_ADDR_WIDTH-1:0];
           udp_reg_wr_data <= cpu_wr_data;
        end
        SRAM_TAG_ADDR: begin
           cpu_ack <= sram_reg_ack;
           cpu_rd_data <= sram_reg_rd_data;
           sram_reg_req <= cpu_req;
           sram_reg_rd_wr_L <= cpu_rd_wr_L;
           sram_reg_addr <= cpu_addr[`SRAM_REG_ADDR_WIDTH-1:0];
           sram_reg_wr_data <= cpu_wr_data;
        end
        DRAM_TAG_ADDR: begin
           cpu_ack <= dram_reg_ack;
           cpu_rd_data <= dram_reg_rd_data;
           dram_reg_req <= cpu_req;
           dram_reg_rd_wr_L <= cpu_rd_wr_L;
           dram_reg_addr <= cpu_addr[`DRAM_REG_ADDR_WIDTH-1:0];
           dram_reg_wr_data <= cpu_wr_data;
        end
        default: begin
           cpu_ack <= cpu_req;
           cpu_rd_data <= 32'h DEAD_BEEF;
        end 
      endcase  
   end 
end 
assign out_ack  = cpu_ack;
endmodule