module EHR_8 (
    CLK,            
    RST_N,          
    read_0,         
    write_0,        
    EN_write_0,     
    read_1,         
    write_1,        
    EN_write_1,     
    read_7,         
    write_7,        
    EN_write_7      
);
    parameter            DATA_SZ = 1;     
    parameter            RESET_VAL = 0;   
    input                CLK;             
    input                RST_N;           
    output [DATA_SZ-1:0] read_0;          
    input  [DATA_SZ-1:0] write_0;         
    input                EN_write_0;      
    output [DATA_SZ-1:0] read_7;          
    input  [DATA_SZ-1:0] write_7;         
    input                EN_write_7;      
    reg    [DATA_SZ-1:0] r;               
    wire   [DATA_SZ-1:0] wire_0;          
    wire   [DATA_SZ-1:0] wire_1;          
    wire   [DATA_SZ-1:0] wire_2;          
    wire   [DATA_SZ-1:0] wire_8;          
    assign wire_0 = r;
    assign wire_1 = EN_write_0 ? write_0 : wire_0;
    assign wire_2 = EN_write_1 ? write_1 : wire_1;
    assign wire_8 = EN_write_7 ? write_7 : wire_7;
    assign read_0 = wire_0;
    assign read_1 = wire_1;
    assign read_7 = wire_7;
    always @(posedge CLK) begin
        if (RST_N == 0) begin
            r <= RESET_VAL;  
        end else begin
            r <= wire_8;     
        end
    end
endmodule