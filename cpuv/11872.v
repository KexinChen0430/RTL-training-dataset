module ceespu_alu(
  input I_clk, 
  input I_rst, 
  input [31:0] I_dataA, 
  input [31:0] I_dataB, 
  input I_Cin, 
  input [3:0] I_aluop, 
  output reg O_multiCycle = 0, 
  output reg [31:0] O_adderResult, 
  output reg [31:0] O_dataResult, 
  output reg O_Cout, 
  output O_dataReady 
);
always @* begin
  O_multiCycle  = 0; 
  O_adderResult = I_dataA + I_dataB + I_Cin; 
  case(I_aluop)
    default: 
    begin
      {O_Cout, O_dataResult} = I_dataA + I_dataB + I_Cin; 
    end
    4'd1: 
    begin
      O_dataResult = I_dataA | I_dataB; 
      O_Cout = 0; 
    end
    4'd2: 
    begin
      O_dataResult = I_dataA & I_dataB; 
      O_Cout = 0; 
    end
    4'd3: 
    begin
      O_dataResult = I_dataA ^ I_dataB; 
      O_Cout = 0; 
    end
    4'd4: 
    begin
      O_dataResult = {{(24){I_dataA[7]}}, I_dataA[7:0]}; 
      O_Cout = 0; 
    end
    4'd5: 
    begin
      O_dataResult = {{(16){I_dataA[15]}}, I_dataA[15:0]}; 
      O_Cout = 0; 
    end
    4'd6: 
    begin
      O_dataResult = I_dataA << I_dataB[4:0]; 
      O_Cout = 0; 
    end
    4'd7: 
    begin
      O_dataResult = I_dataA >> I_dataB[4:0]; 
      O_Cout = 0; 
    end
    4'd8: 
    begin
      O_dataResult = I_dataA >>> I_dataB[4:0]; 
      O_Cout = 0; 
    end
    4'd9: 
    begin
      O_multiCycle = 1; 
      O_dataResult = mul_result; 
      O_Cout = 0; 
    end
  endcase
end
reg [1:0]  mul_counter = 0; 
reg [31:0] mul_result; 
reg [31:0] mul_tmp1; 
reg [31:0] a_in; 
reg [31:0] b_in; 
assign O_dataReady = O_multiCycle && (mul_counter == 2);
always @(posedge I_clk) begin
  if(I_rst) begin 
    a_in  <= 0; 
    b_in  <= 0; 
    mul_tmp1 <= 0; 
    mul_result  <= 0; 
    mul_counter <= 0; 
  end
  else begin 
    a_in  <= I_dataA; 
    b_in  <= I_dataB; 
    mul_tmp1 <= a_in * b_in; 
    mul_result <= mul_tmp1; 
    if (mul_counter == 3 || O_dataReady)
      mul_counter  <= 0; 
    else if (O_multiCycle)
      mul_counter  <= mul_counter + 1; 
  end
end
endmodule 