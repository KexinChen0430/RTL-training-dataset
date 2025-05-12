module jt51_lin2exp(
  input      [15:0] lin, 
  output reg [9:0] man,  
  output reg [2:0] exp   
);
always @(*) begin
  casez( lin[15:9] )
    7'b10?????: begin 
        man = lin[15:6]; 
        exp = 3'd7;      
      end
    7'b110????: begin 
        man = lin[14:5]; 
        exp = 3'd6;      
      end
    7'b01?????: begin 
        man = lin[15:6]; 
        exp = 3'd7;      
      end
    7'b001????: begin 
        man = lin[14:5]; 
        exp = 3'd6;      
      end
    default: begin
        man = lin[9:0]; 
        exp = 3'd1;     
      end
  endcase
end
endmodule