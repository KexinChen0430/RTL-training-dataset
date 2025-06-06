
module MemoryAddressHandler  #(parameter 
       WORD_SIZE           = 32,
       KERNEL_STACK_TOP    = 6144,
       KERNEL_STACK_BOTTOM = 7167,
       USER_STACK_TOP      = 7168,
       USER_STACK_BOTTOM   = 8191,
       MAX_NUMBER          = 32'hffffffff)
  (input  is_kernel,should_branch,reset,
   input  [2:0] control,
   input  [WORD_SIZE-1:0] ALU_result,current_PC,current_SP,
   output reg [WORD_SIZE-1:0] next_SP,output_address,
   output reg [WORD_SIZE-1:0] final_result,next_PC,
   output [WORD_SIZE-1:0] instruction_address);

  wire [WORD_SIZE-1:0] incr_pc,r_incr_pc;

  assign incr_pc = 1+current_PC;
  assign r_incr_pc = reset ? 1 : incr_pc;
  assign instruction_address = reset ? 0 : current_PC;
  wire [WORD_SIZE-1:0] top_stack,bottom_stack;

  assign top_stack = is_kernel ? KERNEL_STACK_TOP : USER_STACK_TOP;
  assign bottom_stack = is_kernel ? KERNEL_STACK_BOTTOM : USER_STACK_BOTTOM;
  
  always @(*)
      begin
        case (control)

          1: begin
                next_SP = (current_SP > top_stack) ? ((-1)+current_SP) : top_stack;
                output_address = next_SP;
                next_PC = r_incr_pc;
                final_result = ALU_result;
              end

          2: begin
                next_SP = (current_SP < bottom_stack) ? (1+current_SP) : bottom_stack;
                output_address = current_SP;
                next_PC = r_incr_pc;
                final_result = ALU_result;
              end

          3: begin
                next_SP = ALU_result;
                output_address = ALU_result;
                next_PC = r_incr_pc;
                final_result = ALU_result;
              end

          4: begin
                next_PC = reset ? 1 : 
                          should_branch ? ALU_result : incr_pc;
                final_result = incr_pc;
                next_SP = current_SP;
                output_address = ALU_result;
              end

          default: begin
                next_PC = r_incr_pc;
                final_result = ALU_result;
                output_address = ALU_result;
                next_SP = (current_SP == 0) ? bottom_stack : current_SP;
              end

        endcase

      end
endmodule

