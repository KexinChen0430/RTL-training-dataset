
module nukv_Read  #(parameter 
       KEY_WIDTH      = 128,
       META_WIDTH     = 96,
       HASHADDR_WIDTH = 32,
       MEMADDR_WIDTH  = 20)
  (input  wire clk,
   input  wire rst,
   input  wire [((KEY_WIDTH+META_WIDTH)+HASHADDR_WIDTH)+(-1):0] input_data,
   input  wire input_valid,
   output wire input_ready,
   input  wire [((KEY_WIDTH+META_WIDTH)+HASHADDR_WIDTH)+(-1):0] feedback_data,
   input  wire feedback_valid,
   output wire feedback_ready,
   output reg [((KEY_WIDTH+META_WIDTH)+HASHADDR_WIDTH)+(-1):0] output_data,
   output reg output_valid,
   input  wire output_ready,
   output reg [31:0] rdcmd_data,
   output reg rdcmd_valid,
   input  wire rdcmd_ready);

  reg  selectInputNext;
  reg  selectInput;
  localparam [1<<<1:0]  ST_IDLE = 0, ST_ISSUE_READ = 3, ST_OUTPUT_KEY = 4;
  reg  [1<<<1:0] state;
  wire [((KEY_WIDTH+META_WIDTH)+HASHADDR_WIDTH)+(-1):0] in_data;
  wire in_valid;
  reg  in_ready;
  wire [31:0] hash_data;

  assign in_data = (selectInput == 1) ? input_data : feedback_data;
  assign in_valid = (selectInput == 1) ? input_valid : feedback_valid;
  assign input_ready = (selectInput == 1) ? in_ready : 0;
  assign feedback_ready = (selectInput == 1) ? 0 : in_ready;
  assign hash_data = (selectInput == 1) ? input_data[((KEY_WIDTH+META_WIDTH)+HASHADDR_WIDTH)+(-1):KEY_WIDTH+META_WIDTH] : feedback_data[((KEY_WIDTH+META_WIDTH)+HASHADDR_WIDTH)+(-1):KEY_WIDTH+META_WIDTH];
  wire [MEMADDR_WIDTH+(-1):0] addr;

  assign addr = (((((hash_data[31:(0-MEMADDR_WIDTH)+32] | ((hash_data[31:(0-MEMADDR_WIDTH)+32] | ~hash_data[31:(0-MEMADDR_WIDTH)+32]) & hash_data[MEMADDR_WIDTH+(-1):0])) & ~hash_data[31:(0-MEMADDR_WIDTH)+32]) | (hash_data[31:(0-MEMADDR_WIDTH)+32] | ~hash_data[31:(0-MEMADDR_WIDTH)+32])) & hash_data[MEMADDR_WIDTH+(-1):0]) & (hash_data[31:(0-MEMADDR_WIDTH)+32] | ((hash_data[31:(0-MEMADDR_WIDTH)+32] | ~hash_data[31:(0-MEMADDR_WIDTH)+32]) & hash_data[MEMADDR_WIDTH+(-1):0]))) ^ ((hash_data[31:(0-MEMADDR_WIDTH)+32] & (((hash_data[31:(0-MEMADDR_WIDTH)+32] | ((hash_data[31:(0-MEMADDR_WIDTH)+32] | ~hash_data[31:(0-MEMADDR_WIDTH)+32]) & hash_data[MEMADDR_WIDTH+(-1):0])) & ~hash_data[31:(0-MEMADDR_WIDTH)+32]) | (hash_data[31:(0-MEMADDR_WIDTH)+32] | ~hash_data[31:(0-MEMADDR_WIDTH)+32]))) & (hash_data[31:(0-MEMADDR_WIDTH)+32] | ((hash_data[31:(0-MEMADDR_WIDTH)+32] | ~hash_data[31:(0-MEMADDR_WIDTH)+32]) & hash_data[MEMADDR_WIDTH+(-1):0])));
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            selectInput <= 1;
            selectInputNext <= 0;
            state <= ST_IDLE;
            in_ready <= 0;
            rdcmd_valid <= 0;
            output_valid <= 0;
          end
        else 
          begin
            if ((rdcmd_valid == 1) && (rdcmd_ready == 1)) 
              begin
                rdcmd_valid <= 0;
              end
              
            if ((output_valid == 1) && (output_ready == 1)) 
              begin
                output_valid <= 0;
              end
              
            in_ready <= 0;
            case (state)

              ST_IDLE: begin
                    if ((rdcmd_ready == 1) && (output_ready == 1)) 
                      begin
                        selectInput <= selectInputNext;
                        selectInputNext <= ~selectInputNext;
                        if ((selectInputNext == 1) && (input_valid == 0) && 
                            (feedback_valid == 1)) 
                          begin
                            selectInput <= 0;
                            selectInputNext <= 1;
                          end
                          
                        if ((input_valid == 1) && 
                            ((feedback_valid == 0) && (selectInputNext == 0))) 
                          begin
                            selectInput <= 1;
                            selectInputNext <= 0;
                          end
                          
                        if (((feedback_valid == 1) && (selectInput == 0)) || 
                            (
((input_valid == 1) && 
((feedback_valid == 1) && (selectInput == 0))) || 
(
((input_valid == 1) && 
((feedback_valid == 1) && (selectInput == 0))) || 
((selectInput == 1) && 
((feedback_valid == 1) && (input_valid == 1))) || 
(((selectInput == 0) || (selectInput == 1)) && 
(input_valid == 1) && (selectInput == 1) && 
((input_valid == 1) && 
((selectInput == 1) || (feedback_valid == 1))))))) 
                          begin
                            state <= ST_ISSUE_READ;
                          end
                          
                      end
                      
                  end

              ST_ISSUE_READ: begin
                    if (in_data[(0-4)+(KEY_WIDTH+META_WIDTH)] == 1) 
                      begin

                      end
                    else 
                      begin
                        rdcmd_data <= addr;
                        rdcmd_valid <= 1;
                        rdcmd_data[31:MEMADDR_WIDTH] <= 0;
                      end
                    state <= ST_OUTPUT_KEY;
                    output_data <= in_data;
                    output_data[((KEY_WIDTH+META_WIDTH)+HASHADDR_WIDTH)+(-1):KEY_WIDTH+META_WIDTH] <= addr;
                    in_ready <= 1;
                  end

              ST_OUTPUT_KEY: begin
                    if (output_ready == 1) 
                      begin
                        output_valid <= 1;
                        state <= ST_IDLE;
                      end
                      
                  end

            endcase

          end
      end
endmodule

