module DRAM (
    input  wire              CLK,       
    input  wire              RST,       
    input  wire [1:0]        D_REQ,     
    input  wire [31:0]       D_INITADR, 
    input  wire [31:0]       D_ELEM,    
    input  wire [`DRAMW-1:0] D_DIN,     
    output wire              D_W,       
    output reg  [`DRAMW-1:0] D_DOUT,    
    output reg               D_DOUTEN,  
    output wire              D_BUSY     
);
localparam M_REQ   = 0; 
localparam M_WRITE = 1; 
localparam M_READ  = 2; 
reg [`DDR3_CMD]   app_cmd;          
reg               app_en;           
wire [`DRAMW-1:0] app_wdf_data;     
reg               app_wdf_wren;     
wire              app_wdf_end = app_wdf_wren; 
wire [`DRAMW-1:0] app_rd_data;      
wire              app_rd_data_end;  
wire              app_rd_data_valid = 1; 
wire              app_rdy = 1;      
wire              app_wdf_rdy = 1;  
wire              ui_clk = CLK;     
reg [1:0]         mode;             
reg [`DRAMW-1:0]  app_wdf_data_buf; 
reg [31:0]        caddr;            
reg [31:0]        remain, remain2;  
reg [7:0]         req_state;        
reg [`DRAMW-1:0]  mem [`DRAM_SIZE-1:0]; 
reg [31:0]        app_addr;         
reg [31:0]        dram_addr;        
always @(posedge CLK) dram_addr <= app_addr;
always @(posedge CLK) begin
    if (RST) begin
    end else if(app_wdf_wren) begin
        mem[dram_addr[27:3]] <= app_wdf_data;
    end
end
assign app_rd_data = mem[app_addr[27:3]]; 
assign app_wdf_data = D_DIN;              
assign D_BUSY = (mode != M_REQ); 
assign D_W = (mode == M_WRITE && app_rdy && app_wdf_rdy); 
always @(posedge ui_clk) begin
    if (RST) begin
        mode <= M_REQ;
        {app_addr, app_cmd, app_en, app_wdf_wren} <= 0;
        {D_DOUT, D_DOUTEN} <= 0;
        {caddr, remain, remain2, req_state} <= 0;
    end else begin
        case (mode)
            M_REQ: begin
                D_DOUTEN <= 0;
                if(D_REQ == `DRAM_REQ_WRITE) begin
                    app_cmd      <= `DRAM_CMD_WRITE;
                    mode         <= M_WRITE;
                    app_wdf_wren <= 0;
                    app_en       <= 1;
                    app_addr     <= D_INITADR;
                    remain       <= D_ELEM;
                end else if(D_REQ == `DRAM_REQ_READ) begin
                    app_cmd      <= `DRAM_CMD_READ;
                    mode         <= M_READ;
                    app_wdf_wren <= 0;
                    app_en       <= 1;
                    app_addr     <= D_INITADR;
                    remain       <= D_ELEM;
                    remain2      <= D_ELEM;
                end else begin
                    app_wdf_wren <= 0;
                    app_en       <= 0;
                end
            end
            M_READ: begin
                if (app_rdy) begin
                    app_addr <= (app_addr == `MEM_LAST_ADDR) ? 0 : app_addr + 8;
                    remain2 <= remain2 - 1;
                    if(remain2 == 1) app_en <= 0;
                end
                D_DOUTEN <= app_rd_data_valid;
                if (app_rd_data_valid) begin
                    D_DOUT <= app_rd_data;
                    caddr  <= (caddr == `MEM_LAST_ADDR) ? 0 : caddr + 8;
                    remain <= remain - 1;
                    if(remain == 1) begin
                        mode <= M_REQ;
                    end
                end
            end
            M_WRITE: begin
                if (app_rdy && app_wdf_rdy) begin
                    app_wdf_wren <= 1;
                    app_addr     <= (app_addr == `MEM_LAST_ADDR) ? 0 : app_addr + 8;
                    remain       <= remain - 1;
                    if(remain == 1) begin
                        mode   <= M_REQ;
                        app_en <= 0;
                    end
                end else begin
                    app_wdf_wren <= 0;
                end
            end
        endcase
    end
end
endmodule