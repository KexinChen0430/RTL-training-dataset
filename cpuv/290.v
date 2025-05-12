module control(
 input wire clk,              
 input wire en,               
 input wire rst,              
 input wire en_mem,           
 input wire mem_wait,         
 input wire should_branch,    
 input wire imm,              
 output reg [`CONTROL_BIT_MAX:0] control_o, 
 output reg [1:0] pc_op       
);
   localparam
     RST = 0,        
     FETCH = 4'h1,   
     DECODE = 4'h2,  
     REG_READ = 4'h3,
     ALU = 4'h4,     
     MEM = 4'h5,     
     REG_WR = 4'h6,  
     PC_DELAY = 4'h7,
     MEM_DELAY = 4'h8;
   reg [3:0] state, next_state;
   always @(posedge clk) begin
      if(rst)
	state <= RST; 
      else if(en)
	state <= next_state; 
   end
   always @(*) begin
      control_o <= 0; 
	case(state)
	  FETCH:
	    control_o[`BIT_FETCH] <= 1; 
	  DECODE:
	    control_o[`BIT_DECODE] <= 1; 
	  REG_READ:
	    control_o[`BIT_REG_READ] <= 1; 
	  ALU:
	    control_o[`BIT_ALU] <= 1; 
	  REG_WR:begin
	     if(!should_branch)
	       control_o[`BIT_FETCH] <= 1; 
	     control_o[`BIT_REG_WR] <= 1; 
	     end
	  MEM:
	    control_o[`BIT_MEM] <= 1; 
	  PC_DELAY:
	    control_o[`BIT_PC_DELAY] <= 1; 
	  default:
	    control_o <= 0; 
	endcase
   end
   always @(*) begin
      pc_op <= `PC_NOP; 
      case(state)
	RST:
	  pc_op <= `PC_RESET; 
        REG_READ:
	  if(imm)
	    pc_op <= `PC_INC; 
	FETCH:
	  pc_op <= `PC_INC; 
	REG_WR:
	  if(!should_branch)
	    pc_op <= `PC_INC; 
	  else
	    pc_op <= `PC_SET; 
      endcase
   end
   always @(*) begin
      case(state)
	FETCH:
	  next_state <= DECODE; 
	DECODE:
	  next_state <= REG_READ; 
	REG_READ:
	  next_state <= ALU; 
	ALU:
	   if(en_mem)
	     next_state <= MEM; 
	   else
	     next_state <= REG_WR; 
	MEM:
	  if(mem_wait)
	    next_state <= MEM; 
	  else
	    next_state <= MEM_DELAY; 
	REG_WR:
	  if(should_branch)
	    next_state <= PC_DELAY; 
	  else
	    next_state <= DECODE; 
	PC_DELAY:
	  next_state <= FETCH; 
	MEM_DELAY:
	  next_state <= REG_WR; 
	default:
	  next_state <= FETCH; 
      endcase
   end
   reg [71:0] state_ascii;
   always @(state) begin
       case (state)
	 RST:       state_ascii = "rst      ";
	 FETCH:     state_ascii = "fetch    ";
	 DECODE:    state_ascii = "decode   ";
	 REG_READ:  state_ascii = "reg_read ";
	 ALU:       state_ascii = "alu      ";
	 MEM:       state_ascii = "mem      ";
	 REG_WR:    state_ascii = "reg_wr   ";
	 PC_DELAY:  state_ascii = "pc_delay ";
	 MEM_DELAY: state_ascii = "mem_delay";
	 default:   state_ascii = "%Error   "; 
       endcase
   end
endmodule 