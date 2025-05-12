module pc_next (clk, reset, pc_new, take_branch, pause_in,
                opcode25_0, pc_source, pc_out, pc_out_plus4);
    input         clk;           
    input         reset;         
    input  [31:2] pc_new;        
    input         take_branch;   
    input         pause_in;      
    input  [25:0] opcode25_0;    
    input  [ 1:0] pc_source;     
    output [31:0] pc_out;        
    output [31:0] pc_out_plus4;  
    reg[31:2] pc_next;           
    reg[31:2] pc_reg;            
    wire [31:2] pc_inc = pc_reg + 1; 
    wire   [31:0] pc_out       = {pc_reg, 2'b00} ; 
    wire   [31:0] pc_out_plus4 = {pc_inc, 2'b00} ; 
    always @(posedge clk or posedge reset)
    begin
       if (reset)
          pc_reg <= `PC_RESET; 
       else
          pc_reg <= pc_next;   
    end
    always @(pc_source or pc_inc or pc_reg or opcode25_0 or
             take_branch or pc_new or pause_in)
    begin
       case (pc_source) 
          `from_inc4         : pc_next = pc_inc; 
          `from_opcode25_0   : pc_next = {pc_reg[31:28], opcode25_0}; 
          default : begin 
             if (take_branch)  pc_next = pc_new; 
             else              pc_next = pc_inc; 
          end
       endcase
       if (pause_in == 1'b1) 
       begin
          pc_next = pc_reg; 
       end
    end
endmodule 