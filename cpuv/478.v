module fifo(
    datain,  
    rd,      
    wr,      
    rst,     
    clk,     
    full,    
    empty,   
    led_n,   
    wei      
);
input [3:0] datain;
input rd, wr, rst, clk;
output [6:0] led_n;
output full, empty, wei;
reg [3:0] dataout;          
reg full_in, empty_in, wei_in, div; 
reg [3:0] mem [15:0];       
reg [23:0] cnt;             
reg [3:0] rp, wp;           
reg [6:0] led_n;            
assign full = full_in;
assign empty = empty_in;
assign wei = wei_in;
parameter
    reg0 = 7'b0000001,
    reg1 = 7'b1001111,
    regf = 7'b0111000;
always @(posedge clk) begin
    if (cnt == 24'b111111111111111111111111) begin
        div <= ~div; 
        cnt <= 0;    
    end else begin
        cnt <= cnt + 1; 
    end
end
always @(posedge clk) begin
    wei_in <= 1'b0;
end
always @(posedge div) begin
    if (~wr && ~full_in) begin
        mem[wp] <= datain;
    end
end
always @(posedge div) begin
    if (!rst) begin
        wp <= 0; 
    end else if (~wr && ~full_in) begin
        wp <= wp + 1'b1; 
    end
end
always @(posedge div) begin
    if (!rst) begin
        rp <= 0; 
    end else if (~rd && ~empty_in) begin
        rp <= rp + 1'b1; 
    end
end
always @(posedge div) begin
    if (!rst) begin
        full_in <= 1'b0; 
    end else if (rd && ~wr) begin
        if ((wp == rp - 1) || (rp == 4'h0 && wp == 4'hf)) begin
            full_in <= 1'b1; 
        end
    end else if (full_in && ~rd) begin
        full_in <= 1'b0; 
    end
end
always @(posedge div) begin
    if (!rst) begin
        empty_in <= 1'b1; 
    end else if (~rd && wr) begin
        if (rp == wp - 1 || (rp == 4'hf && wp == 4'h0)) begin
            empty_in <= 1'b1; 
        end
    end else if (empty_in && ~wr) begin
        empty_in <= 1'b0; 
    end
end
always @(posedge div) begin
    if (~rd && ~empty_in) begin
        dataout <= mem[rp]; 
        case (dataout)
            4'h0: led_n <= reg0;
            4'h1: led_n <= reg1;
            4'hf: led_n <= regf;
            default: ; 
        endcase
    end
end
endmodule