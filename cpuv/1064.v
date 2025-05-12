module stack(
    input reset,          
    input clock,          
    input nip,            
    input dup,            
    input we,             
    input [`BITS-1:0] data_in,  
    output [`BITS-1:0] tos_out, 
    output [`BITS-1:0] nos_out  
);
    reg [`BITS-1:0] nos;  
    reg [`BITS-1:0] tos;  
    reg [`PTR-1:0] sp;    
    reg [`PTR-1:0] nsp;   
    reg [`BITS-1:0] cells[`DEPTH-1:0]; 
    always @* begin
        nsp = sp - 1; 
    end
    assign tos_out = cells[sp];  
    assign nos_out = cells[nsp]; 
    always @(posedge clock) begin
        if (reset) begin
            sp = `PTR 'b0000; 
            cells[sp] =  `BITS 'b0; 
            tos = `BITS 'b0; 
            nos = `BITS 'b0; 
        end
        tos = cells[sp];
        nos = cells[nsp];
        if (nip & !dup) begin 
            sp = sp - 1; 
        end
        if (dup & !nip) begin 
            sp = sp + 1; 
        end
        if (dup & nip) begin 
            cells[nsp] = tos; 
            tos = nos; 
        end
        if (we) begin 
            tos = data_in; 
        end
        cells[sp] = tos;
    end
endmodule