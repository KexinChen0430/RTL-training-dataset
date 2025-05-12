module divider(
    input  [10:0]  opa,       
    input  [3:0]   opb,       
    output [10:0]  quo,       
    output [10:0]  rem        
);
reg [10:0] quo, rem;
reg [10:0] quotient0;
reg [10:0] dividend_copy0, diff0;
reg [10:0] divider_copy0;
wire [10:0] remainder0;
always @ (opa or opb)
begin
    quotient0 = 11'b00000000000;       
    dividend_copy0 = opa;              
    divider_copy0 = {opb,7'b0000000};  
    diff1 = dividend_copy0 - divider_copy0;  
    quotient1[10:1] = quotient0[9:0];       
    if (!diff1[10])                          
    begin
        dividend_copy1 = diff1;              
        quotient1[0] = 1'b1;                
    end
    else                                     
    begin
        dividend_copy1 = dividend_copy0;     
        quotient1[0] = 1'b0;                
    end
    divider_copy1 = (divider_copy0 >> 1);    
    quo = quotient8;                         
    rem = dividend_copy8;                    
end
endmodule