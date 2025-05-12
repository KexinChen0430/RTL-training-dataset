module contador_AD_MM_2dig
(
    input wire clk,          
    input wire reset,        
    input wire [3:0] en_count, 
    input wire enUP,         
    input wire enDOWN,       
    output wire [7:0] data_MM 
);
localparam N = 6;
reg [N-1:0] q_act, q_next; 
wire [N-1:0] count_data;   
reg [3:0] digit1, digit0;  
always@(posedge clk, posedge reset)
begin
    if(reset)
    begin
        q_act <= 6'b0; 
    end
    else
    begin
        q_act <= q_next; 
    end
end
always@*
begin
    if (en_count == 2) 
    begin
        if (enUP) 
        begin
            if (q_act >= 6'd59) q_next = 6'd0; 
            else q_next = q_act + 6'd1; 
        end
        else if (enDOWN) 
        begin
            if (q_act == 6'd0) q_next = 6'd59; 
            else q_next = q_act - 6'd1; 
        end
        else q_next = q_act; 
    end
    else q_next = q_act; 
end
assign count_data = q_act;
always@*
begin
    case(count_data)
        6'd0: begin digit1 = 4'b0000; digit0 = 4'b0000; end
        6'd59: begin digit1 = 4'b0101; digit0 = 4'b1001; end
        default:  begin digit1 = 0; digit0 = 0; end 
    endcase
end
assign data_MM = {digit1,digit0};
endmodule