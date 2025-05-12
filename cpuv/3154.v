module Print(CLK, TYPE, DIS, AN, display);
  input CLK, TYPE, DIS; 
  output reg [3:0] AN;  
  output reg [7:0] display;  
  reg [31:0] counter;  
  reg [31:0] move_counter;  
  parameter [31:0] MAX_COUNTER = 5_0000;  
  parameter [31:0] MAX_MOVE_COUNTER = 1_0000_0000;  
  parameter [31:0] ID = 32'H16340040;  
  reg [15:0] num;  
  reg [4:0] tmp;  
  initial begin
    AN = 4'B0111; 
    display = 8'B0000_0000; 
    counter = 0; 
    move_counter = MAX_MOVE_COUNTER + 1; 
    num = ID[15:0]; 
  end
  always@(AN) begin
    case(AN)
      4'B0111: tmp = num[15:12]; 
      4'B1011: tmp = num[11:8];  
      4'B1101: tmp = num[7:4];   
      4'B1110: tmp = num[3:0];   
    endcase
    case(tmp)
      4'H0: display = 8'B0000_0011;
      4'H1: display = 8'B1001_1111;
      4'Hf: display = 8'B1111_1111;  
    endcase
  end
  always@(posedge CLK) begin
    counter = counter + 1; 
    if(counter == MAX_COUNTER) begin
      AN = (AN >> 1) + 4'B1000; 
      counter = 0; 
    end
    if(AN == 4'B1111) begin
      AN = 4'B0111; 
    end
    if(TYPE == 1) begin
      if(move_counter == MAX_MOVE_COUNTER + 1) begin
        num = ID[31:16];
        move_counter = 0; 
      end
      move_counter = move_counter + 1; 
      if(move_counter == MAX_MOVE_COUNTER) begin
        move_counter = 0; 
      end
    end else begin
      case(DIS)
        0: num = ID[15:0];  
        1: num = ID[31:16]; 
      endcase
      move_counter = MAX_MOVE_COUNTER + 1; 
    end
  end
endmodule