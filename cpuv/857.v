module mux2x4(
    data0,        
    data1,        
    data2,        
    data3,        
    selectInput,  
    out           
);
    output reg [1:0] out;
    input  [1:0] data0, data1, data2, data3;
    input  [1:0] selectInput;
    always@(data0 or data1 or data2 or data3 or selectInput) begin
        case(selectInput)
            0: out = data0; 
            1: out = data1; 
            2: out = data2; 
            3: out = data3; 
        endcase
    end
endmodule