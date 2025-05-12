module nrzi_4b5b_decoder
(
    input clk80,       
    input reset,       
    input enable,      
    input [4:0]din,    
    output reg [3:0]dout, 
    output reg error   
);
    reg [4:0]d;        
    reg inv;           
    always @(posedge clk80 or posedge reset)
    begin
        if (reset)
        begin
            d     <= 5'b00000; 
            inv   <= 0;        
            dout  <= 4'b1010;  
            error <= 0;        
        end
        else
        begin
            if (enable)
            begin
                d <= inv ? din : ~din;
                inv <= din[0];
                case (d)
                    5'b01011: {dout,error} <= 5'b0000_0;
                    5'b10001: {dout,error} <= 5'b0001_0;
                    5'b01001: {dout,error} <= 5'b1111_0;
                    default:  {dout,error} <= 5'b1010_1; 
                endcase
            end
        end
    end
endmodule