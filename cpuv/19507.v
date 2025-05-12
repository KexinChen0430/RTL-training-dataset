module output_demux #(parameter C_FSM_SWITCH_WIDTH=20, C_INTERFACE=0)(
    input [4:0] sel,                         
    input in_pin,                            
    output reg [C_FSM_SWITCH_WIDTH-1:0] out_pin 
    );
    generate
    case (C_INTERFACE)                        
       0: begin: ARDUINO                      
                 always @(sel, in_pin)        
                   begin
                       out_pin = 20'h00000;   
                       case(sel)              
                           5'h00 : out_pin[0] = in_pin;
                           5'h01 : out_pin[1] = in_pin;
                           5'h13 : out_pin[19] = in_pin;
                       endcase
                   end
                 end
       1: begin: RASPBERRYPI                  
                 always @(sel, in_pin)        
                   begin
                       out_pin = 26'h00000;   
                       case(sel)              
                           5'h00 : out_pin[0] = in_pin;
                           5'h19 : out_pin[25] = in_pin;
                       endcase
                   end
                  end
       default: begin: ARDUINO                 
                       always @(sel, in_pin)  
                       begin
                           out_pin = 20'h00000; 
                           case(sel)            
                               5'h00 : out_pin[0] = in_pin;
                               5'h13 : out_pin[19] = in_pin;
                           endcase
                       end
                end
    endcase
    endgenerate
endmodule