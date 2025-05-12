module bsg_mul_SDN #(parameter width_p=16, parameter rows_lp=width_p/2+1)
   (input    [width_p-1:0]       x_i,       
    , input                     signed_i,   
    , output [rows_lp-1:0][2:0] SDN_o       
    );
   wire [width_p+3-1:0] temp_x = { 2'b0, x_i, 1'b0 };
   genvar      i;
   for (i = 0; i < rows_lp; i=i+1)
     begin: rof  
        wire [2:0] trip; 
        if (i != rows_lp-1)
          begin:fi
             assign trip = temp_x[2*i+2:2*i];
          end
        else 
          begin:fi
             assign trip = temp_x[2*i+2:2*i] & ~{ 3 { signed_i } };
          end
        assign SDN_o[i][0] = trip[2];
        assign SDN_o[i][1] = ((& trip[1:0]) & ~trip[2]) | (~(| trip[1:0]) & trip[2]);
        assign SDN_o[i][2] =  trip[0] ^ trip[1];
     end
endmodule