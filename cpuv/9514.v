module uparc_lsu(
    clk,
    nrst,
    addr,
    wdata,
    rdata,
    cmd,
    rnw,
    busy,
    err_align,
    err_bus,
    o_DAddr,
    o_DCmd,
    o_DRnW,
    o_DBen,
    o_DData,
    i_DData,
    i_DRdy,
    i_DErr
);
localparam IDLE = 1'b0;     
localparam WAIT = 1'b1;     
input wire clk;              
input wire nrst;             
input wire [`UPARC_ADDR_WIDTH-1:0] addr; 
input wire [`UPARC_DATA_WIDTH-1:0] wdata; 
output reg [`UPARC_DATA_WIDTH-1:0] rdata; 
input wire [1:0] cmd;        
input wire rnw;              
output wire busy;            
output wire err_align;       
output wire err_bus;         
output reg [`UPARC_ADDR_WIDTH-1:0] o_DAddr; 
output reg o_DCmd;            
output reg o_DRnW;            
output reg [`UPARC_BEN_WIDTH-1:0] o_DBen; 
output reg [`UPARC_DATA_WIDTH-1:0] o_DData; 
input wire [`UPARC_DATA_WIDTH-1:0] i_DData; 
input wire i_DRdy;            
input wire i_DErr;            
assign err_align = (cmd == `UPARC_LSU_HWORD && addr[0] != 1'b0) ||
    (cmd == `UPARC_LSU_WORD && addr[1:0] != 2'b0);
wire active = (!err_align && !i_DErr && cmd != `UPARC_LSU_IDLE);
assign busy = ((active || (state == WAIT)) && !i_DRdy);
assign err_bus = i_DErr; 
always @(*)
begin
    o_DAddr = {(`UPARC_ADDR_WIDTH){1'b0}};
    o_DCmd = 1'b0;
    o_DRnW = 1'b0;
    o_DBen = {(`UPARC_BEN_WIDTH){1'b0}};
    o_DData = {(`UPARC_DATA_WIDTH){1'b0}};
    if(!err_align && cmd == `UPARC_LSU_BYTE)
    begin
        o_DAddr = { addr[`UPARC_ADDR_WIDTH-1:2], 2'b00 };
        case(addr[1:0])
        2'b00: begin
            o_DBen = 4'b0001;
            o_DData = wdata;
        end
        2'b01: begin
            o_DBen = 4'b0010;
            o_DData = { 16'b0, wdata[7:0], 8'b0 };
        end
        2'b10: begin
            o_DBen = 4'b0100;
            o_DData = { 8'b0, wdata[7:0], 16'b0 };
        end
        2'b11: begin
            o_DBen = 4'b1000;
            o_DData = { wdata[7:0], 24'b0 };
        end
        endcase
        o_DRnW = rnw;
        o_DCmd = 1'b1;
    end
    else if(!err_align && cmd == `UPARC_LSU_HWORD)
    begin
        o_DAddr = { addr[`UPARC_ADDR_WIDTH-1:2], 2'b00 };
        if(addr[1])
        begin
            o_DBen = 4'b1100;
            o_DData = { wdata[15:0], 16'b0 };
        end
        else
        begin
            o_DBen = 4'b0011;
            o_DData = wdata;
        end
        o_DRnW = rnw;
        o_DCmd = 1'b1;
    end
    else if(!err_align && cmd == `UPARC_LSU_WORD)
    begin
        o_DAddr = { addr[`UPARC_ADDR_WIDTH-1:2], 2'b00 };
        o_DBen = 4'hf;
        o_DData = wdata;
        o_DRnW = rnw;
        o_DCmd = 1'b1;
    end
end
function [`UPARC_DATA_WIDTH-1:0] shift_sdata;
input [`UPARC_DATA_WIDTH-1:0] sdata;
input [`UPARC_BEN_WIDTH-1:0] ben;
begin
    if(ben == 4'b1111 || ben == 4'b0011 || ben == 4'b0001)
    begin
        shift_sdata = sdata;
    end
    else if(ben == 4'b1100)
    begin
        shift_sdata = { 16'b0, sdata[31:16] };
    end
    else if(ben == 4'b1000)
    begin
        shift_sdata = { 24'b0, sdata[31:24] };
    end
    else if(ben == 4'b0100)
    begin
        shift_sdata = { 24'b0, sdata[23:16] };
    end
    else if(ben == 4'b0010)
    begin
        shift_sdata = { 24'b0, sdata[15:8] };
    end
    else
        shift_sdata = 32'b0;
end
endfunction
reg [`UPARC_BEN_WIDTH-1:0] lch_ben;     
reg [`UPARC_DATA_WIDTH-1:0] lch_rddata; 
reg state;                              
always @(posedge clk or negedge nrst)
begin
    if(!nrst)
    begin
        state <= IDLE;
        lch_ben <= {(`UPARC_BEN_WIDTH){1'b0}};
        lch_rddata <= {(`UPARC_DATA_WIDTH){1'b0}};
    end
    else
    begin
        if(state == IDLE && (active && i_DRdy))
        begin
            lch_ben <= o_DBen;
            lch_rddata <= i_DData;
        end
        if(state == IDLE && (active && !i_DRdy))
        begin
            state <= !i_DErr ? WAIT : IDLE;
            lch_ben <= o_DBen;
        end
        else if(state == WAIT && i_DRdy)
        begin
            state <= IDLE;
            lch_rddata <= i_DData;
        end
    end
end
always @(*)
begin
    if(active)
        rdata = shift_sdata(i_DData, o_DBen);
    else if(state == WAIT)
        rdata = shift_sdata(i_DData, lch_ben);
    else
        rdata = shift_sdata(lch_rddata, lch_ben);
end
endmodule