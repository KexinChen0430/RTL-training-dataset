module alu(input wire [3:0]    alu_op_i,  
           input wire [`N-1:0] a_i,       
           input wire [`N-1:0] b_i,       
           output reg [`N-1:0] out_o,     
	   output reg [3:0] flags_o);   
wire [`N-1:0] 		add_r;          
wire [`N-1:0] 		sub_r;          
wire 			oflow_add;      
wire 			oflow_sub;      
wire signed [`N-1:0] 	a_signed;      
wire signed [`N-1:0] 	b_signed;      
assign a_signed  = a_i;
assign b_signed  = b_i;
assign add_r = a_i + b_i;
assign sub_r = a_i - b_i;
assign oflow_add = (a_i[`N-1] == b_i[`N-1] && add_r[`N-1] != a_i[`N-1]) ? 1 : 0;
assign oflow_sub = (a_i[`N-1] == b_i[`N-1] && sub_r[`N-1] != a_i[`N-1]) ? 1 : 0;
always @(*) begin
    if (alu_op_i != 4'hE) begin
        flags_o[1]  = a_i > b_i;     
        flags_o[2]  = a_i == b_i;    
        flags_o[3]  = out_o > 0;     
    end
    else begin
        flags_o[1]  = a_signed > b_signed; 
        flags_o[2]  = a_signed == b_signed; 
        flags_o[3]  = out_o > 0;            
    end
    case (alu_op_i)
        4'h0: flags_o[0] = oflow_add; 
        4'h1: flags_o[0] = oflow_sub; 
        default: flags_o[0] = 1'b0;    
    endcase
    case (alu_op_i)
        4'h0: out_o = add_r;           
        4'h1: out_o = sub_r;           
        4'h2: out_o = a_i >> b_i;      
        4'h3: out_o = a_i << b_i;      
        4'h4: out_o = ~a_i;            
        4'h5: out_o = a_i & b_i;       
        4'h6: out_o = a_i | b_i;       
        4'h7: out_o = a_i ^ b_i;       
        4'h8: out_o = a_i * b_i;       
        4'h9: out_o = a_i / b_i;       
        4'hA: out_o = a_i % b_i;       
        4'hF: out_o = a_i;             
        default: out_o = `N'h0;        
    endcase
end
endmodule