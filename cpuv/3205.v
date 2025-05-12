module k580vt57
(
    input         clk,        
    input         ce_dma,     
    input         reset,      
    input   [3:0] iaddr,      
    input   [7:0] idata,      
    input   [3:0] drq,        
    input         iwe_n,      
    input         ird_n,      
    input         hlda,       
    output        hrq,        
    output  [3:0] dack,       
    output  [7:0] odata,      
    output [15:0] oaddr,      
    output        owe_n,      
    output        ord_n,      
    output        oiowe_n,    
    output        oiord_n     
);
parameter ST_IDLE = 0; 
parameter ST_WAIT = 1; 
parameter ST_T1   = 2; 
parameter ST_T2   = 3; 
parameter ST_T3   = 4; 
reg  [3:0] ack;          
reg  [2:0] state;        
reg  [1:0] channel;      
reg  [7:0] mode;         
reg  [3:0] chstate;      
reg [15:0] chaddr[3:0];  
reg [15:0] chtcnt[3:0];  
reg        ff;           
reg        exiwe_n;      
assign dack    = ack;    
assign hrq     = state != ST_IDLE; 
assign odata   = {4'd0, chstate};  
assign oaddr   = chaddr[channel];  
assign owe_n   = chtcnt[channel][14] == 0 || state != ST_T2;
assign ord_n   = chtcnt[channel][15] == 0 || (state != ST_T1 && state != ST_T2);
assign oiowe_n = chtcnt[channel][15] == 0 || state != ST_T2;
assign oiord_n = chtcnt[channel][14] == 0 || (state != ST_T1 && state != ST_T2);
wire[3:0] mdrq = drq & mode[3:0];
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0; ff <= 0; mode <= 0; exiwe_n <= 1;
        chstate <= 0; ack <= 0;
    end else begin
        exiwe_n <= iwe_n;
        if (iwe_n && ~exiwe_n) begin
            ff <= ~(ff | iaddr[3]);
            case({ff, iaddr})
            endcase
        end
        if(ce_dma) begin
            case (state)
                ST_IDLE: begin
                end
                ST_WAIT: begin
                end
                ST_T1: begin
                end
                ST_T2: begin
                end
                ST_T3: begin
                end
            endcase
        end
    end
end
endmodule