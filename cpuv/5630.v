module elevator_car_driver(clear,current_floor,direction,destination,clock); 
     output reg [4:0] current_floor; 
     output reg [9:0] clear; 
     input direction; 
     input [4:0] destination; 
     input clock; 
     reg [4:0] counter; 
     initial begin 
         current_floor <= 0; 
         counter <= 0; 
     end
     always @(posedge clock) begin 
         current_floor <= counter; 
     end
     always @(posedge clock) begin 
         if ( counter != destination ) begin 
             clear[counter] <= 0; 
             if (direction) 
                 counter = counter + 1; 
             else 
                  counter = counter - 1; 
         end
         else 
             clear[counter] <= 1; 
     end
endmodule 